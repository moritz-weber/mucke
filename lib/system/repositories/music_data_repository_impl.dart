import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
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
  Future<Either<Failure, List<Song>>> getSongsFromAlbum(Album album) async {
    return musicDataSource.getSongsFromAlbum(album as AlbumModel).then(
        (List<SongModel> songs) => Right<Failure, List<SongModel>>(songs));
  }

  @override
  Future<void> updateDatabase() async {
    _log.info('updataDatabase called');

    await musicDataSource.deleteAllArtists();
    final List<ArtistModel> artists = await localMusicFetcher.getArtists();

    for (final ArtistModel artist in artists) {
      await musicDataSource.insertArtist(artist);
    }

    await musicDataSource.deleteAllAlbums();
    final List<AlbumModel> albums = await localMusicFetcher.getAlbums();
    final Map<int, int> albumIdMap = {};

    for (final AlbumModel album in albums) {
      final int newAlbumId = await musicDataSource.insertAlbum(album);
      albumIdMap[album.id] = newAlbumId;
    }

    final List<SongModel> songs = await localMusicFetcher.getSongs();

    final List<SongModel> songsToInsert = [];
    for (final SongModel song in songs) {
      songsToInsert.add(song.copyWith(albumId: albumIdMap[song.albumId]));
    }
    await musicDataSource.insertSongs(songsToInsert);

    _log.info('updataDatabase finished');
  }

  @override
  Future<void> setSongBlocked(Song song, bool blocked) async {
    await musicDataSource.setSongBlocked(song as SongModel, blocked);
  }
}
