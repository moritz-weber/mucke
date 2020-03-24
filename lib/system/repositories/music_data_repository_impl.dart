import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mosh/system/models/album_model.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/album.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../datasources/local_music_fetcher_contract.dart';
import '../datasources/music_data_source_contract.dart';

class MusicDataRepositoryImpl implements MusicDataRepository {
  final LocalMusicFetcher localMusicFetcher;
  final MusicDataSource musicDataSource;

  MusicDataRepositoryImpl(
      {@required this.localMusicFetcher, @required this.musicDataSource});

  @override
  Future<Either<Failure, List<Album>>> getAlbums() async {
    return musicDataSource.getAlbums().then((albums) => Right(albums));
  }

  @override
  Future<void> updateDatabase() async {
    final albums = await localMusicFetcher.getAlbums();

    for (final album in albums) {
      if (!await musicDataSource.albumExists(album)) {
        musicDataSource.insertAlbum(album);
      }
    }
  }
}
