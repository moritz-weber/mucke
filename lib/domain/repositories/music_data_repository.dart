import '../entities/album.dart';
import '../entities/artist.dart';
import '../entities/song.dart';

abstract class MusicDataInfoRepository {
  Stream<Map<String, Song>> get songUpdateStream;

  Future<Song> getSongByPath(String path);
  Stream<List<Song>> get songStream;
  Stream<List<Song>> getAlbumSongStream(Album album);
  Stream<List<Song>> getArtistSongStream(Artist artist);
  Stream<List<Song>> getArtistHighlightedSongStream(Artist artist);

  Stream<List<Album>> get albumStream;
  Stream<List<Album>> getArtistAlbumStream(Artist artist);
  // TODO: make this a stream? or call everytime on home screen?
  Future<Album?> getAlbumOfDay();

  Stream<List<Artist>> get artistStream;

  Future<List> search(String searchText);
}

abstract class MusicDataRepository extends MusicDataInfoRepository {
  Future<void> updateDatabase();
  
  Future<void> setSongBlocked(Song song, bool blocked);

  Future<void> incrementSkipCount(Song song);
  Future<void> resetSkipCount(Song song);

  Future<void> incrementLikeCount(Song song);
  Future<void> decrementLikeCount(Song song);
  Future<void> resetLikeCount(Song song);

  Future<void> incrementPlayCount(Song song);
  Future<void> resetPlayCount(Song song);

  Future<void> togglePreviousSongLink(Song song);
  Future<void> toggleNextSongLink(Song song);
}