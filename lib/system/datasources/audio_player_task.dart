import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:moor/isolate.dart';
import 'package:moor/moor.dart';

import '../../domain/entities/shuffle_mode.dart';
import '../models/song_model.dart';
import 'moor_music_data_source.dart';

const String INIT = 'INIT';
const String PLAY_WITH_CONTEXT = 'PLAY_WITH_CONTEXT';
const String APP_LIFECYCLE_RESUMED = 'APP_LIFECYCLE_RESUMED';
const String SET_SHUFFLE_MODE = 'SET_SHUFFLE_MODE';
const String SHUFFLE_ALL = 'SHUFFLE_ALL';

const String KEY_INDEX = 'INDEX';

class AudioPlayerTask extends BackgroundAudioTask {
  final _audioPlayer = AudioPlayer();
  MoorMusicDataSource _moorMusicDataSource;

  final _mediaItems = <String, MediaItem>{};
  List<MediaItem> _originalPlaybackContext = <MediaItem>[];
  List<MediaItem> _playbackContext = <MediaItem>[];

  ShuffleMode _shuffleMode = ShuffleMode.none;
  ShuffleMode get shuffleMode => _shuffleMode;
  set shuffleMode(ShuffleMode s) {
    _shuffleMode = s;
    AudioServiceBackground.sendCustomEvent({SET_SHUFFLE_MODE: s.toString()});
  }

  int _playbackIndex = -1;
  int get playbackIndex => _playbackIndex;
  set playbackIndex(int i) {
    print('setting index');
    _playbackIndex = i;
    AudioServiceBackground.sendCustomEvent({KEY_INDEX: _playbackIndex});
  }

  Duration _position;

  @override
  Future<void> onStop() async {
    await _audioPlayer.stop();
    await super.onStop();
  }

  @override
  Future<void> onAddQueueItem(MediaItem mediaItem) async {
    _mediaItems[mediaItem.id] = mediaItem;
  }

  @override
  Future<void> onPlayFromMediaId(String mediaId) async {
    AudioServiceBackground.setState(
      controls: [MediaControl.pause, MediaControl.skipToNext],
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
      controls: [MediaControl.pause, MediaControl.skipToNext],
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
      controls: [MediaControl.play, MediaControl.skipToNext],
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
      _startPlayback(playbackIndex);
    }
  }

  @override
  Future<void> onSkipToPrevious() async {
    if (_decrementIndex()) {
      await _audioPlayer.stop();
      _startPlayback(playbackIndex);
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
      case SET_SHUFFLE_MODE:
        return _setShuffleMode((arguments as String).toShuffleMode());
      case SHUFFLE_ALL:
        return shuffleAll();
      default:
    }
  }

  Future<void> _init() async {
    print('AudioPlayerTask._init');
    _audioPlayer.positionStream.listen((duration) => _position = duration);

    final connectPort = IsolateNameServer.lookupPortByName(MOOR_ISOLATE);
    final MoorIsolate moorIsolate = MoorIsolate.fromConnectPort(connectPort);
    final DatabaseConnection databaseConnection = await moorIsolate.connect();
    _moorMusicDataSource = MoorMusicDataSource.connect(databaseConnection);
  }

  Future<void> _playWithContext(List<String> context, int index) async {
    print('AudioPlayerTask._playWithContext');
    final _mediaItems = await _getMediaItemsFromPaths(context);
    final permutation = _generateSongPermutation(_mediaItems.length, index);
    _playbackContext = _getPermutatedSongs(_mediaItems, permutation);
    if (shuffleMode == ShuffleMode.none)
      playbackIndex = index;
    else
      playbackIndex = 0;
    AudioServiceBackground.setQueue(_playbackContext);
    _startPlayback(playbackIndex);
  }

  Future<void> _onAppLifecycleResumed() async {
    playbackIndex = playbackIndex;
    // AudioServiceBackground.setQueue(_playbackContext);
  }

  Future<void> _setShuffleMode(ShuffleMode mode) async {
    shuffleMode = mode;
    // TODO: adapt queue
  }

  // TODO: pasted code -> reformat!
  Future<void> shuffleAll() async {
    final start = DateTime.now();
    shuffleMode = ShuffleMode.standard;
    final List<SongModel> songs = await _moorMusicDataSource.getSongs();
    final mediaItems = <MediaItem>[];
    for (final song in songs) {
      mediaItems.add(song.toMediaItem());
    }
    final rng = Random();
    final index = rng.nextInt(mediaItems.length);

    final permutation = _generateSongPermutation(mediaItems.length, index);
    _playbackContext = _getPermutatedSongs(mediaItems, permutation);
    playbackIndex = 0;
    AudioServiceBackground.setQueue(_playbackContext);
    final end = DateTime.now();
    print(end.difference(start).inMilliseconds);
    _startPlayback(playbackIndex);
  }

  // TODO: test
  // TODO: optimize -> too slow for whole library
  // fetching all songs together and preparing playback takes ~500ms compared to ~10.000ms individually
  Future<List<MediaItem>> _getMediaItemsFromPaths(List<String> paths) async {
    final mediaItems = <MediaItem>[];
    for (final path in paths) {
      final song = await _moorMusicDataSource.getSongByPath(path);
      mediaItems.add(song.toMediaItem());
    }

    return mediaItems;
  }

  // TODO: test
  List<int> _generateSongPermutation(int length, int startIndex) {
    // permutation[i] = j; => song j is on the i-th position in the permutated list
    List<int> permutation;

    switch (shuffleMode) {
      case ShuffleMode.none:
        permutation = List<int>.generate(length, (i) => i);
        break;
      case ShuffleMode.standard:
        final tmp = List<int>.generate(length, (i) => i)
          ..removeAt(startIndex)
          ..shuffle();
        permutation = [startIndex] + tmp;
        break;
      case ShuffleMode.plus:
        break;
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
      controls: [MediaControl.pause, MediaControl.skipToNext],
      playing: true,
      processingState: AudioProcessingState.ready,
    );

    final _mediaItem = _playbackContext[index];
    await AudioServiceBackground.setMediaItem(_mediaItem);
    await _audioPlayer.setFilePath(_mediaItem.id);

    // exploration: this works, but has to be used every time play() is called; maybe stateStream is the better option
    _audioPlayer.play().then((_) {
      if (_audioPlayer.processingState == ProcessingState.completed)
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
