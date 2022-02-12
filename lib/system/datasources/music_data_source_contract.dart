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

  Stream<List<AlbumModel>> get albumStream;
  Stream<List<AlbumModel>> getArtistAlbumStream(ArtistModel artist);

  Stream<List<ArtistModel>> get artistStream;

  Future<void> updateSong(SongModel songModel);
  Future<void> insertSongs(List<SongModel> songModels);

  Future<void> insertAlbums(List<AlbumModel> albumModels);
  Future<void> deleteAllAlbums();

  Future<void> insertArtists(List<ArtistModel> artistModels);
  Future<void> deleteAllArtists();

  // TODO: is this the right place? maybe persistent state?
  Future<void> setAlbumOfDay(AlbumOfDay albumOfDay);
  Future<AlbumOfDay?> getAlbumOfDay();

  Future<List<ArtistModel>> searchArtists(String searchText, {int? limit});
  Future<List<AlbumModel>> searchAlbums(String searchText, {int? limit});
  Future<List<SongModel>> searchSongs(String searchText, {int? limit});

  Future<int?> getAlbumId(String? title, String? artist, int? year);
}
