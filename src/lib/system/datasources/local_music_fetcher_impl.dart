import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/default_values.dart';
import '../models/song_model.dart';
import '../utils.dart';
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

    final musicDirectories = await _settingsDataSource.libraryFoldersStream.first;
    final libDirs = musicDirectories.map((e) => Directory(e));

    final extString = await _settingsDataSource.fileExtensionsStream.first;
    final allowedExtensions = getExtensionSet(extString);
    final blockedPaths = await _musicDataSource.blockedFilesStream.first;



    final hasStorageAccess = await Permission.storage.isGranted;
    if(!hasStorageAccess) {
      await Permission.storage.request();
      if (!await Permission.storage.isGranted) {
        return {};
      }
    }


    final List<File> songFiles = [];

    for (final libDir in libDirs) {
      final List<File> files = await Directory(libDir.path)
                          .list(recursive: true, followLinks: false)
                          .where((item) => FileSystemEntity.isFileSync(item.path))
                          .where((item) => !blockedPaths.contains(item.path))
                          .where((item) {
                            final extension = p.extension(item.path).toLowerCase().substring(1);
                            return allowedExtensions.contains(extension);
                          })
                          .asyncMap((item) => File(item.path)).toList();
      songFiles.addAll(files);
    }

    _log.d('Found ${songFiles.length} songs');

    final List<SongModel> songs = [];
    final List<AlbumModel> albums = [];
    final Map<String, int> albumIdMap = {};
    final Map<int, String> albumArtMap = {};

    /// album id, background color
    final Map<int, Color?> colorMap = {};
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

    final List<File> songFilesToCheck = [];

    for (final songFile in songFiles.toSet()) {
      _log.d('Checking song: ${songFile.path}');

      // changed includes the creation time
      // => also update, when the file was created later (and wasn't really changed)
      // this is used as a workaround because android
      // doesn't seem to return the correct modification time
      final lastModified = songFile.lastModifiedSync();
      final song = await _musicDataSource.getSongByPath(songFile.path);

      String albumString;
      Color? color;
      if (song != null) {
        if (!lastModified.isAfter(song.lastModified)) {
          // file hasn't changed -> use existing songmodel

          final album = albumsInDb.singleWhere((a) => a.id == song.albumId);
          albumString = '${album.title}___${album.artist}__${album.pubYear}';

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
              continue;
            }
          }
          songs.add(song.copyWith(color: colorMap[album.id]));
          continue;
        } else {
          // read new info but keep albumId
          songFilesToCheck.add(songFile);
        }
      } else {
        songFilesToCheck.add(songFile);
      }
    }

    _log.d('${songFilesToCheck.length}');

    final List<(File, Metadata)> songsToCheck = [];

    final List<(ReceivePort, SendPort, Isolate)> isolates = [];

    for (var i = 0; i < Platform.numberOfProcessors - 1; i++) {
      final ReceivePort receivePort = ReceivePort();
      final ReceivePort sendPortReceivePort = ReceivePort();
      final isolate = await Isolate.spawn(loadMetadataFromFile, [sendPortReceivePort.sendPort, receivePort.sendPort]);
      final SendPort sendPort = await sendPortReceivePort.first as SendPort;
      isolates.add((receivePort, sendPort, isolate));
    }

    var i = 0;
    for (final songFile in songFilesToCheck) {
      isolates[i].$2.send(songFile);
      i++;
      i = i % isolates.length;
    }

    List<StreamSubscription<dynamic>> isolateSubscriptions = [];

    for (final (receivePort, _, isolate) in isolates) {
      _log.d('listening to $receivePort');
      final subscription = receivePort.listen((message) {
        if (message != null)
          songsToCheck.add(message as (File, Metadata));
      });
      
      isolateSubscriptions.add(subscription);

      isolate.kill(priority: Isolate.immediate);
    }

    // Remove all isolate subscriptions when they are no longer needed
    for (var subscription in isolateSubscriptions) {
      subscription.cancel();
    }


    for (final (songFile, songData) in songsToCheck) {
      final lastModified = songFile.lastModifiedSync();


      int? albumId;
      String albumString;
      Color? color;
      // completely new song -> new album ids should start after existing ones
      // this is new information
      // is the album ID still correct or do we find another album with the same properties?
      final String albumArtist = songData.albumArtist ?? '';
      albumString = '${songData.album}___${albumArtist}__${songData.year}';

      String? albumArtPath;
      if (!albumIdMap.containsKey(albumString)) {
        // we haven't seen an album with these properties in the files yet, but there might be an entry in the database
        // in this case, we should use the corresponding ID
        albumId ??= await _musicDataSource.getAlbumId(
              songData.album,
              albumArtist,
              songData.year,
            ) ??
            newAlbumId++;
        albumIdMap[albumString] = albumId;

        final albumArt = songData.picture;

        if (albumArt != null) {
          albumArtPath = '${dir.path}/$albumId';
          final file = File(albumArtPath);
          file.writeAsBytesSync(albumArt.data);
          albumArtMap[albumId] = albumArtPath;

          color = await getBackgroundColor(FileImage(file));
          colorMap[albumId] = color;
        }

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
        albumId = albumIdMap[albumString]!;
        albumArtPath = albumArtMap[albumId];
        color = colorMap[albumId];
      }

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

    return {
      'SONGS': songs,
      'ALBUMS': albums,
      'ARTISTS': artistSet.toList(),
    };
  }

  static void loadMetadataFromFile(List<dynamic> arguments) {
    MetadataGod.initialize();
    final SendPort receivePortSendPort = arguments[0] as SendPort;
    final SendPort sendPort = arguments[1] as SendPort;
    final ReceivePort receivePort = ReceivePort();
    receivePortSendPort.send(receivePort.sendPort);
    receivePort.listen((file) async {
        try {
          final metadata = await MetadataGod.readMetadata(file: (file as File).path);
          sendPort.send((file, metadata));
        } on FfiException {
          sendPort.send(null);
        }
    });
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
      await for (final entity in dir.list(recursive: true, followLinks: false)) {
        files.addAll(await getAllFilesRecursively(entity.path));
      }
    } else if (FileSystemEntity.isFileSync(path)) {
      files.add(File(path));
    }
    return files;
  }
}
