import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/album.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../datasources/local_music_fetcher_contract.dart';
import '../datasources/music_data_source_contract.dart';
import '../models/album_model.dart';

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

  // TODO: should remove albums that are not longer on the device
  @override
  Future<void> updateDatabase() async {
    final List<AlbumModel> albums = await localMusicFetcher.getAlbums();

    // TODO: compare with list of albums instead -> musicDataSource.getAlbums
    for (final AlbumModel album in albums) {
      if (!await musicDataSource.albumExists(album)) {
        musicDataSource.insertAlbum(album);
      }
    }
  }
}
