import 'package:rxdart/rxdart.dart';

import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/playback_event.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/song.dart';
import '../../domain/modules/queue_manager.dart';
import '../../domain/repositories/audio_player_repository.dart';
import '../datasources/audio_player_data_source.dart';
import '../models/song_model.dart';

class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  AudioPlayerRepositoryImpl(this._audioPlayerDataSource, this._managedQueue) {
    _shuffleModeSubject.add(ShuffleMode.none);
    _loopModeSubject.add(LoopMode.off);

    _audioPlayerDataSource.currentIndexStream.listen(
      (index) => _updateCurrentSong(queueStream.value, index),
    );
    _queueSubject.listen((queue) => _updateCurrentSong(queue, currentIndexStream.value));
  }

  final AudioPlayerDataSource _audioPlayerDataSource;
  final ManagedQueue _managedQueue;

  // final BehaviorSubject<int> _currentIndexSubject = BehaviorSubject();
  final BehaviorSubject<Song> _currentSongSubject = BehaviorSubject();
  final BehaviorSubject<LoopMode> _loopModeSubject = BehaviorSubject();
  final BehaviorSubject<List<Song>> _queueSubject = BehaviorSubject();
  final BehaviorSubject<ShuffleMode> _shuffleModeSubject = BehaviorSubject();

  @override
  Stream<AudioPlayerEvent> eventStream;

  @override
  ValueStream<ShuffleMode> get shuffleModeStream => _shuffleModeSubject.stream;

  @override
  ValueStream<LoopMode> get loopModeStream => _loopModeSubject.stream;

  @override
  ValueStream<List<Song>> get queueStream => _queueSubject.stream;

  @override
  ValueStream<int> get currentIndexStream => _audioPlayerDataSource.currentIndexStream;

  @override
  Stream<Song> get currentSongStream => _currentSongSubject.stream;

  @override
  Stream<PlaybackEvent> get playbackEventStream => _audioPlayerDataSource.playbackEventStream;

  @override
  Stream<bool> get playingStream => _audioPlayerDataSource.playingStream;

  @override
  Stream<Duration> get positionStream => _audioPlayerDataSource.positionStream;

  @override
  Future<void> addToQueue(Song song) async {
    _audioPlayerDataSource.addToQueue(song as SongModel);
    _managedQueue.addToQueue(song);
    _queueSubject.add(_managedQueue.queue);
  }

  @override
  Future<void> dispose() async {
    _audioPlayerDataSource.dispose();
  }

  @override
  Future<void> loadSongs({List<Song> songs, int initialIndex}) async {
    final shuffleMode = shuffleModeStream.value;
    final _initialIndex = await _managedQueue.generateQueue(shuffleMode, songs, initialIndex);

    _queueSubject.add(_managedQueue.queue);

    await _audioPlayerDataSource.loadQueue(
      initialIndex: _initialIndex,
      queue: _managedQueue.queue.map((e) => e as SongModel).toList(),
    );
  }

  @override
  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    _audioPlayerDataSource.moveQueueItem(oldIndex, newIndex);

    _managedQueue.moveQueueItem(oldIndex, newIndex);
    _queueSubject.add(_managedQueue.queue);
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
  Future<void> playNext(Song song) async {
    _audioPlayerDataSource.playNext(song as SongModel);

    _managedQueue.insertIntoQueue(song, currentIndexStream.value + 1);
    _queueSubject.add(_managedQueue.queue);
  }

  @override
  Future<void> removeQueueIndex(int index) async {
    _audioPlayerDataSource.removeQueueIndex(index);

    _managedQueue.removeQueueIndex(index);
    _queueSubject.add(_managedQueue.queue);
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
  Future<void> seekToIndex(int index) async {
    await _audioPlayerDataSource.seekToIndex(index);
  }

  @override
  Future<void> setLoopMode(LoopMode loopMode) async {
    _loopModeSubject.add(loopMode);
    await _audioPlayerDataSource.setLoopMode(loopMode);
  }

  @override
  Future<void> setShuffleMode(ShuffleMode shuffleMode, {bool updateQueue}) async {
    _shuffleModeSubject.add(shuffleMode);

    final currentIndex = currentIndexStream.value;

    if (updateQueue) {
      final splitIndex = await _managedQueue.reshuffleQueue(shuffleMode, currentIndex);
      _queueSubject.add(_managedQueue.queue);

      await _audioPlayerDataSource.replaceQueueAroundIndex(
        index: currentIndex,
        before: _managedQueue.queue.sublist(0, splitIndex).map((e) => e as SongModel).toList(),
        after: _managedQueue.queue.sublist(splitIndex + 1).map((e) => e as SongModel).toList(),
      );
    }
  }

  @override
  Future<void> stop() {
    // TODO: implement stop
    throw UnimplementedError();
  }

  // TODO: this should be in ManagedQueue
  @override
  Future<void> updateSongs(Map<String, Song> songs) async {
    if (songs.containsKey(_currentSongSubject.value.path)) {
      _currentSongSubject.add(songs[_currentSongSubject.value.path]);
    }

    final queue = _queueSubject.value;
    bool changed = false;

    for (int i = 0; i < queue.length; i++) {
      if (songs.containsKey(queue[i].path)) {
        queue[i] = songs[queue[i].path];
        changed = true;
      }
    }

    if (changed) _queueSubject.add(queue);
  }

  void _updateCurrentSong(List<Song> queue, int index) {
    if (queue != null && index != null && index < queue.length) {
      _currentSongSubject.add(queue[index]);
    }
  }
}
