import '../../constants.dart';
import '../../domain/entities/app_data.dart';

const APP_VERSION = 'APP_VERSION';
const BUILD_NUMBER = 'BUILD_NUMBER';
const DB_VERSION = 'DB_VERSION';
const SETTINGS = 'SETTINGS';
const BLOCKED_FILES = 'BLOCKED_FILES';
const LIBRARY_FOLDERS = 'LIBRARY_FOLDERS';
const SONGS = 'SONGS';
const ALBUMS = 'ALBUMS';
const ARTISTS = 'ARTISTS';
const SMARTLISTS = 'SMARTLISTS';
const PLAYLISTS = 'PLAYLISTS';

class AppDataModel extends AppData {
  AppDataModel({
    required super.appVersion,
    required super.buildNumber,
    required super.dbVersion,
    super.allowedExtensions,
    super.blockedFiles,
    super.generalSettings,
    super.libraryFolders,
    super.playlists,
    super.smartlists,
    super.songs,
    super.albums,
    super.artists,
  });

  factory AppDataModel.fromMap(Map<String, dynamic> data) {
    return AppDataModel(
      appVersion: data[APP_VERSION].toString(),
      buildNumber: int.parse(data[BUILD_NUMBER].toString()),
      dbVersion: data[DB_VERSION] as int,
      allowedExtensions: data[SETTING_ALLOWED_EXTENSIONS] as String?,
      blockedFiles: (data[BLOCKED_FILES] as List?)?.map((e) => e as String).toList(),
      generalSettings: data[SETTINGS] as Map<String, dynamic>?,
      libraryFolders: (data[LIBRARY_FOLDERS] as List?)?.map((e) => e as String).toList(),
      playlists: (data[PLAYLISTS] as List?)?.map((e) => e as Map<String, dynamic>).toList(),
      smartlists: (data[SMARTLISTS] as List?)?.map((e) => e as Map<String, dynamic>).toList(),
      songs: (data[SONGS] as Map<String, dynamic>?)?.map<String, Map>((key, value) => MapEntry(key, value as Map)),
      albums: (data[ALBUMS] as Map<String, dynamic>?)?.map<String, Map>((key, value) => MapEntry(key, value as Map)),
      artists: (data[ARTISTS] as Map<String, dynamic>?)?.map<String, Map>((key, value) => MapEntry(key, value as Map)),
    );
  }
}
