import 'dart:io';

import 'package:audiotagger/audiotagger.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:path_provider/path_provider.dart';

import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/default_values.dart';
import '../models/song_model.dart';
import 'local_music_fetcher.dart';
import 'music_data_source_contract.dart';
import 'settings_data_source.dart';

class LocalMusicFetcherImpl implements LocalMusicFetcher {
  LocalMusicFetcherImpl(this._settingsDataSource, this._audiotagger, this._musicDataSource);

  static final _log = FimberLog('LocalMusicFetcher');

  final Audiotagger _audiotagger;
  final SettingsDataSource _settingsDataSource;
  final MusicDataSource _musicDataSource;

  @override
  Future<Map<String, List>> getLocalMusic() async {
    // FIXME: it seems that songs currently loaded in queue are not updated
    // example: when Brainwashed/Four Walls was loaded, the tags where not updated as opposed to the rest of the album

    final musicDirectories = await _settingsDataSource.libraryFoldersStream.first;
    final libDirs = musicDirectories.map((e) => Directory(e));

    final List<File> files = [];

    for (final libDir in libDirs) {
      await for (final entity in libDir.list(recursive: true, followLinks: false)) {
        if (entity is File && entity.path.endsWith('.mp3')) {
          files.add(entity);
        }
      }
    }

    final List<SongModel> songs = [];
    final List<AlbumModel> albums = [];
    final Map<String, int> albumIdMap = {};
    final Map<String, String> albumArtMap = {};
    final List<ArtistModel> artists = [];
    final Set<String> artistSet = {};

    final albumsInDb = (await _musicDataSource.albumStream.first)..sort((a, b) => a.id.compareTo(b.id));
    int newAlbumId = albumsInDb.isNotEmpty ? albumsInDb.last.id + 1 : 0;
    _log.d('New albums start with id: $newAlbumId');

    final Directory dir = await getApplicationSupportDirectory();
    int count = 1;
    final now1 = DateTime.now();

    for (final file in files.toSet()) {
      if (count % 10 == 0) _log.d('Files scanned: $count');
      count++;

      final fileStats = file.statSync();
      // changed includes the creation time
      // => also update, when the file was created later (and wasn't really changed)
      // this is used as a workaround because android
      // doesn't seem to return the correct modification time
      final lastModified = _dateMax(fileStats.modified, fileStats.changed);
      final song = await _musicDataSource.getSongByPath(file.path);

      int? albumId;
      String albumString;
      if (song != null) {
        if (!lastModified.isAfter(song.lastModified)) {
          // use existing songmodel
          songs.add(song);

          final album = albumsInDb.singleWhere((a) => a.id == song.albumId);
          albumString = '${album.title}___${album.artist}__${album.pubYear}';
          if (!albumIdMap.containsKey(albumString)) {
            albums.add(album);
            albumIdMap[albumString] = album.id;
            artistSet.add(album.artist);
          }
          continue;
        } else {
          // read new info but keep albumId
          albumId = song.albumId;
        }
      }
      // completely new song -> new album ids should start after existing ones
      final tags = await _audiotagger.readTags(path: file.path);
      final audioFile = await _audiotagger.readAudioFile(path: file.path);

      if (tags == null || audioFile == null) {
        _log.w('Could not read ${file.path}');
        continue;
      }
      albumString = '${tags.album}___${tags.albumArtist}__${tags.year}';

      String? albumArtPath;
      if (!albumIdMap.containsKey(albumString)) {
        albumId ??= newAlbumId++;
        albumIdMap[albumString] = albumId;

        final albumArt = await _audiotagger.readArtwork(path: file.path);

        if (albumArt != null && albumArt.isNotEmpty) {
          albumArtPath = '${dir.path}/$albumId';
          final file = File(albumArtPath);
          file.writeAsBytesSync(albumArt);
          albumArtMap[albumString] = albumArtPath;
        }

        albums.add(
          AlbumModel.fromAudiotagger(albumId: albumId, tag: tags, albumArtPath: albumArtPath),
        );
        final String albumArtist = tags.albumArtist ?? '';
        final String artist = tags.artist ?? '';
        artistSet.add(albumArtist != '' ? albumArtist : (artist != '' ? artist : DEF_ARTIST));
      } else {
        albumId = albumIdMap[albumString]!;
        albumArtPath = albumArtMap[albumString];
      }

      songs.add(
        SongModel.fromAudiotagger(
          path: file.path,
          tag: tags,
          audioFile: audioFile,
          albumId: albumId,
          albumArtPath: albumArtPath,
          lastModified: lastModified,
        ),
      );
    }

    for (final artist in artistSet) {
      artists.add(ArtistModel(name: artist));
    }

    _log.d(DateTime.now().difference(now1).toString());

    return {
      'SONGS': songs,
      'ALBUMS': albums,
      'ARTISTS': artists,
    };
  }
}

Future<List<String>> _readTags(Map<String, dynamic> args) async {
  final files = args['files'] as List<File>;
  final audiotagger = Audiotagger();
  final result = <String>[];

  for (final file in files) {
    print(file.path);
    final tags = await audiotagger.readTagsAsMap(path: file.path);
    // final audioFile = await audiotagger.readAudioFile(path: file.path);
    // if (audioFile != null) print(audioFile.bitRate.toString());
    if (tags != null) {
      if (tags['title'] != null) {
        result.add(tags['title'] as String);
      } else {
        print('NO TITLE!');
      }
    }
  }
  return result;
}

DateTime _dateMax(DateTime a, DateTime b) {
  if (a.isAfter(b)) return a;
  return b;
}