import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../../domain/usecases/inrement_like_count.dart';
import '../../domain/usecases/reset_like_count.dart';
import '../../domain/usecases/set_song_blocked.dart';
import '../../domain/usecases/toggle_next_song_link.dart';
import '../../domain/usecases/toggle_previous_song_link.dart';
import '../../domain/usecases/update_database.dart';

part 'music_data_store.g.dart';

class MusicDataStore extends _MusicDataStore with _$MusicDataStore {
  MusicDataStore({
    required MusicDataRepository musicDataRepository,
    required UpdateDatabase updateDatabase,
    required IncrementLikeCount incrementLikeCount,
    required ResetLikeCount resetLikeCount,
    required SetSongBlocked setSongBlocked,
    required ToggleNextSongLink toggleNextSongLink,
    required TogglePreviousSongLink togglePreviousSongLink,
  }) : super(
          musicDataRepository,
          updateDatabase,
          incrementLikeCount,
          resetLikeCount,
          setSongBlocked,
          togglePreviousSongLink,
          toggleNextSongLink,
        );
}

abstract class _MusicDataStore with Store {
  _MusicDataStore(
    this._musicDataRepository,
    this._updateDatabase,
    this._incrementLikeCount,
    this._resetLikeCount,
    this._setSongBlocked,
    this._togglePreviousSongLink,
    this._toggleNextSongLink,
  );

  final IncrementLikeCount _incrementLikeCount;
  final ResetLikeCount _resetLikeCount;
  final SetSongBlocked _setSongBlocked;
  final TogglePreviousSongLink _togglePreviousSongLink;
  final ToggleNextSongLink _toggleNextSongLink;
  final UpdateDatabase _updateDatabase;

  // TODO: exploratory; this was an infoRepo before; all "writing" changes were supposed to go through use cases
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
  late ObservableStream<List<Playlist>> playlistsStream = _musicDataRepository.playlistsStream.asObservable(initialValue: []);

  @observable
  bool isUpdatingDatabase = false;

  @observable
  late ObservableFuture<Album?> albumOfDay = _musicDataRepository.getAlbumOfDay().asObservable();

  @action
  Future<void> updateDatabase() async {
    isUpdatingDatabase = true;
    await _updateDatabase();
    isUpdatingDatabase = false;
  }

  Future<void> setSongBlocked(Song song, bool blocked) => _setSongBlocked(song, blocked);

  Future<void> toggleNextSongLink(Song song) async {
    await _toggleNextSongLink(song);
  }

  Future<void> togglePreviousSongLink(Song song) async {
    await _togglePreviousSongLink(song);
  }

  Future<void> incrementLikeCount(Song song) => _incrementLikeCount(song);

  Future<void> resetLikeCount(Song song) => _resetLikeCount(song);

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

  Stream<Playlist> getPlaylistStream(int playlistId) {
    return _musicDataRepository.getPlaylistStream(playlistId);
  }
}
