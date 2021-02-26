import 'package:rxdart/rxdart.dart';

import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/playback_event.dart';
import '../../domain/entities/queue_item.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/audio_player_repository.dart';
import '../datasources/audio_player_data_source.dart';
import '../models/song_model.dart';

class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  AudioPlayerRepositoryImpl(this._audioPlayerDataSource) {
    _shuffleModeSubject.add(ShuffleMode.none);
    _loopModeSubject.add(LoopMode.off);
  }

  final AudioPlayerDataSource _audioPlayerDataSource;

  // final BehaviorSubject<int> _currentIndexSubject = BehaviorSubject();
  // final BehaviorSubject<Song> _currentSongSubject = BehaviorSubject<Song>();
  final BehaviorSubject<LoopMode> _loopModeSubject = BehaviorSubject();
  final BehaviorSubject<List<Song>> _songListSubject = BehaviorSubject();
  final BehaviorSubject<List<QueueItem>> _queueSubject = BehaviorSubject();
  final BehaviorSubject<ShuffleMode> _shuffleModeSubject = BehaviorSubject();

  @override
  Stream<AudioPlayerEvent> eventStream;

  @override
  ValueStream<ShuffleMode> get shuffleModeStream => _shuffleModeSubject.stream;

  @override
  ValueStream<LoopMode> get loopModeStream => _loopModeSubject.stream;

  @override
  ValueStream<List<Song>> get songListStream => _songListSubject.stream;

  @override
  ValueStream<List<QueueItem>> get queueStream => _queueSubject.stream;

  @override
  ValueStream<int> get currentIndexStream => _audioPlayerDataSource.currentIndexStream;

  @override
  Stream<Song> get currentSongStream => _audioPlayerDataSource.currentSongStream;

  @override
  Stream<PlaybackEvent> get playbackEventStream => _audioPlayerDataSource.playbackEventStream;

  @override
  Stream<bool> get playingStream => _audioPlayerDataSource.playingStream;

  @override
  Stream<Duration> get positionStream => _audioPlayerDataSource.positionStream;

  @override
  Future<void> addToQueue(Song song) {
    // TODO: implement addToQueue
    throw UnimplementedError();
  }

  @override
  Future<void> dispose() async {
    _audioPlayerDataSource.dispose();
  }

  @override
  Future<void> loadQueue({List<QueueItem> queue, int initialIndex}) async {
    // _currentSongSubject.add(queue[initialIndex]);
    _queueSubject.add(queue);
    _songListSubject.add(queue.map((e) => e.song).toList());
    // _currentIndexSubject.add(initialIndex);

    await _audioPlayerDataSource.loadQueue(
      initialIndex: initialIndex,
      queue: queue.map((e) => e as SongModel).toList(),
    );
  }

  @override
  Future<void> moveQueueItem(int oldIndex, int newIndex) {
    // TODO: implement moveQueueItem
    throw UnimplementedError();
  }

  @override
  Future<void> pause() async {
    _audioPlayerDataSource.pause();
  }

  @override
  Future<void> play() async {
    _audioPlayerDataSource.play();
  }

  @override
  Future<void> playSong(Song song) async {
    await _audioPlayerDataSource.loadQueue(
      initialIndex: 0,
      queue: [song as SongModel],
    );
    _audioPlayerDataSource.play();
  }

  @override
  Future<void> removeQueueIndex(int index) {
    // TODO: implement removeQueueIndex
    throw UnimplementedError();
  }

  @override
  Future<bool> seekToNext() async {
    return await _audioPlayerDataSource.seekToNext();
  }

  @override
  Future<void> seekToPrevious() async {
    await _audioPlayerDataSource.seekToPrevious();
  }

  @override
  Future<void> setIndex(int index) {
    // TODO: implement setIndex
    throw UnimplementedError();
  }

  @override
  Future<void> setLoopMode(LoopMode loopMode) async {
    _loopModeSubject.add(loopMode);
    await _audioPlayerDataSource.setLoopMode(loopMode);
  }

  @override
  Future<void> setShuffleMode(ShuffleMode shuffleMode) async {
    _shuffleModeSubject.add(shuffleMode);
  }

  @override
  Future<void> stop() {
    // TODO: implement stop
    throw UnimplementedError();
  }
}
