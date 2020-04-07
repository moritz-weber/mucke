import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../models/song_model.dart';
import 'audio_manager_contract.dart';

class AudioManagerImpl implements AudioManager {
  @override
  Future<void> playSong(int index, List<SongModel> songList) async {
    final List<MediaItem> queue = songList.map((s) => s.toMediaItem()).toList();

    await AudioService.addQueueItem(queue[index]);
    AudioService.playFromMediaId(queue[index].id);
  }
}

class AudioPlayerTask extends BackgroundAudioTask {
  final _audioPlayer = AudioPlayer();
  final _completer = Completer();

  final _mediaItems = <String, MediaItem>{};

  @override
  Future<void> onStart() async {
    print('onStart');

    AudioServiceBackground.setState(
      controls: [pauseControl, stopControl],
      basicState: BasicPlaybackState.playing,
    );

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

    // await _audioPlayer.setFilePath(_mediaItems[mediaId]);
    AudioServiceBackground.setMediaItem(_mediaItems[mediaId]);

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
