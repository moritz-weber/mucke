import 'dart:typed_data';
import 'dart:ui';

import 'package:device_info/device_info.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/song_model.dart';
import 'local_music_fetcher_contract.dart';
import 'settings_data_source.dart';

class LocalMusicFetcherImpl implements LocalMusicFetcher {
  LocalMusicFetcherImpl(this._flutterAudioQuery, this._settingsDataSource, this._deviceInfo);

  final FlutterAudioQuery _flutterAudioQuery;
  final SettingsDataSource _settingsDataSource;
  // CODESMELL: should probably encapsulate the deviceinfoplugin
  final DeviceInfoPlugin _deviceInfo;

  AndroidDeviceInfo _androidDeviceInfo;
  Future<AndroidDeviceInfo> get androidDeviceInfo async {
    _androidDeviceInfo ??= await _deviceInfo.androidInfo;
    return _androidDeviceInfo;
  }

  @override
  Future<List<ArtistModel>> getArtists() async {
    final List<ArtistInfo> artistInfoList = await _flutterAudioQuery.getArtists();
    return artistInfoList
        .map((ArtistInfo artistInfo) => ArtistModel.fromArtistInfo(artistInfo))
        .toSet()
        .toList();
  }

  @override
  Future<List<AlbumModel>> getAlbums() async {
    final List<AlbumInfo> albumInfoList = await _flutterAudioQuery.getAlbums();
    return albumInfoList.map((AlbumInfo albumInfo) => AlbumModel.fromAlbumInfo(albumInfo)).toList();
  }

  @override
  Future<List<SongModel>> getSongs() async {
    final List<SongInfo> songInfoList = await _flutterAudioQuery.getSongs();
    return songInfoList
        .where((songInfo) => songInfo.isMusic)
        .map((SongInfo songInfo) => SongModel.fromSongInfo(songInfo))
        .toList();
  }

  @override
  Future<Uint8List> getAlbumArtwork(int id) async {
    final info = await androidDeviceInfo;
    if (info.version.sdkInt >= 29) {
      return _flutterAudioQuery.getArtwork(
        type: ResourceType.ALBUM,
        id: id.toString(),
        size: const Size(500.0, 500.0),
      );
    }
    return Uint8List(0);
  }

  @override
  Future<Map<String, List>> getLocalMusic() async {
    final musicDirectories = await _settingsDataSource.getLibraryFolders();

    final songs = await _getFilteredSongs(musicDirectories);
    final albumTitles = Set<String>.from(songs.map((song) => song.album));
    final albums = await _getFilteredAlbums(albumTitles);
    final artistNames = Set<String>.from(albums.map((album) => album.artist));
    final artists = await _getFilteredArtists(artistNames);

    return {
      'SONGS': songs,
      'ALBUMS': albums,
      'ARTISTS': artists,
    };
  }

  Future<List<SongModel>> _getFilteredSongs(Iterable<String> musicDirectories) async {
    final List<SongInfo> songInfoList = await _flutterAudioQuery.getSongs();
    return songInfoList
        .where(
          (songInfo) =>
              songInfo.isMusic &&
              musicDirectories.any((element) => songInfo.filePath.startsWith(element)),
        )
        .map((SongInfo songInfo) => SongModel.fromSongInfo(songInfo))
        .toList();
  }

  Future<List<AlbumModel>> _getFilteredAlbums(Iterable<String> albumTitles) async {
    final List<AlbumInfo> albumInfoList = await _flutterAudioQuery.getAlbums();
    return albumInfoList
        .where((albumInfo) => albumTitles.contains(albumInfo.title))
        .map((AlbumInfo albumInfo) => AlbumModel.fromAlbumInfo(albumInfo))
        .toList();
  }

  Future<List<ArtistModel>> _getFilteredArtists(Iterable<String> artistNames) async {
    final List<ArtistInfo> artistInfoList = await _flutterAudioQuery.getArtists();
    return artistInfoList
        .where((artistInfo) => artistNames.contains(artistInfo.name))
        .map((ArtistInfo artistInfo) => ArtistModel.fromArtistInfo(artistInfo))
        .toSet()
        .toList();
  }
}
