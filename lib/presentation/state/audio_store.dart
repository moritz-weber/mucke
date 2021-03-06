import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/audio_player_repository.dart';
import '../../domain/usecases/add_to_queue.dart';
import '../../domain/usecases/move_queue_item.dart';
import '../../domain/usecases/pause.dart';
import '../../domain/usecases/play.dart';
import '../../domain/usecases/play_next.dart';
import '../../domain/usecases/play_songs.dart';
import '../../domain/usecases/remove_queue_index.dart';
import '../../domain/usecases/seek_to_index.dart';
import '../../domain/usecases/seek_to_next.dart';
import '../../domain/usecases/seek_to_previous.dart';
import '../../domain/usecases/set_loop_mode.dart';
import '../../domain/usecases/set_shuffle_mode.dart';
import '../../domain/usecases/shuffle_all.dart';

part 'audio_store.g.dart';

class AudioStore extends _AudioStore with _$AudioStore {
  AudioStore({
    @required AddToQueue addToQueue,
    @required MoveQueueItem moveQueueItem,
    @required Pause pause,
    @required Play play,
    @required PlayNext playNext,
    @required PlaySongs playSongs,
    @required RemoveQueueIndex removeQueueIndex,
    @required SeekToIndex seekToIndex,
    @required SeekToNext seekToNext,
    @required SeekToPrevious seekToPrevious,
    @required SetLoopMode setLoopMode,
    @required SetShuffleMode setShuffleMode,
    @required ShuffleAll shuffleAll,
    @required AudioPlayerInfoRepository audioPlayerInfoRepository,
  }) : super(
          addToQueue,
          moveQueueItem,
          playSongs,
          audioPlayerInfoRepository,
          pause,
          play,
          playNext,
          removeQueueIndex,
          seekToIndex,
          seekToNext,
          seekToPrevious,
          setLoopMode,
          setShuffleMode,
          shuffleAll,
        );
}

abstract class _AudioStore with Store {
  _AudioStore(
    this._addToQueue,
    this._moveQueueItem,
    this._playSongs,
    this._audioPlayerInfoRepository,
    this._pause,
    this._play,
    this._playNext,
    this._removeQueueIndex,
    this._seekToIndex,
    this._seekToNext,
    this._seekToPrevious,
    this._setLoopMode,
    this._setShuffleMode,
    this._shuffleAll,
  ) {
    currentPositionStream = _audioPlayerInfoRepository.positionStream
        .asObservable(initialValue: const Duration(seconds: 0));

    queueStream = _audioPlayerInfoRepository.queueStream.asObservable();

    queueIndexStream = _audioPlayerInfoRepository.currentIndexStream.asObservable();

    currentSongStream = _audioPlayerInfoRepository.currentSongStream.asObservable();

    shuffleModeStream = _audioPlayerInfoRepository.shuffleModeStream.asObservable();

    loopModeStream = _audioPlayerInfoRepository.loopModeStream.asObservable();

    playingStream = _audioPlayerInfoRepository.playingStream.asObservable();
  }

  final AudioPlayerInfoRepository _audioPlayerInfoRepository;

  final AddToQueue _addToQueue;
  final MoveQueueItem _moveQueueItem;
  final Pause _pause;
  final Play _play;
  final PlayNext _playNext;
  final PlaySongs _playSongs;
  final RemoveQueueIndex _removeQueueIndex;
  final SeekToIndex _seekToIndex;
  final SeekToNext _seekToNext;
  final SeekToPrevious _seekToPrevious;
  final SetLoopMode _setLoopMode;
  final SetShuffleMode _setShuffleMode;
  final ShuffleAll _shuffleAll;

  @observable
  ObservableStream<Song> currentSongStream;

  @observable
  ObservableStream<bool> playingStream;

  @observable
  ObservableStream<Duration> currentPositionStream;

  // beware that this only triggers reactions when a new list (new reference) is set
  // doesn't work if the same reference is added to BehaviorSubject
  @observable
  ObservableStream<List<Song>> queueStream;

  @observable
  ObservableStream<int> queueIndexStream;

  @observable
  ObservableStream<ShuffleMode> shuffleModeStream;

  @observable
  ObservableStream<LoopMode> loopModeStream;

  Future<void> playSong(int index, List<Song> songList) async {
    _playSongs(songs: songList, initialIndex: index);
  }

  Future<void> play() async {
    _play();
  }

  Future<void> pause() async {
    _pause();
  }

  Future<void> skipToNext() async {
    _seekToNext();
  }

  Future<void> skipToPrevious() async {
    _seekToPrevious();
  }

  Future<void> seekToIndex(int index) async {
    _seekToIndex(index);
  }

  Future<void> setShuffleMode(ShuffleMode shuffleMode) async {
    _setShuffleMode(shuffleMode);
  }

  Future<void> setLoopMode(LoopMode loopMode) async {
    _setLoopMode(loopMode);
  }

  Future<void> shuffleAll() async {
    _shuffleAll();
  }

  Future<void> addToQueue(Song song) async {
    _addToQueue(song);
  }

  Future<void> playNext(Song song) async {
    _playNext(song);
  }

  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    _moveQueueItem(oldIndex, newIndex);
  }

  Future<void> removeQueueIndex(int index) async {
    _removeQueueIndex(index);
  }

  Future<void> playAlbum(Album album) async {
    // _audioInterface.playAlbum(album);
  }

  Future<void> shuffleArtist(Artist artist) async {
    // _audioInterface.playArtist(artist, shuffleMode: ShuffleMode.plus);
  }
}
