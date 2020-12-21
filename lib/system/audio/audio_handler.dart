import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:logging/logging.dart';

import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/playback_event.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../datasources/music_data_source_contract.dart';
import '../datasources/player_state_data_source.dart';
import '../models/playback_event_model.dart';
import '../models/queue_item_model.dart';
import '../models/song_model.dart';
import 'audio_player_contract.dart';
import 'stream_constants.dart';

class MyAudioHandler extends BaseAudioHandler {
  MyAudioHandler(this._musicDataSource, this._audioPlayer, this._playerStateDataSource) {
    _audioPlayer.queueStream.listen((event) {
      _handleSetQueue(event);
    });

    _audioPlayer.currentSongStream.listen((songModel) {
      mediaItemSubject.add(songModel.toMediaItem());
    });

    _audioPlayer.playbackEventStream.listen((event) {
      _handlePlaybackEvent(event);
    });

    _audioPlayer.shuffleModeStream.listen((shuffleMode) {
      _playerStateDataSource.setShuffleMode(shuffleMode);
      customEventSubject.add({SHUFFLE_MODE: shuffleMode});
    });

    _audioPlayer.loopModeStream.listen((event) {
      _playerStateDataSource.setLoopMode(event);
    });

    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    if (_playerStateDataSource.loopModeStream != null) {
      _audioPlayer.setLoopMode(await _playerStateDataSource.loopModeStream.first);
    }

    if (_playerStateDataSource.shuffleModeStream != null) {
      _audioPlayer.setShuffleMode(await _playerStateDataSource.shuffleModeStream.first, false);
    }

    if (_playerStateDataSource.queueStream != null && _playerStateDataSource.currentIndexStream != null) {
      _audioPlayer.loadQueue(
        queue: await _playerStateDataSource.queueStream.first,
        startIndex: await _playerStateDataSource.currentIndexStream.first,
      );
    }
  }

  final AudioPlayer _audioPlayer;
  final MusicDataSource _musicDataSource;
  final PlayerStateDataSource _playerStateDataSource;

  static final _log = Logger('AudioHandler');

  @override
  Future<void> stop() async {
    await _audioPlayer.stop();
    await _audioPlayer.dispose();
    await super.stop();
  }

  @override
  Future<void> play() async {
    _audioPlayer.play();
  }

  @override
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> skipToNext() async {
    _audioPlayer.seekToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    _audioPlayer.seekToPrevious();
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    _audioPlayer.addToQueue(SongModel.fromMediaItem(mediaItem));
  }

  @override
  Future<void> customAction(String name, Map<String, dynamic> arguments) async {
    switch (name) {
      case PLAY_WITH_CONTEXT:
        final context = arguments['CONTEXT'] as List<String>;
        final index = arguments['INDEX'] as int;
        return playWithContext(context, index);
      case APP_LIFECYCLE_RESUMED:
        return onAppLifecycleResumed();
      case SET_SHUFFLE_MODE:
        return setCustomShuffleMode(arguments['SHUFFLE_MODE'] as ShuffleMode);
      case SET_LOOP_MODE:
        return setCustomLoopMode(arguments['LOOP_MODE'] as LoopMode);
      case SHUFFLE_ALL:
        return shuffleAll();
      case MOVE_QUEUE_ITEM:
        return moveQueueItem(arguments['OLD_INDEX'] as int, arguments['NEW_INDEX'] as int);
      case REMOVE_QUEUE_ITEM:
        return removeQueueIndex(arguments as int);
      default:
    }
  }

  Future<void> playWithContext(List<String> context, int index) async {
    final songs = <SongModel>[];
    for (final path in context) {
      final song = await _musicDataSource.getSongByPath(path);
      songs.add(song);
    }

    _audioPlayer.playSongList(songs, index);
  }

  Future<void> onAppLifecycleResumed() async {
    // customEventSubject.add({SHUFFLE_MODE: shuffleMode});
    // customEventSubject.add({KEY_INDEX: playbackIndex});
  }

  Future<void> setCustomShuffleMode(ShuffleMode mode) async {
    _audioPlayer.setShuffleMode(mode, true);
  }

  Future<void> setCustomLoopMode(LoopMode mode) async {
    _audioPlayer.setLoopMode(mode);
  }

  Future<void> shuffleAll() async {
    _audioPlayer.setShuffleMode(ShuffleMode.plus, false);

    final List<SongModel> songs = await _musicDataSource.getSongs();
    final rng = Random();
    final index = rng.nextInt(songs.length);

    _audioPlayer.playSongList(songs, index);
  }

  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    _audioPlayer.moveQueueItem(oldIndex, newIndex);
  }

  Future<void> removeQueueIndex(int index) async {
    _audioPlayer.removeQueueIndex(index);
  }

  void _handleSetQueue(List<QueueItemModel> queue) {
    _playerStateDataSource.setQueue(queue);

    final mediaItems = queue.map((e) => e.song.toMediaItem()).toList();
    queueSubject.add(mediaItems);
  }

  void _handlePlaybackEvent(PlaybackEventModel pe) {
    if (pe.index != null) {
      _playerStateDataSource.setCurrentIndex(pe.index);
      customEventSubject.add({KEY_INDEX: pe.index});
    }

    if (pe.processingState == ProcessingState.ready) {
      if (_audioPlayer.playingStream.value) {
        playbackStateSubject.add(playbackState.value.copyWith(
          controls: [MediaControl.skipToPrevious, MediaControl.pause, MediaControl.skipToNext],
          playing: true,
          processingState: AudioProcessingState.ready,
          updatePosition: pe.updatePosition,
        ));
      } else {
        playbackStateSubject.add(playbackState.value.copyWith(
          controls: [MediaControl.skipToPrevious, MediaControl.play, MediaControl.skipToNext],
          processingState: AudioProcessingState.ready,
          updatePosition: pe.updatePosition,
          playing: false,
        ));
      }
    }
  }
}
