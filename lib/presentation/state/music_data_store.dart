import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../../domain/usecases/set_song_blocked.dart';

part 'music_data_store.g.dart';

class MusicDataStore extends _MusicDataStore with _$MusicDataStore {
  MusicDataStore({
    required MusicDataRepository musicDataRepository,
    required SetSongsBlocked setSongBlocked,
  }) : super(
          musicDataRepository,
          setSongBlocked,
        );
}

abstract class _MusicDataStore with Store {
  _MusicDataStore(
    this._musicDataRepository,
    this._setSongsBlocked,
  );

  final SetSongsBlocked _setSongsBlocked;

  final MusicDataRepository _musicDataRepository;

  @observable
  late ObservableStream<List<Song>> songStream =
      _musicDataRepository.songsStream.asObservable(initialValue: []);

  @observable
  late ObservableStream<List<Album>> albumStream =
      _musicDataRepository.albumStream.asObservable(initialValue: []);

  @observable
  late ObservableStream<List<Artist>> artistStream =
      _musicDataRepository.artistStream.asObservable(initialValue: []);

  @observable
  late ObservableStream<List<Playlist>> playlistsStream =
      _musicDataRepository.playlistsStream.asObservable(initialValue: []);

  @observable
  bool isUpdatingDatabase = false;

  @observable
  late ObservableFuture<Album?> albumOfDay = _musicDataRepository.getAlbumOfDay().asObservable();

  @action
  Future<void> updateDatabase() async {
    isUpdatingDatabase = true;
    await _musicDataRepository.updateDatabase();
    isUpdatingDatabase = false;
  }

  Future<void> setSongsBlocked(List<Song> songs, int blockLevel) async {
    await _setSongsBlocked(songs, blockLevel);
  }

  Future<void> toggleNextSongLink(Song song) => _musicDataRepository.toggleNextSongLink(song);

  Future<void> togglePreviousSongLink(Song song) =>
      _musicDataRepository.togglePreviousSongLink(song);

  Future<void> setLikeCount(List<Song> songs, int count) =>
      _musicDataRepository.setLikeCount(songs, count);

  Future<void> insertPlaylist(String name) async {
    _musicDataRepository.insertPlaylist(name);
  }

  Future<void> removePlaylist(Playlist playlist) async {
    _musicDataRepository.removePlaylist(playlist);
  }

  Future<void> updatePlaylist(int id, String name) async {
    _musicDataRepository.updatePlaylist(id, name);
  }

  Future<void> addSongToPlaylist(Playlist playlist, Song song) async {
    _musicDataRepository.appendSongToPlaylist(playlist, song);
  }

  Future<void> removePlaylistEntry(int playlistId, int index) async {
    _musicDataRepository.removePlaylistEntry(playlistId, index);
  }

  Future<void> movePlaylistEntry(int playlistId, int oldIndex, int newIndex) async {
    _musicDataRepository.movePlaylistEntry(playlistId, oldIndex, newIndex);
  }

  Stream<Playlist> getPlaylistStream(int playlistId) {
    return _musicDataRepository.getPlaylistStream(playlistId);
  }
}
