import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';

import '../../domain/entities/shuffle_mode.dart';
import '../datasources/music_data_source_contract.dart';
import '../models/queue_item.dart';
import '../models/song_model.dart';
import 'queue_generator.dart';

const String KEY_INDEX = 'INDEX';
const String SHUFFLE_MODE = 'SHUFFLE_MODE';

const String PLAY_WITH_CONTEXT = 'PLAY_WITH_CONTEXT';
const String INIT = 'INIT';
const String APP_LIFECYCLE_RESUMED = 'APP_LIFECYCLE_RESUMED';
const String SHUFFLE_ALL = 'SHUFFLE_ALL';
const String SET_SHUFFLE_MODE = 'SET_SHUFFLE_MODE';
const String MOVE_QUEUE_ITEM = 'MOVE_QUEUE_ITEM';
const String REMOVE_QUEUE_ITEM = 'REMOVE_QUEUE_ITEM';

class MyAudioHandler extends BaseAudioHandler {
  MyAudioHandler(this._musicDataSource);


  final _audioPlayer = AudioPlayer();
  final MusicDataSource _musicDataSource;
  QueueGenerator queueGenerator;

  // TODO: confusing naming
  List<MediaItem> originalPlaybackContext = <MediaItem>[];
  List<QueueItem> playbackContext = <QueueItem>[];

  // TODO: this is not trivial: queue is loaded by audioplayer
  // this reference enables direct manipulation of the loaded queue
  ConcatenatingAudioSource _queue;
  List<MediaItem> mediaItemQueue;

  ShuffleMode _shuffleMode = ShuffleMode.none;

  ShuffleMode get shuffleMode => _shuffleMode;
  set shuffleMode(ShuffleMode s) {
    _shuffleMode = s;
    customEventSubject.add({SHUFFLE_MODE: s});
  }

  int _playbackIndex = -1;
  int get playbackIndex => _playbackIndex;
  set playbackIndex(int i) {
    _log.info('index: $i');
    if (i != null) {
      _playbackIndex = i;
      mediaItemSubject.add(mediaItemQueue[i]);
      customEventSubject.add({KEY_INDEX: i});

      playbackStateSubject.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          MediaControl.pause,
          MediaControl.skipToNext
        ],
        playing: _audioPlayer.playing,
        processingState: AudioProcessingState.ready,
        updatePosition: _audioPlayer.position,
      ));
    }
  }

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
    await _queue.add(AudioSource.uri(Uri.file(mediaItem.id)));
    mediaItemQueue.add(mediaItem);
    handleSetQueue(mediaItemQueue);
  }

  @override
  Future<void> customAction(String name, Map<String, dynamic> arguments) async {
    switch (name) {
      case INIT:
        return init();
      case PLAY_WITH_CONTEXT:
        final context = arguments['CONTEXT'] as List<String>;
        final index = arguments['INDEX'] as int;
        return playWithContext(context, index);
      case APP_LIFECYCLE_RESUMED:
        return onAppLifecycleResumed();
      case SET_SHUFFLE_MODE:
        return setCustomShuffleMode(arguments['SHUFFLE_MODE'] as ShuffleMode);
      case SHUFFLE_ALL:
        return shuffleAll();
      case MOVE_QUEUE_ITEM:
        return moveQueueItem(arguments['OLD_INDEX'] as int, arguments['NEW_INDEX'] as int);
      case REMOVE_QUEUE_ITEM:
        return removeQueueIndex(arguments as int);
      default:
    }
  }

  Future<void> handleSetQueue(List<MediaItem> mediaItemQueue) async {
    queueSubject.add(mediaItemQueue);
    final songModels =
        mediaItemQueue.map((e) => SongModel.fromMediaItem(e)).toList();
    _musicDataSource.setQueue(songModels);
  }

  Future<void> init() async {
    print('AudioPlayerTask.init');
    _audioPlayer.playerStateStream.listen((event) => handlePlayerState(event));
    _audioPlayer.currentIndexStream.listen((event) => playbackIndex = event);
    _audioPlayer.sequenceStateStream
        .listen((event) => handleSequenceState(event));

    queueGenerator = QueueGenerator(_musicDataSource);
  }

  Future<void> playWithContext(List<String> context, int index) async {
    final mediaItems = await queueGenerator.getMediaItemsFromPaths(context);
    playPlaylist(mediaItems, index);
  }

  Future<void> onAppLifecycleResumed() async {
    customEventSubject.add({SHUFFLE_MODE: shuffleMode});
    customEventSubject.add({KEY_INDEX: playbackIndex});
  }

  Future<void> setCustomShuffleMode(ShuffleMode mode) async {
    shuffleMode = mode;

    final QueueItem currentQueueItem = playbackContext[playbackIndex];
    final int index = currentQueueItem.originalIndex;
    playbackContext = await queueGenerator.generateQueue(
        shuffleMode, originalPlaybackContext, index);
    mediaItemQueue = playbackContext.map((e) => e.mediaItem).toList();

    // FIXME: this does not react correctly when inserted track is currently played
    handleSetQueue(mediaItemQueue);

    final newQueue = queueGenerator.mediaItemsToAudioSource(mediaItemQueue);
    _updateQueue(newQueue, currentQueueItem);
  }

  void _updateQueue(
      ConcatenatingAudioSource newQueue, QueueItem currentQueueItem) {
    final int index = currentQueueItem.originalIndex;

    _queue.removeRange(0, playbackIndex);
    _queue.removeRange(1, _queue.length);

    if (shuffleMode == ShuffleMode.none) {
      switch (currentQueueItem.type) {
        case QueueItemType.standard:
          _queue.insertAll(0, newQueue.children.sublist(0, index));
          _queue.addAll(newQueue.children.sublist(index + 1));
          playbackIndex = index;
          break;
        case QueueItemType.predecessor:
          _queue.insertAll(0, newQueue.children.sublist(0, index));
          _queue.addAll(newQueue.children.sublist(index));
          playbackIndex = index;
          break;
        case QueueItemType.successor:
          _queue.insertAll(0, newQueue.children.sublist(0, index + 1));
          _queue.addAll(newQueue.children.sublist(index + 1));
          playbackIndex = index;
          break;
      }
    } else {
      _queue.addAll(newQueue.children.sublist(1));
    }
  }

  Future<void> shuffleAll() async {
    shuffleMode = ShuffleMode.standard;
    final List<SongModel> songs = await _musicDataSource.getSongs();
    final List<MediaItem> mediaItems =
        songs.map((song) => song.toMediaItem()).toList();

    final rng = Random();
    final index = rng.nextInt(mediaItems.length);

    playPlaylist(mediaItems, index);
  }

  Future<void> playPlaylist(List<MediaItem> mediaItems, int index) async {
    final firstMediaItem = mediaItems.sublist(index, index + 1);
    mediaItemQueue = firstMediaItem;
    handleSetQueue(firstMediaItem);
    _queue = queueGenerator.mediaItemsToAudioSource(firstMediaItem);
    _audioPlayer.play();
    await _audioPlayer.load(_queue, initialIndex: 0);


    originalPlaybackContext = mediaItems;

    playbackContext =
        await queueGenerator.generateQueue(shuffleMode, mediaItems, index);
    mediaItemQueue = playbackContext.map((e) => e.mediaItem).toList();

    handleSetQueue(mediaItemQueue);
    final int splitIndex = shuffleMode == ShuffleMode.none ? index : 0;
    final newQueue = queueGenerator.mediaItemsToAudioSource(mediaItemQueue);
    _queue.insertAll(0, newQueue.children.sublist(0, splitIndex));
    _queue.addAll(newQueue.children.sublist(splitIndex + 1, newQueue.length));
  }

  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    _log.info('move: $oldIndex -> $newIndex');
    final MediaItem mediaItem = mediaItemQueue.removeAt(oldIndex);
    final index = newIndex < oldIndex ? newIndex : newIndex - 1;
    mediaItemQueue.insert(index, mediaItem);
    handleSetQueue(mediaItemQueue);
    _queue.move(oldIndex, index);
  }

  Future<void> removeQueueIndex(int index) async {
    mediaItemQueue.removeAt(index);
    handleSetQueue(mediaItemQueue);
    _queue.removeAt(index);
  }

  void handlePlayerState(PlayerState ps) {
    _log.info('handlePlayerState called');
    if (ps.processingState == ProcessingState.ready && ps.playing) {
      playbackStateSubject.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          MediaControl.pause,
          MediaControl.skipToNext
        ],
        playing: true,
        processingState: AudioProcessingState.ready,
        updatePosition: _audioPlayer.position,
      ));
    } else if (ps.processingState == ProcessingState.ready && !ps.playing) {
      playbackStateSubject.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          MediaControl.play,
          MediaControl.skipToNext
        ],
        processingState: AudioProcessingState.ready,
        updatePosition: _audioPlayer.position,
        playing: false,
      ));
    }
  }

  // TODO: this can only be a temporary solution! gets called too often.
  void handleSequenceState(SequenceState st) {
    _log.info('handleSequenceState called');
    if (0 <= playbackIndex && playbackIndex < playbackContext.length) {
      _log.info('handleSequenceState: setting MediaItem');
      mediaItemSubject.add(mediaItemQueue[playbackIndex]);
    }
  }
}
