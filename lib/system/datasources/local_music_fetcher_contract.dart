import '../models/album_model.dart';
import '../models/song_model.dart';

abstract class LocalMusicFetcher {
  Future<List<AlbumModel>> getAlbums();
  Future<List<SongModel>> getSongs();
}