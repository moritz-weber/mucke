import '../models/album_model.dart';

abstract class LocalMusicFetcher {
  Future<List<AlbumModel>> getAlbums();
}