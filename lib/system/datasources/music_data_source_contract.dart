import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/queue_item_model.dart';
import '../models/song_model.dart';

abstract class MusicDataSource {
  Future<List<AlbumModel>> getAlbums();

  Stream<List<SongModel>> get songStream;
  Stream<List<SongModel>> getAlbumSongStream(AlbumModel album);

  Future<void> setQueue(List<QueueItemModel> queue);
  Stream<List<SongModel>> get songQueueStream;
  Stream<List<QueueItemModel>> get queueStream;
  Future<void> setCurrentIndex(int index);
  Stream<int> get currentIndexStream;

  /// Insert album into the database. Return the ID of the inserted album.
  Future<int> insertAlbum(AlbumModel albumModel);

  Future<List<SongModel>> getSongs();
  Future<List<SongModel>> getSongsFromAlbum(AlbumModel album);
  Future<void> insertSong(SongModel songModel);
  Future<void> insertSongs(List<SongModel> songModels);
  Future<void> setSongBlocked(SongModel song, bool blocked);
  Future<void> toggleNextSongLink(SongModel song);

  Future<SongModel> getSongByPath(String path);

  Future<void> deleteAllArtists();
  Future<int> insertArtist(ArtistModel artistModel);

  Future<void> deleteAllAlbums();
  Future<void> deleteAllSongs();

  Future<List<ArtistModel>> getArtists();
}
