import '../entities/album.dart';
import '../entities/artist.dart';
import '../entities/song.dart';

abstract class MusicDataRepository {
  Stream<List<Song>> get songStream;
  Stream<List<Song>> getAlbumSongStream(Album album);
  Stream<List<Album>> getArtistAlbumStream(Artist artist);

  Future<List<Song>> getSongs();
  Future<List<Song>> getSongsFromAlbum(Album album);
  Future<List<Album>> getAlbums();
  Future<List<Artist>> getArtists();
  Future<void> updateDatabase();

  Future<void> setSongBlocked(Song song, bool blocked);
  Future<void> toggleNextSongLink(Song song);
}
