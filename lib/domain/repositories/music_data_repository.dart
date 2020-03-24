import 'package:dartz/dartz.dart';
import 'package:mosh/core/error/failures.dart';

import '../entities/album.dart';
// import '../entities/artist.dart';

abstract class MusicDataRepository {
  Future<Either<Failure, List<Album>>> getAlbums();
  // Future<List<Album>> getAlbumsByArtist(Artist artist);
  Future<void> updateDatabase();
}