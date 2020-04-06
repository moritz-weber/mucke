import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../models/song_model.dart';
import 'audio_manager_contract.dart';

class AudioManagerImpl implements AudioManager {
  @override
  Future<void> playSong(int index, List<SongModel> songList) async {
    final List<MediaItem> queue = songList.map((s) => s.toMediaItem()).toList();

    // await AudioService.addQueueItem(queue[index]);
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
    // _audioPlayer.setFilePath(_mediaItems[mediaId].id);
    await _audioPlayer.setFilePath(mediaId);
    _audioPlayer.play();
  }
}
