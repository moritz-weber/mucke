import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../../domain/entities/playback_state.dart' as entity;
import '../models/playback_state_model.dart';
import '../models/song_model.dart';
import 'audio_manager_contract.dart';

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
  Future<void> playSong(int index, List<SongModel> songList) async {
    await _startAudioService();
    final List<MediaItem> queue = songList.map((s) => s.toMediaItem()).toList();

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
}

void _backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  final _audioPlayer = AudioPlayer();
  final _completer = Completer();

  final _mediaItems = <String, MediaItem>{};

  @override
  Future<void> onStart() async {
    // AudioServiceBackground.setState(
    //   controls: [],
    //   basicState: BasicPlaybackState.none,
    // );
    await _completer.future;
  }

  @override
  void onStop() {
    _audioPlayer.stop();
    _completer.complete();
  }

  @override
  void onAddQueueItem(MediaItem mediaItem) {
    _mediaItems[mediaItem.id] = mediaItem;
  }

  @override
  Future<void> onPlayFromMediaId(String mediaId) async {
    AudioServiceBackground.setState(
      controls: [pauseControl, stopControl],
      basicState: BasicPlaybackState.playing,
    );

    await AudioServiceBackground.setMediaItem(_mediaItems[mediaId]);
    await _audioPlayer.setFilePath(mediaId);

    _audioPlayer.play();
  }

  @override
  Future<void> onPlay() async {
    AudioServiceBackground.setState(
        controls: [pauseControl, stopControl],
        basicState: BasicPlaybackState.playing);
    _audioPlayer.play();
  }

  @override
  Future<void> onPause() async {
    AudioServiceBackground.setState(
        controls: [playControl, stopControl],
        basicState: BasicPlaybackState.paused);
    await _audioPlayer.pause();
  }
}

MediaControl playControl = const MediaControl(
  androidIcon: 'drawable/ic_action_play_arrow',
  label: 'Play',
  action: MediaAction.play,
);
MediaControl pauseControl = const MediaControl(
  androidIcon: 'drawable/ic_action_pause',
  label: 'Pause',
  action: MediaAction.pause,
);
MediaControl stopControl = const MediaControl(
  androidIcon: 'drawable/ic_action_stop',
  label: 'Stop',
  action: MediaAction.stop,
);
