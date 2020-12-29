import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/album.dart';
import '../entities/artist.dart';
import '../entities/song.dart';

abstract class MusicDataRepository {
  Stream<List<Song>> get songStream;
  Stream<List<Song>> getAlbumSongStream(Album album);
  Stream<List<Album>> getArtistAlbumStream(Artist artist);

  Future<Either<Failure, List<Song>>> getSongs();
  Future<Either<Failure, List<Song>>> getSongsFromAlbum(Album album);
  Future<Either<Failure, List<Album>>> getAlbums();
  Future<Either<Failure, List<Artist>>> getArtists();
  Future<void> updateDatabase();

  Future<void> setSongBlocked(Song song, bool blocked);
  Future<void> toggleNextSongLink(Song song);
}
