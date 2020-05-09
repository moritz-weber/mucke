import 'dart:async';

import 'package:audio_service/audio_service.dart';

import '../../domain/entities/playback_state.dart' as entity;
import '../models/playback_state_model.dart';
import '../models/song_model.dart';
import 'audio_manager_contract.dart';
import 'audio_player_task.dart';

typedef Conversion<S, T> = T Function(S);

class AudioManagerImpl implements AudioManager {
  final Stream<MediaItem> _currentMediaItemStream =
      AudioService.currentMediaItemStream;
  final Stream<PlaybackState> _sourcePlaybackStateStream =
      AudioService.playbackStateStream;

  @override
  Stream<SongModel> get currentSongStream =>
      _filterStream<MediaItem, SongModel>(
        _currentMediaItemStream,
        (MediaItem mi) => SongModel.fromMediaItem(mi),
      );

  @override
  Stream<entity.PlaybackState> get playbackStateStream => _filterStream(
        _sourcePlaybackStateStream,
        (PlaybackState ps) => PlaybackStateModel.fromASPlaybackState(ps),
      );

  @override
  Stream<int> get currentPositionStream => _position().distinct();

  @override
  Future<void> playSong(int index, List<SongModel> songList) async {
    await _startAudioService();
    final List<MediaItem> queue = songList.map((s) => s.toMediaItem()).toList();

    // await AudioService.customAction(SET_QUEUE, listofids);

    await AudioService.addQueueItem(queue[index]);
    AudioService.playFromMediaId(queue[index].id);
  }

  @override
  Future<void> play() async {
    await AudioService.play();
  }

  @override
  Future<void> pause() async {
    await AudioService.pause();
  }

  Future<void> _startAudioService() async {
    if (!await AudioService.running) {
      await AudioService.start(
        backgroundTaskEntrypoint: _backgroundTaskEntrypoint,
        enableQueue: true,
      );
    }
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
    BasicPlaybackState state;
    int updateTime;
    int statePosition;

    // should this class get an init method for this?
    _sourcePlaybackStateStream.listen((currentState) {
      state = currentState?.basicState;
      updateTime = currentState?.updateTime;
      statePosition = currentState?.position;
    });

    while (true) {
      if (statePosition != null && updateTime != null && state != null) {
        if (state == BasicPlaybackState.playing) {
          yield statePosition +
              (DateTime.now().millisecondsSinceEpoch - updateTime);
        } else {
          yield statePosition;
        }
      } else {
        yield 0;
      }
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }
}

void _backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}
