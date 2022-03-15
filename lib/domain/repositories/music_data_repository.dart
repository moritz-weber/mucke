import '../entities/album.dart';
import '../entities/artist.dart';
import '../entities/playlist.dart';
import '../entities/shuffle_mode.dart';
import '../entities/smart_list.dart';
import '../entities/song.dart';

abstract class MusicDataInfoRepository {
  Stream<Map<String, Song>> get songUpdateStream;

  Future<Song> getSongByPath(String path);
  Stream<Song> getSongStream(String path);
  Stream<List<Song>> get songsStream;
  Stream<List<Song>> getAlbumSongStream(Album album);
  Stream<List<Song>> getArtistSongStream(Artist artist);
  Stream<List<Song>> getArtistHighlightedSongStream(Artist artist);
  Stream<List<Song>> getSmartListSongStream(SmartList smartList);
  Future<List<Song>> getPredecessors(Song song);
  Future<List<Song>> getSuccessors(Song song);

  Stream<List<Playlist>> get playlistsStream;
  Stream<Playlist> getPlaylistStream(int playlistId);

  Stream<List<SmartList>> get smartListsStream;
  Stream<SmartList> getSmartListStream(int smartListId);

  Stream<List<Album>> get albumStream;
  Stream<List<Album>> getArtistAlbumStream(Artist artist);
  Future<int?> getAlbumId(String title, String artist, int? year);
  // TODO: make this a stream? or call everytime on home screen?
  Future<Album?> getAlbumOfDay();

  Stream<List<Artist>> get artistStream;

  Future<List<Artist>> searchArtists(String searchText, {int? limit});
  Future<List<Album>> searchAlbums(String searchText, {int? limit});
  Future<List<Song>> searchSongs(String searchText, {int? limit});
}

abstract class MusicDataRepository extends MusicDataInfoRepository {
  Future<void> updateDatabase();

  Future<void> setSongsBlockLevel(List<Song> songs, int blockLevel);

  Future<Song> incrementSkipCount(Song song);
  Future<Song> resetSkipCount(Song song);

  Future<Song> incrementLikeCount(Song song);
  Future<Song> resetLikeCount(Song song);

  Future<Song> incrementPlayCount(Song song);

  Future<Song> togglePreviousSongLink(Song song);
  Future<Song> toggleNextSongLink(Song song);

  Future<void> insertPlaylist(String name);
  Future<void> updatePlaylist(int id, String name);
  Future<void> removePlaylist(Playlist playlist);
  Future<void> appendSongToPlaylist(Playlist playlist, Song song);
  Future<void> removePlaylistEntry(int playlistId, int index);
  Future<void> movePlaylistEntry(int playlistId, int oldIndex, int newIndex);

  Future<void> insertSmartList({
    required String name,
    required Filter filter,
    required OrderBy orderBy,
    ShuffleMode? shuffleMode,
  });
  Future<void> updateSmartList(SmartList smartList);
  Future<void> removeSmartList(SmartList smartList);
}
