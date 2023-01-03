import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:on_audio_query/on_audio_query.dart' as aq;
import 'package:path_provider/path_provider.dart';

import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/default_values.dart';
import '../models/song_model.dart';
import 'local_music_fetcher.dart';
import 'music_data_source_contract.dart';
import 'settings_data_source.dart';

class LocalMusicFetcherImpl implements LocalMusicFetcher {
  LocalMusicFetcherImpl(this._settingsDataSource, this._musicDataSource, this._onAudioQuery);

  static final _log = FimberLog('LocalMusicFetcher');

  final aq.OnAudioQuery _onAudioQuery;
  final SettingsDataSource _settingsDataSource;
  final MusicDataSource _musicDataSource;

  @override
  Future<Map<String, List>> getLocalMusic() async {
    // FIXME: it seems that songs currently loaded in queue are not updated
    // example: when Brainwashed/Four Walls was loaded, the tags were not updated as opposed to the rest of the album

    final musicDirectories = await _settingsDataSource.libraryFoldersStream.first;
    final libDirs = musicDirectories.map((e) => Directory(e));

    final extString = await _settingsDataSource.fileExtensionsStream.first;
    final allowedExtensions = getExtensionSet(extString);
    final blockedPaths = await _musicDataSource.blockedFilesStream.first;

    final List<aq.SongModel> aqSongs = [];

    for (final libDir in libDirs) {
      await _onAudioQuery.scanMedia(libDir.path);
      aqSongs.addAll(await _onAudioQuery.querySongs(path: libDir.path));
    }

    final List<SongModel> songs = [];
    final List<AlbumModel> albums = [];
    final Map<String, int> albumIdMap = {};
    final Map<String, String> albumArtMap = {};
    final Set<ArtistModel> artistSet = {};

    final albumsInDb = (await _musicDataSource.albumStream.first)
      ..sort((a, b) => a.id.compareTo(b.id));
    int newAlbumId = albumsInDb.isNotEmpty ? albumsInDb.last.id + 1 : 0;
    _log.d('New albums start with id: $newAlbumId');

    final artistsInDb = (await _musicDataSource.artistStream.first)
      ..sort((a, b) => a.id.compareTo(b.id));
    int newArtistId = artistsInDb.isNotEmpty ? artistsInDb.last.id + 1 : 0;
    _log.d('New artists start with id: $newArtistId');

    final Directory dir = await getApplicationSupportDirectory();

    for (final aqSong in aqSongs.toSet()) {
      if (!allowedExtensions.contains(aqSong.fileExtension.toLowerCase())) continue;
      if (blockedPaths.contains(aqSong.data)) continue;
      
      final data = aqSong.getMap;
      // changed includes the creation time
      // => also update, when the file was created later (and wasn't really changed)
      // this is used as a workaround because android
      // doesn't seem to return the correct modification time
      final lastModified = DateTime.fromMillisecondsSinceEpoch((aqSong.dateModified ?? 0) * 1000);
      final song = await _musicDataSource.getSongByPath(aqSong.data);

      int? albumId;
      String albumString;
      if (song != null) {
        if (!lastModified.isAfter(song.lastModified)) {
          // file hasn't changed -> use existing songmodel

          final album = albumsInDb.singleWhere((a) => a.id == song.albumId);
          albumString = '${album.title}___${album.artist}__${album.pubYear}';
          if (!albumIdMap.containsKey(albumString)) {
            albums.add(album);
            albumIdMap[albumString] = album.id;
            if (album.albumArtPath != null) albumArtMap[albumString] = album.albumArtPath!;
            final artist = artistsInDb.singleWhere((a) => a.name == album.artist);
            artistSet.add(artist);
          } else {
            // we already encountered the album (at least by albumString)
            // make sure the id is consistent
            if (album.id != albumIdMap[albumString]) {
              songs.add(song.copyWith(albumId: albumIdMap[albumString]));
              continue;
            }
          }
          songs.add(song);
          continue;
        } else {
          // read new info but keep albumId
          albumId = song.albumId;
        }
      }
      // completely new song -> new album ids should start after existing ones
      // this is new information
      // is the album ID still correct or do we find another album with the same properties?
      final String albumArtist = data['album_artist'] as String? ?? '';
      final String year = data['year'] as String? ?? '';
      albumString = '${aqSong.album}___${albumArtist}__$year';

      String? albumArtPath;
      if (!albumIdMap.containsKey(albumString)) {
        // we haven't seen an album with these properties in the files yet, but there might be an entry in the database
        // in this case, we should use the corresponding ID
        albumId ??= await _musicDataSource.getAlbumId(
              aqSong.album,
              albumArtist,
              int.tryParse(year),
            ) ??
            newAlbumId++;
        albumIdMap[albumString] = albumId;

        final albumArt = await _onAudioQuery.queryArtwork(aqSong.albumId ?? -1, aq.ArtworkType.ALBUM, size: 640);

        if (albumArt != null && albumArt.isNotEmpty) {
          albumArtPath = '${dir.path}/$albumId';
          final file = File(albumArtPath);
          file.writeAsBytesSync(albumArt);
          albumArtMap[albumString] = albumArtPath;
        }

        final String songArtist = aqSong.artist ?? '';
        final String artistName =
            albumArtist != '' ? albumArtist : (songArtist != '' ? songArtist : DEF_ARTIST);

        final artist = artistsInDb.firstWhereOrNull((a) => a.name == artistName);
        if (artist != null) {
          artistSet.add(artist);
        } else if (artistSet.firstWhereOrNull((a) => a.name == artistName) == null) {
          // artist is also not in the set already
          artistSet.add(ArtistModel(name: artistName, id: newArtistId++));
        }

        albums.add(
          AlbumModel.fromOnAudioQuery(
              albumId: albumId, songModel: aqSong, albumArtPath: albumArtPath),
        );
      } else {
        // an album with the same properties is already stored in the list
        // use it's ID regardless of the old one stored in the songModel
        albumId = albumIdMap[albumString]!;
        albumArtPath = albumArtMap[albumString];
      }

      songs.add(
        SongModel.fromOnAudioQuery(
          path: aqSong.data,
          songModel: aqSong,
          albumId: albumId,
          albumArtPath: albumArtPath,
          lastModified: lastModified,
        ),
      );
    }

    return {
      'SONGS': songs,
      'ALBUMS': albums,
      'ARTISTS': artistSet.toList(),
    };
  }

  Set<String> getExtensionSet(String extString) {
    List<String> extensions = extString.toLowerCase().split(',');
    extensions = extensions.map((e) => e.trim()).toList();
    extensions = extensions.whereNot((element) => element.isEmpty).toList();
    return Set<String>.from(extensions);
  }
}
