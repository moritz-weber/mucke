import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/smart_list.dart';
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
  late ObservableStream<List<SmartList>> smartListsStream =
      _musicDataRepository.smartListsStream.asObservable(initialValue: []);

  @observable
  bool isUpdatingDatabase = false;

  @observable
  late ObservableStream<Album?> albumOfDay = _musicDataRepository.albumOfDayStream.asObservable();

  @observable
  late ObservableStream<Artist?> artistOfDay =
      _musicDataRepository.artistOfDayStream.asObservable();

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

  Future<void> insertPlaylist(
    String name,
    String iconString,
    String gradientString,
    ShuffleMode? shuffleMode,
  ) async {
    _musicDataRepository.insertPlaylist(name, iconString, gradientString, shuffleMode);
  }

  Future<void> removePlaylist(Playlist playlist) async {
    _musicDataRepository.removePlaylist(playlist);
  }

  Future<void> updatePlaylist(Playlist playlist) async {
    _musicDataRepository.updatePlaylist(playlist);
  }

  Future<void> addSongsToPlaylist(Playlist playlist, List<Song> songs) async {
    _musicDataRepository.addSongsToPlaylist(playlist, songs);
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

  Future<void> removeSmartList(SmartList smartList) async {
    await _musicDataRepository.removeSmartList(smartList);
  }
}
