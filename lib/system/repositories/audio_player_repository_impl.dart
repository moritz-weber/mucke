import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/playback_event.dart';
import '../../domain/entities/queue_item.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/song.dart';
import '../../domain/modules/managed_queue.dart';
import '../../domain/repositories/audio_player_repository.dart';
import '../datasources/audio_player_data_source.dart';
import '../models/song_model.dart';

class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  AudioPlayerRepositoryImpl(this._audioPlayerDataSource, this._managedQueue) {
    _shuffleModeSubject.add(ShuffleMode.none);
    _loopModeSubject.add(LoopMode.off);

    _audioPlayerDataSource.currentIndexStream.listen(
      (index) {
        _currentIndexSubject.add(index);
        if (!blockIndexUpdate) {
          _updateCurrentSong(queueStream.value, index);
        }
      },
    );
    _queueSubject.listen((queue) {
      if (currentIndexStream.hasValue) {
        _updateCurrentSong(queue, currentIndexStream.value);
      }
    });
  }

  static final _log = FimberLog('AudioPlayerRepositoryImpl');

  final AudioPlayerDataSource _audioPlayerDataSource;
  final ManagedQueue _managedQueue;

  final BehaviorSubject<int> _currentIndexSubject = BehaviorSubject();
  final BehaviorSubject<Song> _currentSongSubject = BehaviorSubject();
  final BehaviorSubject<LoopMode> _loopModeSubject = BehaviorSubject();
  final BehaviorSubject<List<Song>> _queueSubject = BehaviorSubject();
  final BehaviorSubject<ShuffleMode> _shuffleModeSubject = BehaviorSubject();

  // temporarily block song updating via index updates to avoid double updates on shufflemode change
  bool blockIndexUpdate = false;

  @override
  ValueStream<ShuffleMode> get shuffleModeStream => _shuffleModeSubject.stream;

  @override
  ValueStream<LoopMode> get loopModeStream => _loopModeSubject.stream;

  @override
  ValueStream<List<Song>> get queueStream => _queueSubject.stream;

  @override
  ValueStream<int> get currentIndexStream => _currentIndexSubject.stream;

  @override
  Stream<Song> get currentSongStream => _currentSongSubject.stream;

  @override
  Stream<PlaybackEvent> get playbackEventStream => _audioPlayerDataSource.playbackEventStream;

  @override
  Stream<bool> get playingStream => _audioPlayerDataSource.playingStream;

  @override
  Stream<Duration> get positionStream => _audioPlayerDataSource.positionStream;

  @override
  ManagedQueueInfo get managedQueueInfo => _managedQueue;

  @override
  Future<void> addToQueue(Song song) async {
    _log.d('addToQueue');
    _audioPlayerDataSource.addToQueue(song as SongModel);
    _managedQueue.addToQueue(song);
    _queueSubject.add(_managedQueue.queue);
  }

  @override
  Future<void> dispose() async {
    _audioPlayerDataSource.dispose();
  }

  @override
  Future<void> initQueue(
    List<QueueItem> queueItems,
    List<Song> originalSongs,
    List<Song> addedSongs,
    int index,
  ) async {
    _managedQueue.initQueue(queueItems, originalSongs, addedSongs);
    _queueSubject.add(_managedQueue.queue);

    await _audioPlayerDataSource.loadQueue(
      initialIndex: index,
      queue: _managedQueue.queue.map((e) => e as SongModel).toList(),
    );
  }

  @override
  Future<void> loadSongs({required List<Song> songs, required int initialIndex}) async {
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
    _managedQueue.moveQueueItem(oldIndex, newIndex);
    final newCurrentIndex = _calcNewCurrentIndexOnMove(
      currentIndexStream.value,
      oldIndex,
      newIndex,
    );
    _currentIndexSubject.add(newCurrentIndex);
    _queueSubject.add(_managedQueue.queue);

    _audioPlayerDataSource.moveQueueItem(oldIndex, newIndex);
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

    _managedQueue.insertIntoQueue(song, (currentIndexStream.valueOrNull ?? 0) + 1);
    _queueSubject.add(_managedQueue.queue);
  }

  @override
  Future<void> removeQueueIndex(int index) async {
    _managedQueue.removeQueueIndex(index);

    final newCurrentIndex = _calcNewCurrentIndexOnRemove(currentIndexStream.value, index);
    _currentIndexSubject.add(newCurrentIndex);
    _queueSubject.add(_managedQueue.queue);

    _audioPlayerDataSource.removeQueueIndex(index);
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
  Future<void> setShuffleMode(ShuffleMode shuffleMode, {bool updateQueue = true}) async {
    _shuffleModeSubject.add(shuffleMode);

    final currentIndex = currentIndexStream.valueOrNull ?? 0;

    if (updateQueue) {
      final splitIndex = await _managedQueue.reshuffleQueue(shuffleMode, currentIndex);
      blockIndexUpdate = true;

      _audioPlayerDataSource
          .replaceQueueAroundIndex(
        index: currentIndex,
        before: _managedQueue.queue.sublist(0, splitIndex).map((e) => e as SongModel).toList(),
        after: _managedQueue.queue.sublist(splitIndex + 1).map((e) => e as SongModel).toList(),
      )
          .then((_) {
        _queueSubject.add(_managedQueue.queue);
      });
    }
  }

  @override
  Future<void> stop() async {
    _audioPlayerDataSource.stop();
  }

  @override
  Future<void> updateSongs(Map<String, Song> songs) async {
    if (songs.containsKey(_currentSongSubject.valueOrNull?.path)) {
      _currentSongSubject.add(songs[_currentSongSubject.value.path]!);
    }

    if (_managedQueue.updateSongs(songs)) {
      _queueSubject.add(_managedQueue.queue);
    }
  }

  void _updateCurrentSong(List<Song>? queue, int? index) {
    if (queue != null && index != null && index < queue.length) {
      _log.d('Current song: ${queue[index]}');
      _currentSongSubject.add(queue[index]);
    }
    // idea: unblock index update, once the current song has been updated (via queue update)
    blockIndexUpdate = false;
  }

  /// Calculate the new current index when removing the song at [removeIndex].
  int _calcNewCurrentIndexOnRemove(int currentIndex, int removeIndex) {
    int result = currentIndex;
    if (removeIndex < currentIndex) {
      result--;
    }
    return result;
  }

  /// Calculate the new current index when moving a song from [oldIndex] to [newIndex].
  int _calcNewCurrentIndexOnMove(int currentIndex, int oldIndex, int newIndex) {
    int newCurrentIndex = currentIndex;
    if (oldIndex == currentIndex) {
      newCurrentIndex = newIndex;
    } else {
      if (oldIndex < currentIndex) {
        newCurrentIndex--;
      }
      if (newIndex < currentIndex) {
        newCurrentIndex++;
      }
    }
    return newCurrentIndex;
  }
}
