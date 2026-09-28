import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/audio_player_state.dart';
import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/playable.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/queue_item.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/smart_list.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/audio_player_repository.dart';
import '../../domain/usecases/play_album.dart';
import '../../domain/usecases/play_album_from_index.dart';
import '../../domain/usecases/play_artist.dart';
import '../../domain/usecases/play_playable.dart';
import '../../domain/usecases/play_playlist.dart';
import '../../domain/usecases/play_smart_list.dart';
import '../../domain/usecases/play_songs.dart';
import '../../domain/usecases/seek_to_next.dart';
import '../../domain/usecases/shuffle_all.dart';
import '../../domain/utils.dart';
import '../utils.dart' as utils;

part 'audio_store.g.dart';

class AudioStore extends _AudioStore with _$AudioStore {
  AudioStore({
    required PlayAlbum playAlbum,
    required PlayAlbumFromIndex playAlbumFromIndex,
    required PlayArtist playArtist,
    required PlaySongs playSongs,
    required PlaySmartList playSmartList,
    required PlayPlaylist playPlayist,
    required PlayPlayable playPlayable,
    required SeekToNext seekToNext,
    required ShuffleAll shuffleAll,
    required AudioPlayerRepository audioPlayerRepository,
  }) : super(
          playSongs,
          audioPlayerRepository,
          playAlbum,
          playAlbumFromIndex,
          playArtist,
          playSmartList,
          playPlayist,
          seekToNext,
          shuffleAll,
          playPlayable,
        );
}

abstract class _AudioStore with Store {
  _AudioStore(
    this._playSongs,
    this._audioPlayerRepository,
    this._playAlbum,
    this._playAlbumFromIndex,
    this._playArtist,
    this._playSmartList,
    this._playPlaylist,
    this._seekToNext,
    this._shuffleAll,
    this._playPlayable,
  ) {
    _audioPlayerRepository.managedQueueInfo.availableSongsStream.listen((_) => _setAvSongs());
    _audioPlayerRepository.stateStream.listen((next) {
      _onState(next);
      _setAvSongs();
    });
  }

  final AudioPlayerRepository _audioPlayerRepository;

  final PlayAlbum _playAlbum;
  final PlayAlbumFromIndex _playAlbumFromIndex;
  final PlayArtist _playArtist;
  final PlaySmartList _playSmartList;
  final PlayPlaylist _playPlaylist;
  final PlaySongs _playSongs;
  final PlayPlayable _playPlayable;
  final SeekToNext _seekToNext;
  final ShuffleAll _shuffleAll;

  /// The atomic structural player state, as released by the system layer.
  ///
  /// This is the single observable for structural state. It is fed from
  /// [AudioPlayerRepository.stateStream] and updated in a single [@action], so
  /// mobx observers are notified once per committed snapshot and never see a
  /// torn intermediate state. Everything else structural is a [@computed]
  /// getter on top of it.
  @observable
  AudioPlayerState state = AudioPlayerState.initial();

  @action
  void _onState(AudioPlayerState next) {
    state = next;
  }

  @computed
  Song? get currentSong => state.currentSong;

  @computed
  int? get currentIndex => state.currentIndex;

  @computed
  List<QueueItem> get queue => state.queue;

  @computed
  int get queueLength => state.queue.length;

  @computed
  ShuffleMode get shuffleMode => state.shuffleMode;

  @computed
  LoopMode get loopMode => state.loopMode;

  @computed
  Playable? get playable => state.playable;

  @observable
  late ObservableStream<bool> playingStream = _audioPlayerRepository.playingStream.asObservable();

  @observable
  late ObservableStream<Duration> currentPositionStream =
      _audioPlayerRepository.positionStream.asObservable(initialValue: const Duration(seconds: 0));

  @computed
  String get positionString =>
      utils.msToTimeString(currentPositionStream.value ?? const Duration(seconds: 0));

  @observable
  late List<QueueItem> _availableSongs = [];

  @action
  void _setAvSongs() {
    _availableSongs = filterAvailableSongs(
      _audioPlayerRepository.managedQueueInfo.availableSongsStream.value,
      blockLevel: state.playable == null ? 2 : calcBlockLevel(state.shuffleMode, state.playable!),
    );
  }

  @computed
  int get numAvailableSongs => _availableSongs.length;

  @observable
  bool showLyrics = false;

  @action
  void toggleShowLyrics() {
    showLyrics = !showLyrics;
  }

  @computed
  bool get hasNext =>
      (currentIndex != null && currentIndex! < queueLength - 1) || loopMode != LoopMode.off;

  @computed
  bool get hasPrevious => (currentIndex != null && currentIndex! > 0) || loopMode != LoopMode.off;

  Future<void> playSong(int index, List<Song> songList, Playable playable) async {
    _playSongs(songs: songList, initialIndex: index, playable: playable, keepInitialIndex: true);
  }

  Future<void> play() async => _audioPlayerRepository.play();

  Future<void> pause() async => _audioPlayerRepository.pause();

  Future<void> skipToNext() async => _seekToNext();

  Future<void> skipToPrevious() async => _audioPlayerRepository.seekToPrevious();

  Future<void> seekToIndex(int index) async => _audioPlayerRepository.seekToIndex(index);

  Future<void> seekToPosition(double position) async =>
      _audioPlayerRepository.seekToPosition(position);

  Future<void> setShuffleMode(ShuffleMode shuffleMode) async =>
      _audioPlayerRepository.setShuffleMode(shuffleMode);

  Future<void> setLoopMode(LoopMode loopMode) async => _audioPlayerRepository.setLoopMode(loopMode);

  Future<void> shuffleAll(ShuffleMode shuffleMode) async => _shuffleAll(shuffleMode);

  Future<void> addToQueue(List<Song> songs) async => _audioPlayerRepository.addToQueue(songs);

  Future<void> playNext(List<Song> songs) async => _audioPlayerRepository.playNext(songs);

  Future<void> appendToNext(List<Song> songs) async => _audioPlayerRepository.addToNext(songs);

  Future<void> moveQueueItem(int oldIndex, int newIndex) async =>
      _audioPlayerRepository.moveQueueItem(oldIndex, newIndex);

  Future<void> removeQueueIndices(List<int> indices) async =>
      _audioPlayerRepository.removeQueueIndices(indices);

  Future<void> playAlbum(Album album) async => _playAlbum(album);

  Future<void> playAlbumFromIndex(Album album, int initialIndex) async =>
      _playAlbumFromIndex(album, initialIndex);

  Future<void> playSmartList(SmartList smartList) async => _playSmartList(smartList);

  Future<void> playPlaylist(Playlist playlist) async => _playPlaylist(playlist);

  Future<void> playArtist(Artist artist, ShuffleMode? shuffleMode) async =>
      _playArtist(artist, shuffleMode);

  Future<void> playPlayable(Playable playable, ShuffleMode? shuffleMode) async =>
      _playPlayable(playable, shuffleMode);
}
