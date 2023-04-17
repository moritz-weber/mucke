import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/song_model.dart';

abstract class MusicDataSource {
  Stream<List<SongModel>> get songStream;
  Stream<List<SongModel>> getAlbumSongStream(AlbumModel album);
  Stream<List<SongModel>> getArtistSongStream(ArtistModel artist);
  Stream<SongModel> getSongStream(String path);
  Future<SongModel?> getSongByPath(String path);
  Future<SongModel?> getPredecessor(SongModel song);
  Future<SongModel?> getSuccessor(SongModel song);
  Future<List<SongModel>> getSongsFromSameAlbum(SongModel song);

  Stream<List<AlbumModel>> get albumStream;
  Stream<List<AlbumModel>> getArtistAlbumStream(ArtistModel artist);

  Stream<List<ArtistModel>> get artistStream;

  Future<void> updateSongs(List<SongModel> songModels);
  Future<void> insertSongs(List<SongModel> songModels);

  Future<void> insertAlbums(List<AlbumModel> albumModels);
  Future<void> deleteAllAlbums();

  Future<void> insertArtists(List<ArtistModel> artistModels);
  Future<void> deleteAllArtists();

  Future<void> setAlbumOfDay(AlbumOfDay albumOfDay);
  Future<AlbumOfDay?> getAlbumOfDay();
  Future<void> setArtistOfDay(ArtistOfDay artistOfDay);
  Future<ArtistOfDay?> getArtistOfDay();

  Future<List<ArtistModel>> searchArtists(String searchText, {int? limit});
  Future<List<AlbumModel>> searchAlbums(String searchText, {int? limit});
  Future<List<SongModel>> searchSongs(String searchText, {int? limit});

  Future<int?> getAlbumId(String? title, String? artist, int? year);

  Stream<Set<String>> get blockedFilesStream;
  Future<void> addBlockedFiles(List<String> paths);
  Future<void> removeBlockedFiles(List<String> paths);

  Future<void> cleanupDatabase();
}
