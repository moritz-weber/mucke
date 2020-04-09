import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../models/song_model.dart';
import 'audio_manager_contract.dart';

class AudioManagerImpl implements AudioManager {
  @override
  Stream<SongModel> watchCurrentSong = AudioService.currentMediaItemStream.map(
    (currentMediaItem) {
      return SongModel.fromMediaItem(currentMediaItem);
    },
  );

  @override
  Future<void> playSong(int index, List<SongModel> songList) async {
    await _startAudioService();
    final List<MediaItem> queue = songList.map((s) => s.toMediaItem()).toList();

    await AudioService.addQueueItem(queue[index]);
    AudioService.playFromMediaId(queue[index].id);
  }

  Future<void> _startAudioService() async {
    if (!await AudioService.running) {
      await AudioService.start(
        backgroundTaskEntrypoint: _backgroundTaskEntrypoint,
        enableQueue: true,
      );
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

    Future.wait([
      AudioServiceBackground.setMediaItem(_mediaItems[mediaId]),
      _audioPlayer.setFilePath(mediaId),
    ]);

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
