import '../models/album_model.dart';
import '../models/song_model.dart';

abstract class MusicDataSource {
  Future<List<AlbumModel>> getAlbums();
  Future<bool> albumExists(AlbumModel albumModel);
  Future<void> insertAlbum(AlbumModel albumModel);

  Future<List<SongModel>> getSongs();
}
