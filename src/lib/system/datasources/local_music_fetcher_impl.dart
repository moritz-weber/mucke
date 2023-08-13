import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:async_task/async_task.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:mucke/system/datasources/drift_database.dart';
import 'package:mucke/system/models/default_values.dart';
import 'package:mucke/system/utils.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/song_model.dart';
import 'local_music_fetcher.dart';
import 'music_data_source_contract.dart';
import 'settings_data_source.dart';

class LocalMusicFetcherImpl implements LocalMusicFetcher {
  LocalMusicFetcherImpl(this._settingsDataSource, this._musicDataSource);

  static final _log = FimberLog('LocalMusicFetcher');

  final SettingsDataSource _settingsDataSource;
  final MusicDataSource _musicDataSource;

  @override
  Future<Map<String, List>> getLocalMusic() async {
    // FIXME: it seems that songs currently loaded in queue are not updated

    final musicDirectories =
        await _settingsDataSource.libraryFoldersStream.first;
    final libDirs = musicDirectories.map((e) => Directory(e));

    final extString = await _settingsDataSource.fileExtensionsStream.first;
    final allowedExtensions = getExtensionSet(extString);
    final blockedPaths = await _musicDataSource.blockedFilesStream.first;

    final hasStorageAccess = await Permission.storage.isGranted;
    if (!hasStorageAccess) {
      await Permission.storage.request();
      if (!await Permission.storage.isGranted) {
        return {};
      }
    }

    final List<File> songFiles = [];

    for (final libDir in libDirs) {
      final List<File> files = await getSongFilesInDirectory(libDir.path, allowedExtensions, blockedPaths);
      songFiles.addAll(files);
    }

    _log.d('Found ${songFiles.length} songs');


    final albumsInDb = await getSortedAlbums();
    int newAlbumId = albumsInDb.isNotEmpty ? albumsInDb.last.id + 1 : 0;
    _log.d('New albums start with id: $newAlbumId');

    final artistsInDb = await getSortedArtists();
    int newArtistId = artistsInDb.isNotEmpty ? artistsInDb.last.id + 1 : 0;
    _log.d('New artists start with id: $newArtistId');


    final List<File> songFilesToCheck = await getSongFilesToCheck(songFiles);

    final existingSongFiles = songFiles.where((element) => !songFilesToCheck.contains(element)).toList();
    final structs = await mapSongsAlreadyScanned(existingSongFiles, albumsInDb, artistsInDb);
    final songs = structs['songs'] as List<SongModel>;
    final albums = structs['albums'] as List<AlbumModel>;
    final artists = structs['artists'] as Set<ArtistModel>;

    final albumIdMap = structs['albumIdMap'] as Map<String, int>;
    final albumArtMap = structs['albumArtMap'] as Map<int, String>;
    final colorMap = structs['colorMap'] as Map<int, Color?>;

    final songsToCheck = await getMetadataForFiles(songFilesToCheck);

    for (final (songFile, songData) in songsToCheck) {
      _log.i('Scanning Song ${songFile.path}');

      final lastModified = songFile.lastModifiedSync();

      final albumArtist = songData.albumArtist;
      final albumString = '${songData.album}___${albumArtist}___${songData.year}';

      if (albumIdMap.containsKey(albumString)) {
        final albumId = albumIdMap[albumString]!;
        // TODO: Potential improvement. If albumArtMap does not contain an entry for this album yet
        // we could test if the current song has a picture. The way it is now if the first SongFile in an album
        // scanned has no picture, the whole album has no Picture.

        songs.add(
          SongModel.fromMetadata(
            path: songFile.path,
            songData: songData,
            albumId: albumId,
            albumArtPath: albumArtMap[albumId],
            color: colorMap[albumId],
            lastModified: lastModified,
          ),
        );
        continue;
      }

      final albumId = await getAlbumId(newAlbumId, songData.album, albumArtist, songData.year);
      albumIdMap[albumString] = albumId;
      newAlbumId = max(newAlbumId, albumId + 1);

      final albumArt = songData.picture;

      if (albumArt != null) {
        final (path, color) = await cacheAlbumArt(albumArt, albumId);
        albumArtMap[albumId] = path;
        colorMap[albumId] = color;
      }

      final String? songArtist = songData.artist;
      final String artistName =
          albumArtist ?? (songArtist ?? DEF_ARTIST);

      final artist = artistsInDb.firstWhereOrNull((a) => a.name == artistName);
      if (artist != null) 
        artists.add(artist);
      if (artists.none((a) => a.name == artistName)) {
        // artist is also not in the set already
        artists.add(ArtistModel(name: artistName, id: newArtistId++));
      }

      albums.add(
        AlbumModel.fromMetadata(
          songData: songData,
          albumId: albumId, 
          albumArtPath: albumArtMap[albumId], 
          color: colorMap[albumId]
        )
      );
      songs.add(
        SongModel.fromMetadata(
          path: songFile.path,
          songData: songData,
          albumId: albumId,
          lastModified: lastModified,
          albumArtPath: albumArtMap[albumId],
          color: colorMap[albumId],
        )
      );

    }


    return {
      'SONGS': songs,
      'ALBUMS': albums,
      'ARTISTS': artists.toList(),
    };
  }

  Future<List<File>> getSongFilesInDirectory(
      String path,
      Set<String> allowedExtensions,
      Set<String> blockedPaths
    ) async {
    return Directory(path)
        .list(recursive: true, followLinks: false)
        .where((item) => FileSystemEntity.isFileSync(item.path))
        .where((item) => !blockedPaths.contains(item.path))
        .where((item) {
          final extension = p.extension(item.path).toLowerCase().substring(1);
          return allowedExtensions.contains(extension);
        })
        .asyncMap((item) => File(item.path))
        .toList();
  }

  // Returns a list of all new song files and files that have changed since they where last imported
  Future<List<File>> getSongFilesToCheck(List<File> songFiles) async {
    final List<File> songFilesToCheck = [];

    for (final songFile in songFiles) {
      final lastModified = songFile.lastModifiedSync();
      final song = await _musicDataSource.getSongByPath(songFile.path);

      if (song == null || lastModified.isAfter(song.lastModified))
        songFilesToCheck.add(songFile);
    }

    return songFilesToCheck;
  }


  Future<List<ArtistModel>> getSortedArtists() async {
    return (await _musicDataSource.artistStream.first)
      ..sort((a, b) => a.id.compareTo(b.id));
  }

  Future<List<AlbumModel>> getSortedAlbums() async {
    return (await _musicDataSource.albumStream.first)
      ..sort((a, b) => a.id.compareTo(b.id));
  }

  Future<int> getAlbumId(int newAlbumId, String? album, String? albumArtist, int? year) async {
    return await _musicDataSource.getAlbumId(album, albumArtist, year) ?? newAlbumId++;
  }

  Future<(String, Color?)> cacheAlbumArt(Picture albumArt, int albumId) async {
    final Directory dir = await getApplicationSupportDirectory();
    final albumArtPath = '${dir.path}/$albumId';
    final file = File(albumArtPath);
    file.writeAsBytesSync(albumArt.data);

    final color = await getBackgroundColor(FileImage(file));
    return (albumArtPath, color);
  }

  // Maps all the songs that where scanned previously, and their Albums and Artists to the new data structures
  Future<Map<String, dynamic>> mapSongsAlreadyScanned(
    List<File> songFiles, 
    List<AlbumModel> albumsInDb, 
    List<ArtistModel> artistsInDb
  ) async {
    final List<SongModel> songs = [];
    final List<AlbumModel> albums = [];
    final Set<ArtistModel> artists = {};

    final Map<String, int> albumIdMap = {};
    final Map<int, String> albumArtMap = {};
    /// album id, background color
    final Map<int, Color?> colorMap = {};

    for (final songFile in songFiles) {
      final song = (await _musicDataSource.getSongByPath(songFile.path))!;

      final album = albumsInDb.singleWhere((a) => a.id == song.albumId);
      final albumString = '${album.title}___${album.artist}__${album.pubYear}';

      if (albumIdMap.containsKey(albumString)) {
        // we already encountered the album (at least by albumString)
        // make sure the id is consistent
        if (album.id != albumIdMap[albumString]) 
          songs.add(
            song.copyWith(
              albumId: albumIdMap[albumString],
              color: colorMap[albumIdMap[albumString]],
            ),
          );
      } else {
        Color? color;
        albumIdMap[albumString] = album.id;

        if (album.albumArtPath != null) {
          albumArtMap[album.id] = album.albumArtPath!;
          if (album.color == null) {
            // we have an album cover, but no color -> try to get one
            color = await getBackgroundColor(FileImage(File(album.albumArtPath!)));
            colorMap[album.id] = color;
          } 
          else 
            colorMap[album.id] = album.color;
          
        }
        albums.add(album.copyWith(color: color));
        final artist = artistsInDb.singleWhere((a) => a.name == album.artist);
        artists.add(artist);

        songs.add(song.copyWith(color: colorMap[album.id]));
      }
    }
    return {
      'songs': songs, 
      'albums': albums, 
      'artists': artists,
      'albumIdMap': albumIdMap, 
      'albumArtMap': albumArtMap, 
      'colorMap': colorMap
    };
  }


  Future<List<(File, Metadata)>> getMetadataForFiles(
      List<File> filesToCheck) async {
    final List<(File, Metadata)> songsMetadata = [];

    final tasks = filesToCheck.map((e) => MetadataLoader(e));

    final asyncExecutor = AsyncExecutor(
      sequential: false,
      parallelism: max(Platform.numberOfProcessors - 1, 1),
      taskTypeRegister: _taskTypeRegister,
    );

    asyncExecutor.logger.enabled = true;

    final executions = asyncExecutor.executeAll(tasks);

    await Future.wait(executions);

    for (final execution in executions) {
      final result = await execution;
      songsMetadata.add(result);
    }

    asyncExecutor.close();

    return songsMetadata;
  }

  Set<String> getExtensionSet(String extString) {
    List<String> extensions = extString.toLowerCase().split(',');
    extensions = extensions.map((e) => e.trim()).toList();
    extensions = extensions.whereNot((element) => element.isEmpty).toList();
    return Set<String>.from(extensions);
  }

  Future<List<File>> getAllFilesRecursively(String path) async {
    final List<File> files = [];
    if (FileSystemEntity.isDirectorySync(path)) {
      final dir = Directory(path);
      await for (final entity
          in dir.list(recursive: true, followLinks: false)) {
        files.addAll(await getAllFilesRecursively(entity.path));
      }
    } else if (FileSystemEntity.isFileSync(path)) {
      files.add(File(path));
    }
    return files;
  }
}

List<AsyncTask> _taskTypeRegister() => [MetadataLoader(File(''))];

class MetadataLoader extends AsyncTask<File, (File, Metadata)> {
  MetadataLoader(this.file);

  final File file;

  @override
  AsyncTask<File, (File, Metadata)> instantiate(File parameters,
      [Map<String, SharedData>? sharedData]) {
    MetadataGod.initialize();
    return MetadataLoader(parameters);
  }

  @override
  File parameters() {
    return file;
  }

  @override
  FutureOr<(File, Metadata)> run() async {
    return (file, await MetadataGod.readMetadata(file: file.path));
  }
}
