import '../models/album_model.dart';

abstract class MusicDataSource {
  Future<List<AlbumModel>> getAlbums();
  // could return failure...
  // Future<AlbumModel> getAlbum(String title, String artist);
  Future<bool> albumExists(AlbumModel albumModel);

  Future<void> insertAlbum(AlbumModel albumModel);
}
