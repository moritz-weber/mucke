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
    required SetSongBlocked setSongBlocked,
  }) : super(
          musicDataRepository,
          setSongBlocked,
        );
}

abstract class _MusicDataStore with Store {
  _MusicDataStore(
    this._musicDataRepository,
    this._setSongBlocked,
  );

  final SetSongBlocked _setSongBlocked;

  final MusicDataRepository _musicDataRepository;

  @observable
  late ObservableStream<List<Song>> songStream =
      _musicDataRepository.songStream.asObservable(initialValue: []);

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

  Future<void> setSongBlocked(Song song, int blockLevel) => _setSongBlocked(song, blockLevel);

  Future<void> toggleNextSongLink(Song song) async =>
      await _musicDataRepository.toggleNextSongLink(song);

  Future<void> togglePreviousSongLink(Song song) async =>
      await _musicDataRepository.togglePreviousSongLink(song);

  Future<void> incrementLikeCount(Song song) => _musicDataRepository.incrementLikeCount(song);

  Future<void> resetLikeCount(Song song) => _musicDataRepository.resetLikeCount(song);

  // TODO: exploratory from here on
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
