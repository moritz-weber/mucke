import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/album.dart';
import '../entities/artist.dart';
import '../entities/song.dart';

abstract class MusicDataRepository {
  Future<Either<Failure, List<Song>>> getSongs();
  Future<Either<Failure, List<Song>>> getSongsFromAlbum(Album album);
  Future<Either<Failure, List<Album>>> getAlbums();
  Future<Either<Failure, List<Artist>>> getArtists();
  Future<void> updateDatabase();

  Future<void> setSongBlocked(Song song, bool blocked);
}