import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../datasources/local_music_fetcher.dart';
import '../datasources/music_data_source_contract.dart';
import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/song_model.dart';

class MusicDataRepositoryImpl implements MusicDataRepository {
  MusicDataRepositoryImpl(
    this._localMusicFetcher,
    this._musicDataSource,
  );

  final LocalMusicFetcher _localMusicFetcher;
  final MusicDataSource _musicDataSource;

  static final _log = Logger('MusicDataRepository');

  @override
  Future<Song> getSongByPath(String path) async {
    return await _musicDataSource.getSongByPath(path);
  }

  @override
  Stream<List<Song>> get songStream => _musicDataSource.songStream;

  @override
  Stream<List<Album>> get albumStream => _musicDataSource.albumStream;

  @override
  Stream<List<Artist>> get artistStream => _musicDataSource.artistStream;

  @override
  Stream<List<Song>> getAlbumSongStream(Album album) =>
      _musicDataSource.getAlbumSongStream(album as AlbumModel);

  @override
  Stream<List<Song>> getArtistSongStream(Artist artist) =>
      _musicDataSource.getArtistSongStream(artist as ArtistModel);

  @override
  Stream<List<Album>> getArtistAlbumStream(Artist artist) =>
      _musicDataSource.getArtistAlbumStream(artist as ArtistModel);

  @override
  Future<void> updateDatabase() async {
    _log.info('updateDatabase called');

    final localMusic = await _localMusicFetcher.getLocalMusic();

    await _updateArtists(localMusic['ARTISTS'] as List<ArtistModel>);
    final albumIdMap = await _updateAlbums(localMusic['ALBUMS'] as List<AlbumModel>);
    await _updateSongs(localMusic['SONGS'] as List<SongModel>, albumIdMap);

    _log.info('updateDatabase finished');
  }

  Future<void> _updateArtists(List<ArtistModel> artists) async {
    await _musicDataSource.deleteAllArtists();
    for (final ArtistModel artist in artists) {
      await _musicDataSource.insertArtist(artist);
    }
  }

  Future<Map<int, int>> _updateAlbums(List<AlbumModel> albums) async {
    await _musicDataSource.deleteAllAlbums();
    final Map<int, int> albumIdMap = {};

    final Directory dir = await getApplicationSupportDirectory();
    for (final AlbumModel album in albums) {
      int newAlbumId;

      if (album.albumArtPath == null) {
        final String albumArtPath = '${dir.path}/${album.id}';
        final file = File(albumArtPath);
        final artwork = await _localMusicFetcher.getAlbumArtwork(album.id);
        if (artwork.isNotEmpty) {
          file.writeAsBytesSync(artwork);
          final newAlbum = album.copyWith(albumArtPath: albumArtPath);
          newAlbumId = await _musicDataSource.insertAlbum(newAlbum);
        } else {
          newAlbumId = await _musicDataSource.insertAlbum(album);
        }
      } else {
        newAlbumId = await _musicDataSource.insertAlbum(album);
      }
      albumIdMap[album.id] = newAlbumId;
    }

    return albumIdMap;
  }

  Future<void> _updateSongs(List<SongModel> songs, Map<int, int> albumIdMap) async {
    final Directory dir = await getApplicationSupportDirectory();

    final List<SongModel> songsToInsert = [];
    for (final SongModel song in songs) {
      if (song.albumArtPath == null) {
        songsToInsert.add(song.copyWith(
          albumId: albumIdMap[song.albumId],
          albumArtPath: '${dir.path}/${song.albumId}',
        ));
      } else {
        songsToInsert.add(song.copyWith(albumId: albumIdMap[song.albumId]));
      }
    }
    await _musicDataSource.insertSongs(songsToInsert);
  }
}
