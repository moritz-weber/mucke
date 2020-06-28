import '../models/album_model.dart';
import '../models/song_model.dart';

abstract class MusicDataSource {
  Future<List<AlbumModel>> getAlbums();
  Future<bool> albumExists(AlbumModel albumModel);

  /// Insert album into the database. Return the ID of the inserted album.
  Future<int> insertAlbum(AlbumModel albumModel);

  Future<List<SongModel>> getSongs();
  Future<List<SongModel>> getSongsFromAlbum(AlbumModel album);
  Future<bool> songExists(SongModel songModel);
  Future<void> insertSong(SongModel songModel);

  Future<void> resetAlbumsPresentFlag();

  /// Get an AlbumModel with the matching title and artist. Returns null if there is none.
  Future<AlbumModel> getAlbumByTitleArtist(String title, String artist);
  Future<void> flagAlbumPresent(AlbumModel albumModel);
  Future<void> removeNonpresentAlbums();

  Future<void> resetSongsPresentFlag();
  Future<SongModel> getSongByPath(String path);
  Future<SongModel> getSongByTitleAlbumArtist(
      String title, String album, String artist);
  Future<void> flagSongPresent(SongModel songModel);
  Future<void> removeNonpresentSongs();
}
