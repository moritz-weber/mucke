import 'dart:async';

import 'package:audio_service/audio_service.dart';

import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/playback_state.dart' as entity;
import '../../domain/entities/shuffle_mode.dart';
import '../models/playback_state_model.dart';
import '../models/song_model.dart';
import 'audio_manager_contract.dart';
import 'stream_constants.dart';

typedef Conversion<S, T> = T Function(S);

class AudioManagerImpl implements AudioManager {
  AudioManagerImpl(this._audioHandler) {
    _audioHandler.customEventStream.listen((event) {
      final data = event as Map<String, dynamic>;
      if (data.containsKey(KEY_INDEX)) {
        _queueIndex = data[KEY_INDEX] as int;
      }
      if (data.containsKey(SHUFFLE_MODE)) {
        _shuffleMode = data[SHUFFLE_MODE] as ShuffleMode;
      }
    });
  }

  final AudioHandler _audioHandler;
  int _queueIndex;
  ShuffleMode _shuffleMode;

  @override
  Stream<SongModel> get currentSongStream =>
      _filterStream<MediaItem, SongModel>(
        _audioHandler.mediaItem.stream,
        (MediaItem mi) => SongModel.fromMediaItem(mi),
      );

  @override
  Stream<entity.PlaybackState> get playbackStateStream => _filterStream(
        _audioHandler.playbackState.stream,
        (PlaybackState ps) => PlaybackStateModel.fromASPlaybackState(ps),
      );

  // TODO: test
  @override
  Stream<List<SongModel>> get queueStream {
    return _audioHandler.queue.stream.map((mediaItems) =>
        mediaItems.map((m) => SongModel.fromMediaItem(m)).toList());
  }

  @override
  Stream<int> get queueIndexStream =>
      _queueIndexStream(_audioHandler.customEventStream.cast());

  Stream<int> _queueIndexStream(Stream<Map<String, dynamic>> source) async* {
    if (_queueIndex != null) {
      yield _queueIndex;
    }

    await for (final data in source) {
      if (data.containsKey(KEY_INDEX)) {
        yield data[KEY_INDEX] as int;
      }
    }
  }

  @override
  Stream<ShuffleMode> get shuffleModeStream =>
      _shuffleModeStream(_audioHandler.customEventStream.cast());

  Stream<ShuffleMode> _shuffleModeStream(
      Stream<Map<String, dynamic>> source) async* {
    if (_shuffleMode != null) {
      yield _shuffleMode;
    }

    await for (final data in source) {
      if (data.containsKey(SHUFFLE_MODE)) {
        yield data[SHUFFLE_MODE] as ShuffleMode;
      }
    }
  }

  @override
  Stream<int> get currentPositionStream => _position().distinct();

  @override
  Future<void> playSong(int index, List<SongModel> songList) async {
    final List<String> context = songList.map((s) => s.path).toList();
    await _audioHandler.customAction(PLAY_WITH_CONTEXT, {'CONTEXT': context, 'INDEX': index});
  }

  @override
  Future<void> play() async {
    _audioHandler.play();
  }

  @override
  Future<void> pause() async {
    await _audioHandler.pause();
  }

  @override
  Future<void> skipToNext() async {
    await _audioHandler.skipToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    await _audioHandler.skipToPrevious();
  }

  @override
  Future<void> setShuffleMode(ShuffleMode shuffleMode) async {
    await _audioHandler.customAction(SET_SHUFFLE_MODE, {'SHUFFLE_MODE': shuffleMode});
  }

  @override
  Future<void> setLoopMode(LoopMode loopMode) async {
    await _audioHandler.customAction(SET_LOOP_MODE, {'LOOP_MODE': loopMode});
  }

  Stream<T> _filterStream<S, T>(Stream<S> stream, Conversion<S, T> fn) async* {
    T lastItem;

    await for (final S item in stream) {
      final T newItem = fn(item);
      if (newItem != lastItem) {
        lastItem = newItem;
        yield newItem;
      }
    }
  }

  Stream<int> _position() async* {
    PlaybackState state;
    DateTime updateTime;
    Duration statePosition;

    // TODO: should this class get an init method for this?
    _audioHandler.playbackState.stream.listen((currentState) {
      state = currentState;
      updateTime = currentState?.updateTime;
      statePosition = currentState?.position;
    });

    while (true) {
      if (statePosition != null && updateTime != null && state != null) {
        if (state.playing) {
          yield statePosition.inMilliseconds +
              (DateTime.now().millisecondsSinceEpoch -
                  updateTime.millisecondsSinceEpoch);
        } else {
          yield statePosition.inMilliseconds;
        }
      } else {
        yield 0;
      }
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }

  @override
  Future<void> shuffleAll() async {
    await _audioHandler.customAction(SHUFFLE_ALL, null);
  }

  @override
  Future<void> addToQueue(SongModel songModel) async {
    await _audioHandler.addQueueItem(songModel.toMediaItem());
  }

  @override
  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    await _audioHandler.customAction(MOVE_QUEUE_ITEM, {'OLD_INDEX': oldIndex, 'NEW_INDEX': newIndex});
  }

  @override
  Future<void> removeQueueIndex(int index) async {
    await _audioHandler.customAction(REMOVE_QUEUE_ITEM, {'INDEX': index});
  }
}
