import 'dart:async';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:moor/isolate.dart';
import 'package:moor/moor.dart';

import 'moor_music_data_source.dart';

const String INIT = 'INIT';
const String PLAY_WITH_CONTEXT = 'PLAY_WITH_CONTEXT';
const String APP_LIFECYCLE_RESUMED = 'APP_LIFECYCLE_RESUMED';

const String KEY_INDEX = 'INDEX';

class AudioPlayerTask extends BackgroundAudioTask {
  final _audioPlayer = AudioPlayer();
  final _completer = Completer();
  MoorMusicDataSource _moorMusicDataSource;

  final _mediaItems = <String, MediaItem>{};
  List<MediaItem> _originalPlaybackContext = <MediaItem>[];
  List<MediaItem> _playbackContext = <MediaItem>[];
  int _index = -1;
  int get playbackIndex => _index;
  set playbackIndex(int i) {
    print('setting index');
    _index = i;
    AudioServiceBackground.sendCustomEvent({KEY_INDEX: _index});
  }

  Duration _position;

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
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
  Future<void> onSkipToNext() async {
    if (_incrementIndex()) {
      await _audioPlayer.stop();
      _startPlayback(_index);
    }
  }

  @override
  Future<void> onSkipToPrevious() async {
    if (_decrementIndex()) {
      await _audioPlayer.stop();
      _startPlayback(_index);
    }
  }

  @override
  Future<void> onCustomAction(String name, arguments) async {
    switch (name) {
      case INIT:
        return _init();
      case PLAY_WITH_CONTEXT:
        // arguments: [List<String>, int]
        final args = arguments as List<dynamic>;
        final _context = List<String>.from(args[0] as List<dynamic>);
        final index = args[1] as int;
        return _playWithContext(_context, index);
      case APP_LIFECYCLE_RESUMED:
        return _onAppLifecycleResumed();
      default:
    }
  }

  Future<void> _init() async {
    print('AudioPlayerTask._init');
    _audioPlayer.getPositionStream().listen((duration) => _position = duration);

    final connectPort = IsolateNameServer.lookupPortByName(MOOR_ISOLATE);
    final MoorIsolate moorIsolate = MoorIsolate.fromConnectPort(connectPort);
    final DatabaseConnection databaseConnection = await moorIsolate.connect();
    _moorMusicDataSource = MoorMusicDataSource.connect(databaseConnection);
  }

  Future<void> _playWithContext(List<String> context, int index) async {
    print('AudioPlayerTask._playWithContext');
    final _mediaItems = await _getMediaItemsFromPaths(context);
    final permutation = _generateSongPermutation(_mediaItems);
    _playbackContext = _getPermutatedSongs(_mediaItems, permutation);
    playbackIndex = index;
    AudioServiceBackground.setQueue(_playbackContext);
    _startPlayback(index);
  }

  Future<void> _onAppLifecycleResumed() async {
    playbackIndex = playbackIndex;
    // AudioServiceBackground.setQueue(_playbackContext);
  }

  // TODO: test
  // TODO: optimize -> too slow for whole library
  Future<List<MediaItem>> _getMediaItemsFromPaths(List<String> paths) async {
    final mediaItems = <MediaItem>[];
    for (final path in paths) {
      final song = await _moorMusicDataSource.getSongByPath(path);
      mediaItems.add(song.toMediaItem());
    }
    _originalPlaybackContext = mediaItems;

    return mediaItems;
  }

  // TODO: test
  // TODO: needs implementation for shuffle mode
  List<int> _generateSongPermutation(List<MediaItem> songs) {
    // permutation[i] = j; => song j is on the i-th position in the permutated list
    final permutation = <int>[];

    for (var i = 0; i < songs.length; i++) {
      permutation.add(i);
    }

    return permutation;
  }

  List<MediaItem> _getPermutatedSongs(
      List<MediaItem> songs, List<int> permutation) {
    return List.generate(
        permutation.length, (index) => songs[permutation[index]]);
  }

  // TODO: cleanup and test
  Future<void> _startPlayback(int index) async {
    // TODO: DRY
    AudioServiceBackground.setState(
      controls: [pauseControl, stopControl],
      playing: true,
      processingState: AudioProcessingState.ready,
    );

    // TODO: needs implementation for shuffle mode (play first song)
    final _mediaItem = _playbackContext[index];
    await AudioServiceBackground.setMediaItem(_mediaItem);
    await _audioPlayer.setFilePath(_mediaItem.id);

    // exploration: this works, but has to be used every time play() is called; maybe stateStream is the better option
    _audioPlayer.play().then((_) {
      print(_audioPlayer.playbackState);
      if (_audioPlayer.playbackState == AudioPlaybackState.completed)
        onSkipToNext();
    });
  }

  bool _incrementIndex() {
    if (playbackIndex < _playbackContext.length - 1) {
      playbackIndex++;
      return true;
    }
    return false;
  }

  bool _decrementIndex() {
    if (playbackIndex > 0) {
      playbackIndex--;
      return true;
    }
    return false;
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
