import 'dart:async';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:moor/isolate.dart';
import 'package:moor/moor.dart';

import 'moor_music_data_source.dart';

const String SET_QUEUE = 'SET_QUEUE';

class AudioPlayerTask extends BackgroundAudioTask {
  final _audioPlayer = AudioPlayer();
  final _completer = Completer();
  MoorMusicDataSource _moorMusicDataSource;

  final _mediaItems = <String, MediaItem>{};
  final _queue = <MediaItem>[];

  Duration _position;

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    _audioPlayer.getPositionStream().listen((duration) => _position = duration);

    final connectPort = IsolateNameServer.lookupPortByName(MOOR_ISOLATE);
    final MoorIsolate moorIsolate = MoorIsolate.fromConnectPort(connectPort);
    final DatabaseConnection databaseConnection = await moorIsolate.connect();
    _moorMusicDataSource = MoorMusicDataSource.connect(databaseConnection);

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
      playing: true,
      processingState: AudioProcessingState.ready,
    );

    await AudioServiceBackground.setMediaItem(_mediaItems[mediaId]);
    await _audioPlayer.setFilePath(mediaId);

    _audioPlayer.play();
  }

  @override
  Future<void> onPlay() async {
    AudioServiceBackground.setState(
      controls: [pauseControl, stopControl],
      processingState: AudioProcessingState.ready,
      updateTime: Duration(milliseconds: DateTime.now().millisecondsSinceEpoch),
      position: _position,
      playing: true,
    );
    _audioPlayer.play();
  }

  @override
  Future<void> onPause() async {
    AudioServiceBackground.setState(
      controls: [playControl, stopControl],
      processingState: AudioProcessingState.ready,
      updateTime: Duration(milliseconds: DateTime.now().millisecondsSinceEpoch),
      position: _position,
      playing: false,
    );
    await _audioPlayer.pause();
  }

  @override
  Future<void> onCustomAction(String name, arguments) async {
    switch (name) {
      case SET_QUEUE:
        return _setQueue(List<String>.from(arguments as List<dynamic>));
      default:
    }
  }

  Future<void> _setQueue(List<String> queue) async {

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
