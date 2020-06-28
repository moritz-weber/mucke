import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/album.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../datasources/local_music_fetcher_contract.dart';
import '../datasources/music_data_source_contract.dart';
import '../models/album_model.dart';
import '../models/song_model.dart';

class MusicDataRepositoryImpl implements MusicDataRepository {
  MusicDataRepositoryImpl({
    @required this.localMusicFetcher,
    @required this.musicDataSource,
  });

  final LocalMusicFetcher localMusicFetcher;
  final MusicDataSource musicDataSource;

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
    final List<AlbumModel> albums = await localMusicFetcher.getAlbums();

    final Map<int, int> albumIdMap = {};

    await musicDataSource.resetAlbumsPresentFlag();
    for (final AlbumModel album in albums) {
      final storedAlbum = await musicDataSource.getAlbumByTitleArtist(
          album.title, album.artist);
      if (storedAlbum != null) {
        albumIdMap[album.id] = storedAlbum.id;
        await musicDataSource.flagAlbumPresent(storedAlbum);
      } else {
        final int newAlbumId = await musicDataSource.insertAlbum(album);
        albumIdMap[album.id] = newAlbumId;
      }
    }
    await musicDataSource.removeNonpresentAlbums();

    final List<SongModel> songs = await localMusicFetcher.getSongs();

    await musicDataSource.resetSongsPresentFlag();

    for (final SongModel song in songs) {
      SongModel storedSong = await musicDataSource.getSongByPath(song.path);
      storedSong ??= await musicDataSource.getSongByTitleAlbumArtist(
            song.title, song.album, song.artist);
        
      if (storedSong != null) {
        await musicDataSource.flagSongPresent(storedSong);
      } else {
        final SongModel songToInsert = song.copyWith(albumId: albumIdMap[song.albumId]);

        // TODO: fails if albumId is null
        await musicDataSource.insertSong(songToInsert);
      }
    }

    await musicDataSource.removeNonpresentSongs();
  }
}
