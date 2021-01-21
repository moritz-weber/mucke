import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/song_model.dart';

abstract class MusicDataSource {
  Stream<List<SongModel>> get songStream;
  Stream<List<SongModel>> getAlbumSongStream(AlbumModel album);
  Stream<List<SongModel>> getArtistSongStream(ArtistModel artist);
  Future<List<SongModel>> getSongs();
  Future<SongModel> getSongByPath(String path);

  Stream<List<AlbumModel>> get albumStream;
  Stream<List<AlbumModel>> getArtistAlbumStream(ArtistModel artist);
  Future<List<AlbumModel>> getAlbums();

  Stream<List<ArtistModel>> get artistStream;
  Future<List<ArtistModel>> getArtists();

  Future<void> insertSong(SongModel songModel);
  Future<void> insertSongs(List<SongModel> songModels);
  Future<void> deleteAllSongs();
  Future<void> setSongBlocked(SongModel song, bool blocked);
  Future<void> toggleNextSongLink(SongModel song);
  Future<void> incrementSkipCount(SongModel song);
  Future<void> resetSkipCount(SongModel song);
  Future<void> incrementLikeCount(SongModel song);
  Future<void> decrementLikeCount(SongModel song);
  Future<void> resetLikeCount(SongModel song);
  Future<void> incrementPlayCount(SongModel song);
  Future<void> resetPlayCount(SongModel song);

  /// Insert album into the database. Return the ID of the inserted album.
  Future<int> insertAlbum(AlbumModel albumModel);
  Future<void> deleteAllAlbums();

  Future<int> insertArtist(ArtistModel artistModel);
  Future<void> deleteAllArtists();
}
