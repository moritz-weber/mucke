import 'dart:io';

import 'package:audiotagger/audiotagger.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:path_provider/path_provider.dart';

import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/default_values.dart';
import '../models/song_model.dart';
import 'local_music_fetcher.dart';
import 'settings_data_source.dart';

class LocalMusicFetcherImpl implements LocalMusicFetcher {
  LocalMusicFetcherImpl(this._settingsDataSource, this._audiotagger);

  static final _log = FimberLog('LocalMusicFetcher');

  final Audiotagger _audiotagger;
  final SettingsDataSource _settingsDataSource;

  @override
  Future<Map<String, List>> getLocalMusic() async {
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

    final Directory dir = await getApplicationSupportDirectory();
    int count = 1;
    for (final file in files.toSet()) {
      if (count % 10 == 0) _log.d('Files scanned: $count');
      count++;
      
      final tags = await _audiotagger.readTags(path: file.path);
      final audioFile = await _audiotagger.readAudioFile(path: file.path);

      if (tags == null || audioFile == null) {
        _log.i('Could not read ${file.path}');
        continue;
      }

      final albumString = '${tags.album}___${tags.albumArtist}__${tags.year}';

      int albumId;
      String? albumArtPath;
      if (!albumIdMap.containsKey(albumString)) {
        albumId = albumIdMap.length;
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
        ),
      );
    }

    for (final artist in artistSet) {
      artists.add(ArtistModel(name: artist));
    }

    return {
      'SONGS': songs,
      'ALBUMS': albums,
      'ARTISTS': artists,
    };
  }
}
