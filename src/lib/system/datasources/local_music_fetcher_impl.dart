import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/default_values.dart';
import '../models/song_model.dart';
import '../utils.dart';
import 'local_music_fetcher.dart';
import 'music_data_source_contract.dart';
import 'settings_data_source.dart';

const IMAGE_EXTENSIONS = ['jpg', 'jpeg', 'png'];

class LocalMusicFetcherImpl implements LocalMusicFetcher {
  LocalMusicFetcherImpl(this._settingsDataSource, this._musicDataSource);

  static final _log = FimberLog('LocalMusicFetcher');

  final SettingsDataSource _settingsDataSource;
  final MusicDataSource _musicDataSource;

  final BehaviorSubject<int?> _fileNumSubject = BehaviorSubject<int?>();
  final BehaviorSubject<int?> _progressSubject = BehaviorSubject<int?>();

  @override
  Future<Map<String, List>> getLocalMusic() async {
    // FIXME: it seems that songs currently loaded in queue are not updated
    _fileNumSubject.add(null);
    _progressSubject.add(null);

    final start = DateTime.now();
    final Set<File> songFiles = await _getSongFiles();
    _log.d('Found ${songFiles.length} song files');
    _fileNumSubject.add(songFiles.length);

    final List<SongModel> songs = [];
    final List<AlbumModel> albums = [];
    final Map<String, int> albumIdMap = {};
    final Map<int, String> albumArtMap = {};

    /// album id, background color
    final Map<int, Color?> colorMap = {};
    final Set<ArtistModel> artistSet = {};

    final songsInDb = Map<String, SongModel>.fromIterable(
      await _musicDataSource.songStream.first,
      key: (s) => (s as SongModel).path,
    );
    final albumsInDb = (await _musicDataSource.albumStream.first)
      ..sort((a, b) => a.id.compareTo(b.id));
    int newAlbumId = albumsInDb.isNotEmpty ? albumsInDb.last.id + 1 : 0;
    _log.d('New albums start with id: $newAlbumId');

    final Map<String, int> albumsInDbIdMap = {};
    for (final a in albumsInDb) {
      albumsInDbIdMap['${a.title}___${a.artist}__${a.pubYear}'] = a.id;
    }

    final artistsInDb = (await _musicDataSource.artistStream.first)
      ..sort((a, b) => a.id.compareTo(b.id));
    int newArtistId = artistsInDb.isNotEmpty ? artistsInDb.last.id + 1 : 0;
    _log.d('New artists start with id: $newArtistId');

    final Directory dir = await getApplicationSupportDirectory();

    int count = 0;
    for (final songFile in songFiles) {
      _log.d('${songFile.path}');
      _progressSubject.add(++count);

      // changed includes the creation time
      // => also update, when the file was created later (and wasn't really changed)
      // this is used as a workaround because android
      // doesn't seem to return the correct modification time
      final lastModified = songFile.lastModifiedSync();
      final song = songsInDb[songFile.path];

      int? albumId;
      String albumString;
      Color? color;
      if (song != null) {
        // the song is already known to the database
        _log.d('song exists');
        if (!lastModified.isAfter(song.lastModified)) {
          // file hasn't changed -> use existing songmodel
          _log.d('file not changed');
          await _handleUnchangedSong(song, albumsInDb, albumIdMap, albumArtMap, colorMap,
              artistsInDb, songs, albums, artistSet);
          continue;
        } else {
          // file has changed -> read new info but keep albumId
          albumId = song.albumId;
          _log.d('file changed');
        }
      }

      final Metadata songData;
      try {
        songData = await MetadataGod.readMetadata(file: songFile.path);
      } on FfiException {
        continue;
      }
      _log.d('read metadata');

      // completely new song -> new album ids should start after existing ones
      // this is new information
      // is the album ID still correct or do we find another album with the same properties?
      final String albumArtist = songData.albumArtist ?? '';
      albumString = '${songData.album}___${albumArtist}__${songData.year}';

      String? albumArtPath;
      if (!albumIdMap.containsKey(albumString)) {
        _log.d('new album');
        // we haven't seen an album with these properties in the files yet, but there might be an entry in the database
        // in this case, we should use the corresponding ID
        // use case for getAlbumId: song file was renamed -> not recognized, but album is still in db
        // thus: use old album id for "new" song
        albumId ??= albumsInDbIdMap[albumString] ?? newAlbumId++;
        albumIdMap[albumString] = albumId;

        Uint8List? albumArt = songData.picture?.data;
        if (albumArt == null) {
          // get directory of song and look for image files
          _log.d('search image file');
          final images = await songFile.parent
              .list(recursive: false, followLinks: false)
              .where((item) =>
                  FileSystemEntity.isFileSync(item.path) &&
                  IMAGE_EXTENSIONS.contains(p.extension(item.path).toLowerCase().substring(1)))
              .asyncMap((item) => File(item.path))
              .toList();
          if (images.isNotEmpty) albumArt = images.first.readAsBytesSync();
        }
        if (albumArt != null) {
          _log.d('process album art');
          albumArtPath = '${dir.path}/$albumId';
          final file = File(albumArtPath);
          file.writeAsBytesSync(albumArt);
          albumArtMap[albumId] = albumArtPath;

          color = await getBackgroundColor(FileImage(file));
          colorMap[albumId] = color;
        }

        _log.d('process artist');
        final String songArtist = songData.artist ?? '';
        final String artistName =
            albumArtist != '' ? albumArtist : (songArtist != '' ? songArtist : DEF_ARTIST);

        final artist = artistsInDb.firstWhereOrNull((a) => a.name == artistName);
        if (artist != null) {
          artistSet.add(artist);
        } else if (artistSet.firstWhereOrNull((a) => a.name == artistName) == null) {
          // artist is also not in the set already
          artistSet.add(ArtistModel(name: artistName, id: newArtistId++));
        }

        _log.d('add album');
        albums.add(
          AlbumModel.fromMetadata(
            albumId: albumId,
            songData: songData,
            albumArtPath: albumArtPath,
            color: color,
          ),
        );
      } else {
        // an album with the same properties is already stored in the list
        // use it's ID regardless of the old one stored in the songModel
        _log.d('album not new');
        albumId = albumIdMap[albumString]!;
        albumArtPath = albumArtMap[albumId];
        color = colorMap[albumId];
      }

      _log.d('add song');
      songs.add(
        SongModel.fromMetadata(
          path: songFile.path,
          songData: songData,
          albumId: albumId,
          albumArtPath: albumArtPath,
          color: color,
          lastModified: lastModified,
        ),
      );
    }

    _log.d('${DateTime.now().difference(start)}');

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

  @override
  ValueStream<int?> get fileNumStream => _fileNumSubject.stream;

  @override
  ValueStream<int?> get progressStream => _progressSubject.stream;

  Future<Set<File>> _getSongFiles() async {
    final musicDirectories = await _settingsDataSource.libraryFoldersStream.first;
    final libDirs = musicDirectories.map((e) => Directory(e));

    final extString = await _settingsDataSource.fileExtensionsStream.first;
    final allowedExtensions = getExtensionSet(extString);
    final blockedPaths = await _musicDataSource.blockedFilesStream.first;

    if (!await Permission.manageExternalStorage.isGranted) {
      await Permission.manageExternalStorage.request();
    }

    final hasStorageAccess = await Permission.storage.isGranted;
    if (!hasStorageAccess) {
      await Permission.storage.request();
      if (!await Permission.storage.isGranted) {
        return {};
      }
    }

    final Set<File> songFiles = {};

    for (final libDir in libDirs) {
      final Set<File> files = await Directory(libDir.path)
          .list(recursive: true, followLinks: false)
          .where((item) {
            final ext = p.extension(item.path).toLowerCase();
            return FileSystemEntity.isFileSync(item.path) &&
                ext.isNotEmpty &&
                allowedExtensions.contains(ext.substring(1)) &&
                !blockedPaths.contains(item.path);
          })
          .asyncMap((item) => File(item.path))
          .toSet();
      songFiles.addAll(files);
    }

    return songFiles;
  }

  Future<void> _handleUnchangedSong(
    SongModel song,
    List<AlbumModel> albumsInDb,
    Map<String, int> albumIdMap,
    Map<int, String> albumArtMap,
    Map<int, Color?> colorMap,
    List<ArtistModel> artistsInDb,
    List<SongModel> songs,
    List<AlbumModel> albums,
    Set<ArtistModel> artistSet,
  ) async {
    Color? color;
    // potentially slow, O(n)
    final album = albumsInDb.singleWhere((a) => a.id == song.albumId);
    final albumString = '${album.title}___${album.artist}__${album.pubYear}';

    if (!albumIdMap.containsKey(albumString)) {
      albumIdMap[albumString] = album.id;
      if (album.albumArtPath != null) {
        albumArtMap[album.id] = album.albumArtPath!;
        if (album.color == null) {
          // we have an album cover, but no color -> try to get one
          color = await getBackgroundColor(FileImage(File(album.albumArtPath!)));
          colorMap[album.id] = color;
        } else {
          colorMap[album.id] = album.color;
        }
      }
      albums.add(album.copyWith(color: color));
      final artist = artistsInDb.singleWhere((a) => a.name == album.artist);
      artistSet.add(artist);
    } else {
      // we already encountered the album (at least by albumString)
      // make sure the id is consistent
      if (album.id != albumIdMap[albumString]) {
        songs.add(
          song.copyWith(
            albumId: albumIdMap[albumString],
            color: colorMap[albumIdMap[albumString]],
          ),
        );
        return;
      }
    }
    songs.add(song.copyWith(color: colorMap[album.id]));
  }
}
