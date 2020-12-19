import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../datasources/local_music_fetcher_contract.dart';
import '../datasources/music_data_source_contract.dart';
import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/song_model.dart';

class MusicDataRepositoryImpl implements MusicDataRepository {
  MusicDataRepositoryImpl({
    @required this.localMusicFetcher,
    @required this.musicDataSource,
  });

  final LocalMusicFetcher localMusicFetcher;
  final MusicDataSource musicDataSource;

  static final _log = Logger('MusicDataRepository');

  @override
  Future<Either<Failure, List<Artist>>> getArtists() async {
    return musicDataSource.getArtists().then((List<ArtistModel> artists) =>
        Right<Failure, List<ArtistModel>>(artists));
  }

  @override
  Future<Either<Failure, List<Album>>> getAlbums() async {
    return musicDataSource.getAlbums().then(
        (List<AlbumModel> albums) => Right<Failure, List<AlbumModel>>(albums));
  }

  @override
  Future<Either<Failure, List<Song>>> getSongs() async {
    return musicDataSource.getSongs().then(
        (List<SongModel> songs) => Right<Failure, List<SongModel>>(songs));
  }

  @override
  Stream<List<Song>> get songStream => musicDataSource.songStream;

  @override
  Stream<List<Song>> getAlbumSongStream(Album album) => musicDataSource.getAlbumSongStream(album as AlbumModel);

  @override
  Future<Either<Failure, List<Song>>> getSongsFromAlbum(Album album) async {
    return musicDataSource.getSongsFromAlbum(album as AlbumModel).then(
        (List<SongModel> songs) => Right<Failure, List<SongModel>>(songs));
  }

  @override
  Future<void> updateDatabase() async {
    _log.info('updateDatabase called');

    updateArtists();
    final albumIdMap = await updateAlbums();
    await updateSongs(albumIdMap);

    _log.info('updateDatabase finished');
  }

  @override
  Future<void> setSongBlocked(Song song, bool blocked) async {
    await musicDataSource.setSongBlocked(song as SongModel, blocked);
  }

  Future<void> updateArtists() async {
    await musicDataSource.deleteAllArtists();
    final List<ArtistModel> artists = await localMusicFetcher.getArtists();

    for (final ArtistModel artist in artists) {
      await musicDataSource.insertArtist(artist);
    }
  }

  Future<Map<int, int>> updateAlbums() async {
    await musicDataSource.deleteAllAlbums();
    final List<AlbumModel> albums = await localMusicFetcher.getAlbums();
    final Map<int, int> albumIdMap = {};

    final Directory dir = await getApplicationSupportDirectory();
    for (final AlbumModel album in albums) {
      int newAlbumId;

      if (album.albumArtPath == null) {
        final String albumArtPath = '${dir.path}/${album.id}';
        final file = File(albumArtPath);
        final artwork = await localMusicFetcher.getAlbumArtwork(album.id);
        if (artwork.isNotEmpty) {
          file.writeAsBytesSync(artwork);
          final newAlbum = album.copyWith(albumArtPath: albumArtPath);
          newAlbumId = await musicDataSource.insertAlbum(newAlbum);
        } else {
          newAlbumId = await musicDataSource.insertAlbum(album);
        }
      } else {
        newAlbumId = await musicDataSource.insertAlbum(album);
      }
      albumIdMap[album.id] = newAlbumId;
    }

    return albumIdMap;
  }

  Future<void> updateSongs(Map<int, int> albumIdMap) async {
    final Directory dir = await getApplicationSupportDirectory();
    final List<SongModel> songs = await localMusicFetcher.getSongs();

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
    await musicDataSource.insertSongs(songsToInsert);
  }

  @override
  Future<void> toggleNextSongLink(Song song) async {
    musicDataSource.toggleNextSongLink(song as SongModel);
  }

  @override
  Stream<List<Song>> get queueStream => musicDataSource.songQueueStream;

  @override
  Stream<int> get currentIndexStream => musicDataSource.currentIndexStream;

  @override
  Stream<LoopMode> get loopModeStream => musicDataSource.loopModeStream;
}
