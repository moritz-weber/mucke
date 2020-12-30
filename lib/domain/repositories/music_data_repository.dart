import '../entities/album.dart';
import '../entities/artist.dart';
import '../entities/song.dart';

abstract class MusicDataRepository {
  Stream<List<Song>> get songStream;
  Stream<List<Song>> getAlbumSongStream(Album album);

  Stream<List<Album>> get albumStream;
  Stream<List<Album>> getArtistAlbumStream(Artist artist);

  Stream<List<Artist>> get artistStream;

  Future<void> updateDatabase();

  Future<void> setSongBlocked(Song song, bool blocked);
  Future<void> toggleNextSongLink(Song song);
}
