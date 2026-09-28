import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/audio_player_state.dart';
import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/playable.dart';
import '../../domain/entities/playback_event.dart';
import '../../domain/entities/queue_item.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/song.dart';
import '../../domain/modules/dynamic_queue.dart';
import '../../domain/modules/managed_queue_info.dart';
import '../../domain/repositories/audio_player_repository.dart';
import '../../domain/utils.dart';
import '../datasources/audio_player_data_source.dart';
import '../models/song_model.dart';

class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  AudioPlayerRepositoryImpl(this._audioPlayerDataSource, this._dynamicQueue) {
    _shuffleMode = ShuffleMode.none;
    _loopMode = LoopMode.off;

    _audioPlayerDataSource.currentIndexStream.listen(_onDataSourceIndexChanged);
    positionStream.listen((position) async {
      final durationMs = _audioPlayerDataSource.durationStream.valueOrNull?.inMilliseconds;
      final positionMs = position.inMilliseconds;

      if (loopModeStream.value == LoopMode.stop &&
          durationMs != null &&
          // less than 101 milliseconds in the song remaining
          positionMs > durationMs - 101 &&
          // don't skip to next if we aren't playing
          _audioPlayerDataSource.playingStream.value) {
        await pause();
        await seekToNext();
      }
    });
  }

  static final _log = Logger('AudioPlayerRepositoryImpl');

  final AudioPlayerDataSource _audioPlayerDataSource;
  final DynamicQueue _dynamicQueue;

  ShuffleMode _shuffleMode = ShuffleMode.none;
  LoopMode _loopMode = LoopMode.off;
  Playable? _playable;

  /// The structural state, released as atomic snapshots.
  final BehaviorSubject<AudioPlayerState> _stateSubject =
      BehaviorSubject.seeded(AudioPlayerState.initial());

  late final ValueStream<ShuffleMode> _shuffleModeStream =
      ValueConnectableStream<ShuffleMode>.seeded(
    stateStream.skip(1).map((state) => state.shuffleMode).distinct(),
    _stateSubject.value.shuffleMode,
  )..connect();

  late final ValueStream<LoopMode> _loopModeStream = ValueConnectableStream<LoopMode>.seeded(
    stateStream.skip(1).map((state) => state.loopMode).distinct(),
    _stateSubject.value.loopMode,
  )..connect();

  late final ValueStream<Playable> _playableStream = ValueConnectableStream<Playable>(
    stateStream.map((state) => state.playable).whereType<Playable>().distinct(),
  )..connect();

  late final ValueStream<List<Song>> _queueStream = ValueConnectableStream<List<Song>>.seeded(
    stateStream.skip(1).map(
          (state) => state.queue.map((item) => item.song).toList(),
        ),
    _stateSubject.value.queue.map((item) => item.song).toList(),
  )..connect();

  late final ValueStream<int?> _currentIndexStream = ValueConnectableStream<int?>.seeded(
    stateStream.skip(1).map((state) => state.currentIndex).distinct(),
    _stateSubject.value.currentIndex,
  )..connect();

  /// Monotonic token identifying the transition that produced the latest snapshot.
  int _stateRevision = 0;

  /// The index of the current song within the queue.
  int? _currentIndex;

  /// Serializes all structural transitions.
  ///
  /// Every mutation of the queue/index/mode state is appended here, so that
  /// transitions never interleave. Each transition mutates the internal model
  /// and then releases exactly one consistent snapshot via [_emitState].
  Future<void> _transitionChain = Future.value();

  /// Appends [transition] to the serialized transition chain and returns its result.
  Future<T> _enqueueTransition<T>(Future<T> Function() transition) {
    final result = _transitionChain.then((_) => transition());
    // keep the chain alive even if a transition fails
    _transitionChain = result.then<void>((_) {}, onError: (Object _) {});
    return result;
  }

  /// Reacts to an index change reported by the audio player.
  void _onDataSourceIndexChanged(int index) {
    _enqueueTransition(() async {
      if (index != _currentIndex) {
        _currentIndex = index;
        _emitState();
      }
      await _extendQueue(index);
    }).catchError((Object error, StackTrace stackTrace) {
      _log.warning('index transition failed', error, stackTrace);
    });
  }

  /// Queues more songs ahead of [index] and releases a snapshot if the queue grew.
  Future<void> _extendQueue(int index) async {
    final songs = await _dynamicQueue.onCurrentIndexUpdated(
      index,
      _shuffleMode,
    );
    if (songs.isNotEmpty) {
      await _audioPlayerDataSource.addToQueue(songs.map((e) => e as SongModel).toList());
      _emitState();
    }
  }

  @override
  ValueStream<AudioPlayerState> get stateStream => _stateSubject.stream;

  @override
  ValueStream<ShuffleMode> get shuffleModeStream => _shuffleModeStream;

  @override
  ValueStream<LoopMode> get loopModeStream => _loopModeStream;

  @override
  ValueStream<Playable> get playableStream => _playableStream;

  @override
  ValueStream<List<Song>> get queueStream => _queueStream;

  @override
  ValueStream<int?> get currentIndexStream => _currentIndexStream;

  @override
  Stream<Song?> get currentSongStream => stateStream
      .map((state) => state.currentSong)
      .distinct()
      // the seeded initial snapshot carries no song; consumers that await the
      // first song (e.g. `currentSongStream.first`) must not see it
      .skipWhile((song) => song == null);

  @override
  Stream<PlaybackEvent> get playbackEventStream => _audioPlayerDataSource.playbackEventStream;

  @override
  Stream<bool> get playingStream => _audioPlayerDataSource.playingStream;

  @override
  Stream<Duration> get positionStream => _audioPlayerDataSource.positionStream;

  @override
  ManagedQueueInfo get managedQueueInfo => _dynamicQueue;

  @override
  Future<void> addToQueue(List<Song> songs) => _enqueueTransition(() async {
        await _audioPlayerDataSource.addToQueue(songs.map((e) => e as SongModel).toList());
        _dynamicQueue.addToQueue(songs);
        _emitState();
      });

  Future<void> dispose() async {
    _audioPlayerDataSource.dispose();
  }

  @override
  Future<void> initQueue(
    List<QueueItem> queueItems,
    List<QueueItem> availableSongs,
    Playable playable,
    int? index,
  ) =>
      _enqueueTransition(() async {
        _log.fine('initQueue');
        _playable = playable;

        if (index != null) {
          _dynamicQueue.init(
            queueItems,
            availableSongs,
            playable,
          );
          final queue = _dynamicQueue.queue;
          _currentIndex = index;

          await _audioPlayerDataSource.loadQueue(
            initialIndex: index,
            queue: queue.map((e) => e as SongModel).toList(),
          );
          _log.fine('initQueue: audio queue loaded');
        } else {
          _log.fine('initQueue: no persisted index; audio queue load skipped');
        }

        _emitState();
      });

  @override
  Future<void> loadSongs({
    required List<Song> songs,
    required int initialIndex,
    required Playable playable,
    bool keepInitialIndex = false,
  }) =>
      _enqueueTransition(() async {
        _playable = playable;
        final shuffleMode = _shuffleMode;
        final _initialIndex = await _dynamicQueue.generateQueue(
          songs,
          playable,
          initialIndex,
          shuffleMode,
          keepIndex: keepInitialIndex,
        );

        final queue = _dynamicQueue.queue;
        _currentIndex = _initialIndex;

        await _audioPlayerDataSource.loadQueue(
          initialIndex: _initialIndex,
          queue: queue.map((e) => e as SongModel).toList(),
        );
        _emitState();
      });

  @override
  Future<void> moveQueueItem(int oldIndex, int newIndex) => _enqueueTransition(() async {
        _dynamicQueue.moveQueueItem(oldIndex, newIndex);
        _currentIndex = _audioPlayerDataSource.calcNewCurrentIndexOnMove(
          _currentIndex ?? 0,
          oldIndex,
          newIndex,
        );
        _emitState();

        await _audioPlayerDataSource.moveQueueItem(oldIndex, newIndex);
      });

  @override
  Future<void> pause() async {
    _audioPlayerDataSource.pause();
  }

  @override
  Future<void> play() async {
    _audioPlayerDataSource.play();
  }

  @override
  Future<void> playNext(List<Song> songs) => _enqueueTransition(() async {
        await _audioPlayerDataSource.playNext(songs.map((e) => e as SongModel).toList());

        _dynamicQueue.insertIntoQueue(songs, (_currentIndex ?? 0) + 1);
        _emitState();
      });

  @override
  Future<void> addToNext(List<Song> songs) => _enqueueTransition(() async {
        final index = _dynamicQueue.getNextNormalIndex((_currentIndex ?? 0) + 1);

        await _audioPlayerDataSource.insertIntoQueue(
          songs.map((e) => e as SongModel).toList(),
          index,
        );

        _dynamicQueue.insertIntoQueue(songs, index);
        _emitState();
      });

  @override
  Future<void> removeQueueIndices(List<int> indices) =>
      _enqueueTransition(() => _removeQueueIndices(indices, true));

  Future<void> _removeQueueIndices(List<int> indices, bool permanent) async {
    _dynamicQueue.removeQueueIndices(indices, permanent);
    final newQueue = _dynamicQueue.queue;

    final newCurrentIndex =
        newQueue.isNotEmpty ? _calcNewCurrentIndexOnRemove(_currentIndex ?? 0, indices) : 0;
    _currentIndex = newCurrentIndex;
    _emitState();

    if (newQueue.isEmpty) {
      if (_dynamicQueue.availableSongs.isEmpty) {
        _audioPlayerDataSource.stop();
      } else {
        await _extendQueue(newCurrentIndex);
      }
    }

    await _audioPlayerDataSource.removeQueueIndices(indices);
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
  Future<void> setLoopMode(LoopMode loopMode) => _enqueueTransition(() async {
        _loopMode = loopMode;
        _emitState();
        await _audioPlayerDataSource.setLoopMode(loopMode);
      });

  @override
  Future<void> setShuffleMode(ShuffleMode shuffleMode, {bool updateQueue = true}) =>
      _enqueueTransition(() async {
        _shuffleMode = shuffleMode;

        final currentIndex = _currentIndex ?? 0;

        if (updateQueue) {
          final splitIndex = await _dynamicQueue.reshuffleQueue(shuffleMode, currentIndex);

          final queue = _dynamicQueue.queue;
          await _audioPlayerDataSource.replaceQueueAroundIndex(
            index: currentIndex,
            before: queue.sublist(0, splitIndex).map((e) => e as SongModel).toList(),
            after: queue.sublist(splitIndex + 1).map((e) => e as SongModel).toList(),
          );
          _currentIndex = splitIndex;
        }

        _emitState();
      });

  @override
  Future<void> stop() async {
    _audioPlayerDataSource.stop();
  }

  @override
  Future<void> updateSongs(Map<String, Song> songs) => _enqueueTransition(() async {
        // TODO: handle removing songs/current song here? could be easier to coordinate with playerdatasource
        final oldQueue = List<Song>.from(_dynamicQueue.queue);

        if (_dynamicQueue.onSongsUpdated(songs)) {
          final blockLevel = calcBlockLevel(_shuffleMode, _playable!);
          final queue = _dynamicQueue.queue;

          final indicesToRemove = <int>[];
          for (int i = 0; i < queue.length; i++) {
            final song = queue[i];
            if (song.blockLevel > blockLevel) {
              if (oldQueue.firstWhere((e) => e.path == song.path).blockLevel != song.blockLevel) {
                indicesToRemove.add(i);
              }
            }
          }
          if (indicesToRemove.isNotEmpty) await _removeQueueIndices(indicesToRemove, false);

          _emitState();
        }
      });

  @override
  Future<void> removeBlockedSongs(List<String> paths) => _enqueueTransition(() async {
        final pathSet = Set<String>.from(paths);
        final oldQueue = List<Song>.from(_dynamicQueue.queue);

        if (_dynamicQueue.removeSongs(pathSet)) {
          final indicesToRemove = <int>[];
          for (int i = 0; i < oldQueue.length; i++) {
            if (pathSet.contains(oldQueue[i].path)) indicesToRemove.add(i);
          }
          if (indicesToRemove.isNotEmpty) {
            _audioPlayerDataSource.removeQueueIndices(indicesToRemove);
          }
          _emitState();
        }
      });

  /// Composes the current structural fields into one immutable [AudioPlayerState]
  /// and releases it as a single atomic snapshot.
  ///
  /// This is the **only** place that pushes structural state to [stateStream].
  /// [AudioPlayerState.currentSong] is derived by the snapshot from `queue` and
  /// `currentIndex`, so queue, index and song can never disagree.
  void _emitState() {
    final queue = _dynamicQueue.queueItems;

    _stateSubject.add(
      AudioPlayerState(
        queue: List<QueueItem>.unmodifiable(queue),
        currentIndex: _currentIndex,
        shuffleMode: _shuffleMode,
        loopMode: _loopMode,
        playable: _playable,
        revision: ++_stateRevision,
      ),
    );
  }

  /// Calculate the new current index when removing the song at [removeIndex].
  int _calcNewCurrentIndexOnRemove(int currentIndex, List<int> removeIndeces) {
    int result = currentIndex;
    for (final i in removeIndeces) {
      if (i < currentIndex) {
        result--;
      } else {
        break;
      }
    }
    return result;
  }

  @override
  Future<void> seekToPosition(double position) async =>
      _audioPlayerDataSource.seekToPosition(position);
}
