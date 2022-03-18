import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/playable.dart';
import '../../domain/entities/playback_event.dart';
import '../../domain/entities/queue_item.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/song.dart';
import '../../domain/modules/dynamic_queue.dart';
import '../../domain/modules/managed_queue_info.dart';
import '../../domain/repositories/audio_player_repository.dart';
import '../datasources/audio_player_data_source.dart';
import '../models/song_model.dart';
import '../utils.dart';

class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  AudioPlayerRepositoryImpl(this._audioPlayerDataSource, this._dynamicQueue) {
    _shuffleModeSubject.add(ShuffleMode.none);
    _loopModeSubject.add(LoopMode.off);

    _audioPlayerDataSource.currentIndexStream.listen(
      (index) {
        _currentIndexSubject.add(index);
        if (!_blockIndexUpdate) {
          _updateCurrentSong(queueStream.value, index);
        }
        _dynamicQueue.updateCurrentIndex(index).then((songs) {
          if (songs.isNotEmpty) {
            _audioPlayerDataSource.addToQueue(songs.map((e) => e as SongModel).toList());
            _queueSubject.add(_dynamicQueue.queue);
          }
        });
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
  final DynamicQueue _dynamicQueue;

  final BehaviorSubject<int> _currentIndexSubject = BehaviorSubject();
  final BehaviorSubject<Song> _currentSongSubject = BehaviorSubject();
  final BehaviorSubject<LoopMode> _loopModeSubject = BehaviorSubject();
  final BehaviorSubject<List<Song>> _queueSubject = BehaviorSubject();
  final BehaviorSubject<ShuffleMode> _shuffleModeSubject = BehaviorSubject();
  final BehaviorSubject<Playable> _playableSubject = BehaviorSubject();

  // temporarily block song updating via index updates to avoid double updates on shufflemode change
  bool _blockIndexUpdate = false;

  @override
  ValueStream<ShuffleMode> get shuffleModeStream => _shuffleModeSubject.stream;

  @override
  ValueStream<LoopMode> get loopModeStream => _loopModeSubject.stream;

  @override
  ValueStream<Playable> get playableStream => _playableSubject.stream;

  @override
  ValueStream<List<Song>> get queueStream => _queueSubject.stream;

  @override
  ValueStream<int> get currentIndexStream => _currentIndexSubject.stream;

  @override
  Stream<Song> get currentSongStream => _currentSongSubject.stream.distinct();

  @override
  Stream<PlaybackEvent> get playbackEventStream => _audioPlayerDataSource.playbackEventStream;

  @override
  Stream<bool> get playingStream => _audioPlayerDataSource.playingStream;

  @override
  Stream<Duration> get positionStream => _audioPlayerDataSource.positionStream;

  @override
  ManagedQueueInfo get managedQueueInfo => _dynamicQueue;

  @override
  Future<void> addToQueue(List<Song> songs) async {
    _audioPlayerDataSource.addToQueue(songs.map((e) => e as SongModel).toList());
    _dynamicQueue.addToQueue(songs);
    _queueSubject.add(_dynamicQueue.queue);
  }

  @override
  Future<void> dispose() async {
    _audioPlayerDataSource.dispose();
  }

  @override
  Future<void> initQueue(
    List<QueueItem> queueItems,
    List<QueueItem> availableSongs,
    Playable playable,
    int index,
  ) async {
    _log.d('initQueue');
    _playableSubject.add(playable);

    _dynamicQueue.init(
      queueItems,
      availableSongs,
      playable,
      shuffleModeStream.value,
    );
    _queueSubject.add(_dynamicQueue.queue);

    await _audioPlayerDataSource.loadQueue(
      initialIndex: index,
      queue: _dynamicQueue.queue.map((e) => e as SongModel).toList(),
    );
  }

  @override
  Future<void> loadSongs({
    required List<Song> songs,
    required int initialIndex,
    required Playable playable,
    bool keepInitialIndex = false,
  }) async {
    _playableSubject.add(playable);
    final shuffleMode = shuffleModeStream.value;
    final _initialIndex = await _dynamicQueue.generateQueue(
      songs,
      playable,
      initialIndex,
      shuffleMode,
      keepIndex: keepInitialIndex,
    );

    _queueSubject.add(_dynamicQueue.queue);

    await _audioPlayerDataSource.loadQueue(
      initialIndex: _initialIndex,
      queue: _dynamicQueue.queue.map((e) => e as SongModel).toList(),
    );
  }

  @override
  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    _dynamicQueue.moveQueueItem(oldIndex, newIndex);
    final newCurrentIndex = _calcNewCurrentIndexOnMove(
      currentIndexStream.value,
      oldIndex,
      newIndex,
    );
    // _audioPlayerDataSource will actually result in the correct update as well
    // doing this manually here minimizes the time of inconsistent state though
    _currentIndexSubject.add(newCurrentIndex);
    _queueSubject.add(_dynamicQueue.queue);

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
  Future<void> playNext(List<Song> songs) async {
    _audioPlayerDataSource.playNext(songs.map((e) => e as SongModel).toList());

    _dynamicQueue.insertIntoQueue(songs, (currentIndexStream.valueOrNull ?? 0) + 1);
    _queueSubject.add(_dynamicQueue.queue);
  }

  @override
  Future<void> addToNext(List<Song> songs) async {
    final index = _dynamicQueue.getNextNormalIndex(currentIndexStream.value + 1);

    _audioPlayerDataSource.insertIntoQueue(songs.map((e) => e as SongModel).toList(), index);

    _dynamicQueue.insertIntoQueue(songs, index);
    _queueSubject.add(_dynamicQueue.queue);
  }

  @override
  Future<void> removeQueueIndex(int index) async {
    _removeQueueIndex(index, true);
  }

  Future<void> _removeQueueIndex(int index, bool permanent) async {
    _dynamicQueue.removeQueueIndex(index, permanent);

    final newCurrentIndex = _calcNewCurrentIndexOnRemove(currentIndexStream.value, index);
    _currentIndexSubject.add(newCurrentIndex);
    _queueSubject.add(_dynamicQueue.queue);

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
      final splitIndex = await _dynamicQueue.reshuffleQueue(shuffleMode, currentIndex);
      _blockIndexUpdate = true;

      _audioPlayerDataSource
          .replaceQueueAroundIndex(
        index: currentIndex,
        before: _dynamicQueue.queue.sublist(0, splitIndex).map((e) => e as SongModel).toList(),
        after: _dynamicQueue.queue.sublist(splitIndex + 1).map((e) => e as SongModel).toList(),
      )
          .then((_) {
        _queueSubject.add(_dynamicQueue.queue);
      });
    }
  }

  @override
  Future<void> stop() async {
    _audioPlayerDataSource.stop();
  }

  @override
  Future<void> updateSongs(Map<String, Song> songs) async {
    // TODO: handle removing songs/current song here? could be easier to coordinate with playerdatasource
    if (songs.containsKey(_currentSongSubject.valueOrNull?.path)) {
      _currentSongSubject.add(songs[_currentSongSubject.value.path]!);
    }

    if (_dynamicQueue.updateSongs(songs)) {
      final blockLevel = calcBlockLevel(shuffleModeStream.value, playableStream.value);
      final queue = _dynamicQueue.queue;

      for (int i = 0; i < queue.length; i++) {
        final song = queue[i];
        if (song.blockLevel > blockLevel) {
          _removeQueueIndex(i, false);
        }
      }

      _queueSubject.add(_dynamicQueue.queue);
    }
  }

  void _updateCurrentSong(List<Song>? queue, int? index) {
    if (queue != null && index != null && index < queue.length) {
      _log.d('Current song: ${queue[index]}');
      _currentSongSubject.add(queue[index]);
    }
    // idea: unblock index update, once the current song has been updated (via queue update)
    _blockIndexUpdate = false;
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
      // moving the currently playing song
      newCurrentIndex = newIndex;
    } else {
      if (oldIndex < currentIndex) {
        newCurrentIndex--;
      }
      if (newIndex <= currentIndex) {
        newCurrentIndex++;
      }
    }
    return newCurrentIndex;
  }

  @override
  Future<void> seekToPosition(double position) async =>
      _audioPlayerDataSource.seekToPosition(position);
}
