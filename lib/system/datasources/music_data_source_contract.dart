import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/smart_list_model.dart';
import '../models/song_model.dart';

abstract class MusicDataSource {
  Stream<List<SongModel>> get songStream;
  Stream<List<SongModel>> getAlbumSongStream(AlbumModel album);
  Stream<List<SongModel>> getArtistSongStream(ArtistModel artist);
  Future<List<SongModel>> getSongs();
  Stream<List<SongModel>> getSmartListSongStream(SmartListModel smartList);
  Future<SongModel> getSongByPath(String path);
  Future<SongModel?> getPredecessor(SongModel song);
  Future<SongModel?> getSuccessor(SongModel song);

  Stream<List<AlbumModel>> get albumStream;
  Stream<List<AlbumModel>> getArtistAlbumStream(ArtistModel artist);
  Future<List<AlbumModel>> getAlbums();

  Stream<List<ArtistModel>> get artistStream;
  Future<List<ArtistModel>> getArtists();

  Future<void> updateSong(SongModel songModel);
  Future<void> insertSongs(List<SongModel> songModels);
  Future<void> deleteAllSongs();
  Future<void> setSongBlocked(SongModel song, bool blocked);
  Future<void> incrementSkipCount(SongModel song);
  Future<void> resetSkipCount(SongModel song);
  Future<void> incrementLikeCount(SongModel song);
  Future<void> decrementLikeCount(SongModel song);
  Future<void> resetLikeCount(SongModel song);
  Future<void> incrementPlayCount(SongModel song);
  Future<void> resetPlayCount(SongModel song);

  /// Insert album into the database. Return the ID of the inserted album.
  Future<int> insertAlbum(AlbumModel albumModel);
  Future<void> insertAlbums(List<AlbumModel> albumModels);
  Future<void> deleteAllAlbums();

  Future<int> insertArtist(ArtistModel artistModel);
  Future<void> insertArtists(List<ArtistModel> artistModels);
  Future<void> deleteAllArtists();

  // TODO: is this the right place? maybe persistent state?
  Future<void> setAlbumOfDay(AlbumOfDay albumOfDay);
  Future<AlbumOfDay?> getAlbumOfDay();

  Future<List> search(String searchText, {int limit});
}
