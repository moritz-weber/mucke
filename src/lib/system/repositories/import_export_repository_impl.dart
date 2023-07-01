import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../constants.dart';
import '../../domain/entities/app_data.dart';
import '../../domain/repositories/import_export_repository.dart';
import '../datasources/drift_database.dart';
import '../datasources/music_data_source_contract.dart';
import '../datasources/playlist_data_source.dart';
import '../datasources/settings_data_source.dart';
import '../models/app_data_model.dart';

class ImportExportRepositoryImpl implements ImportExportRepository {
  ImportExportRepositoryImpl(
      this._settingsDataSource, this._musicDataSource, this._playlistDataSource);

  final SettingsDataSource _settingsDataSource;
  final MusicDataSource _musicDataSource;
  final PlaylistDataSource _playlistDataSource;

  @override
  Future<Map<String, dynamic>?> readDataFile(String inputPath) async {
    final contents = await File(inputPath).readAsString();
    return json.decode(contents) as Map<String, dynamic>;
  }

  // @override
  // Future<bool> importData(AppData data, DataSelection selection) async {
  //   if (selection.generalSettings && data.generalSettings != null) {
  //     final settings = data.generalSettings!;
  //     await _loadSettings(settings.map((key, value) => MapEntry(key, value as String)));
  //   }
  //   return true;
  // }

  @override
  Future<String?> exportData(String outputPath, DataSelection selection) async {
    final packageInfo = await PackageInfo.fromPlatform();

    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;

    final db = GetIt.I<MainDatabase>();

    // TODO: maybe move this to AppDataModel
    final Map<String, dynamic> data = {
      APP_VERSION: version,
      BUILD_NUMBER: buildNumber,
      DB_VERSION: db.schemaVersion,
    };

    final kvSettings = await _settingsDataSource.getKeyValueSettings();

    if (selection.allowedExtensions) {
      // we take this constant directly from the database constants
      data[SETTING_ALLOWED_EXTENSIONS] = kvSettings[SETTING_ALLOWED_EXTENSIONS];
    }
    if (selection.blockedFiles) {
      data[BLOCKED_FILES] = await _musicDataSource.getBlockedFiles();
    }
    if (selection.libraryFolders) {
      data[LIBRARY_FOLDERS] = await _settingsDataSource.getLibraryFolders();
    }
    // if (selection.generalSettings) {
    //   kvSettings.remove(SETTING_ALLOWED_EXTENSIONS);
    //   data[SETTINGS] = kvSettings;
    // }
    if (selection.songsAlbumsArtists) {
      final songs = await _musicDataSource.getSongs();
      data[SONGS] = <String, Map>{for (final song in songs) song.path: song.toExportMap()};

      final albums = await _musicDataSource.getAlbums();
      data[ALBUMS] = <String, Map>{
        for (final album in albums) album.id.toString(): album.toExportMap()
      };

      final artists = await _musicDataSource.getArtists();
      data[ARTISTS] = <String, Map>{
        for (final artist in artists) artist.id.toString(): artist.toExportMap()
      };
    }
    if (selection.smartlists) {
      final smartlists = await _playlistDataSource.getSmartlists();
      data[SMARTLISTS] = [for (final sl in smartlists) sl.toExportMap()];
    }
    if (selection.playlists) {
      final playlists = await _playlistDataSource.getPlaylists();
      final playlistsExport = <Map<String, dynamic>>[];
      for (final playlist in playlists) {
        final songs = await _playlistDataSource.getPlaylistSongs(playlist);
        final plExport = playlist.toExportMap();
        plExport['SONGS'] = songs.map((e) => e.path).toList();
        playlistsExport.add(plExport);
      }
      data[PLAYLISTS] = playlistsExport;
    }

    final dataJSON = json.encode(data);

    final file = File('$outputPath/${_fileName()}');
    await file.writeAsString(dataJSON);
    return file.path;
  }

  @override
  AppData getAppData(Map<String, dynamic> data) {
    return AppDataModel.fromMap(data);
  }

  // Future<void> _loadSettings(Map<String, String> settings) async {
  //   await _settingsDataSource.loadKeyValueSettings(settings);
  // }
  
  @override
  Future<void> importPlaylist(Map<String, dynamic> playlistData, Map<String, Map> songData) async {
    return await _playlistDataSource.importPlaylist(playlistData, songData);
  }
  
  @override
  Future<void> importSmartlist(Map<String, dynamic> smartlistData, Map<String, Map> artistData) async {
    return await _playlistDataSource.importSmartlist(smartlistData, artistData);
  }
  
  @override
  Future<void> importSongMetadata(Map<String, Map> data) async {
    return await _musicDataSource.importSongMetadata(data);
  }
}

String _fileName() {
  final now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd_HH-mm-ss');
  final String formatted = formatter.format(now);

  return 'mucke_$formatted.json';
}
