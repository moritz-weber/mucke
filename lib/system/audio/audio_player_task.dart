import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';
import 'package:mobx/mobx.dart';
import 'package:moor/isolate.dart';
import 'package:moor/moor.dart';

import '../../domain/entities/shuffle_mode.dart';
import '../datasources/moor_music_data_source.dart';
import '../models/queue_item.dart';
import '../models/song_model.dart';
import 'queue_generator.dart';

part 'audio_player_task.g.dart';

const String INIT = 'INIT';
const String PLAY_WITH_CONTEXT = 'PLAY_WITH_CONTEXT';
const String APP_LIFECYCLE_RESUMED = 'APP_LIFECYCLE_RESUMED';
const String SET_SHUFFLE_MODE = 'SET_SHUFFLE_MODE';
const String SHUFFLE_ALL = 'SHUFFLE_ALL';
const String KEY_INDEX = 'INDEX';
const String MOVE_QUEUE_ITEM = 'MOVE_QUEUE_ITEM';
const String REMOVE_QUEUE_ITEM = 'REMOVE_QUEUE_ITEM';

class AudioPlayerTask = AudioPlayerTaskBase with _$AudioPlayerTask;

abstract class AudioPlayerTaskBase extends BackgroundAudioTask with Store {
  final audioPlayer = AudioPlayer();
  MoorMusicDataSource moorMusicDataSource;
  QueueGenerator queueGenerator;

  // TODO: confusing naming
  List<MediaItem> originalPlaybackContext = <MediaItem>[];
  List<QueueItem> playbackContext = <QueueItem>[];

  // TODO: this is not trivial: queue is loaded by audioplayer
  // this reference enables direct manipulation of the loaded queue
  ConcatenatingAudioSource queue;
  List<MediaItem> mediaItemQueue;

  ShuffleMode _shuffleMode = ShuffleMode.none;
  ShuffleMode get shuffleMode => _shuffleMode;
  set shuffleMode(ShuffleMode s) {
    _shuffleMode = s;
    AudioServiceBackground.sendCustomEvent({SET_SHUFFLE_MODE: s.toString()});
  }

  int _playbackIndex = -1;
  int get playbackIndex => _playbackIndex;
  set playbackIndex(int i) {
    if (i != null) {
      _playbackIndex = i;
      AudioServiceBackground.setMediaItem(mediaItemQueue[i]);
      AudioServiceBackground.sendCustomEvent({KEY_INDEX: i});

      AudioServiceBackground.setState(
        controls: [
          MediaControl.skipToPrevious,
          MediaControl.pause,
          MediaControl.skipToNext
        ],
        playing: audioPlayer.playing,
        processingState: AudioProcessingState.ready,
        updateTime:
            Duration(milliseconds: DateTime.now().millisecondsSinceEpoch),
        position: audioPlayer.position,
      );
    }
  }

  static final _log = Logger('AudioPlayerTask')
    ..onRecord.listen((record) {
      print(
          '${record.time} [${record.level.name}] ${record.loggerName}: ${record.message}');
    });

  @override
  Future<void> onStop() async {
    await audioPlayer.stop();
    await audioPlayer.dispose();
    await super.onStop();
  }

  @override
  Future<void> onPlay() async {
    audioPlayer.play();
  }

  @override
  Future<void> onPause() async {
    await audioPlayer.pause();
  }

  @override
  Future<void> onSkipToNext() async {
    audioPlayer.seekToNext();
  }

  @override
  Future<void> onSkipToPrevious() async {
    audioPlayer.seekToPrevious();
  }

  @override
  Future<void> onAddQueueItem(MediaItem mediaItem) async {
    await queue.add(AudioSource.uri(Uri.file(mediaItem.id)));
    mediaItemQueue.add(mediaItem);
    AudioServiceBackground.setQueue(mediaItemQueue);
  }

  @override
  Future<void> onCustomAction(String name, arguments) async {
    switch (name) {
      case INIT:
        return init();
      case PLAY_WITH_CONTEXT:
        // arguments: [List<String>, int]
        final args = arguments as List<dynamic>;
        final context = List<String>.from(args[0] as List<dynamic>);
        final index = args[1] as int;
        return playWithContext(context, index);
      case APP_LIFECYCLE_RESUMED:
        return onAppLifecycleResumed();
      case SET_SHUFFLE_MODE:
        return setShuffleMode((arguments as String).toShuffleMode());
      case SHUFFLE_ALL:
        return shuffleAll();
      case MOVE_QUEUE_ITEM:
        final args = arguments as List<dynamic>;
        return moveQueueItem(args[0] as int, args[1] as int);
      case REMOVE_QUEUE_ITEM:
        return removeQueueItem(arguments as int);
      default:
    }
  }

  Future<void> init() async {
    print('AudioPlayerTask.init');
    audioPlayer.playerStateStream.listen((event) => handlePlayerState(event));
    audioPlayer.currentIndexStream.listen((event) => playbackIndex = event);
    audioPlayer.sequenceStateStream
        .listen((event) => handleSequenceState(event));

    final connectPort = IsolateNameServer.lookupPortByName(MOOR_ISOLATE);
    final MoorIsolate moorIsolate = MoorIsolate.fromConnectPort(connectPort);
    final DatabaseConnection databaseConnection = await moorIsolate.connect();
    moorMusicDataSource = MoorMusicDataSource.connect(databaseConnection);

    queueGenerator = QueueGenerator(moorMusicDataSource);
  }

  Future<void> playWithContext(List<String> context, int index) async {
    final mediaItems = await queueGenerator.getMediaItemsFromPaths(context);
    playPlaylist(mediaItems, index);
  }

  Future<void> onAppLifecycleResumed() async {
    AudioServiceBackground.sendCustomEvent({KEY_INDEX: playbackIndex});
    AudioServiceBackground.sendCustomEvent(
        {SET_SHUFFLE_MODE: shuffleMode.toString()});
  }

  Future<void> setShuffleMode(ShuffleMode mode) async {
    shuffleMode = mode;

    final QueueItem currentQueueItem = playbackContext[playbackIndex];
    final int index = currentQueueItem.originalIndex;
    playbackContext =
        await queueGenerator.generateQueue(shuffleMode, originalPlaybackContext, index);
    mediaItemQueue = playbackContext.map((e) => e.mediaItem).toList();

    // FIXME: this does not react correctly when inserted track is currently played
    AudioServiceBackground.setQueue(mediaItemQueue);

    final newQueue = queueGenerator.mediaItemsToAudioSource(mediaItemQueue);
    _updateQueue(newQueue, currentQueueItem);
  }

  void _updateQueue(ConcatenatingAudioSource newQueue, QueueItem currentQueueItem) {
    final int index = currentQueueItem.originalIndex;

    queue.removeRange(0, playbackIndex);
    queue.removeRange(1, queue.length);

    if (shuffleMode == ShuffleMode.none) {
      switch (currentQueueItem.type) {
        case QueueItemType.standard:
          queue.insertAll(0, newQueue.children.sublist(0, index));
          queue.addAll(newQueue.children.sublist(index + 1));
          playbackIndex = index;
          break;
        case QueueItemType.predecessor:
          queue.insertAll(0, newQueue.children.sublist(0, index));
          queue.addAll(newQueue.children.sublist(index));
          playbackIndex = index;
          break;
        case QueueItemType.successor:
          queue.insertAll(0, newQueue.children.sublist(0, index + 1));
          queue.addAll(newQueue.children.sublist(index + 1));
          playbackIndex = index;
          break;
      }
      
    } else {
      queue.addAll(newQueue.children.sublist(1));
    }
  }

  Future<void> shuffleAll() async {
    shuffleMode = ShuffleMode.standard;
    final List<SongModel> songs = await moorMusicDataSource.getSongs();
    final List<MediaItem> mediaItems =
        songs.map((song) => song.toMediaItem()).toList();

    final rng = Random();
    final index = rng.nextInt(mediaItems.length);

    playPlaylist(mediaItems, index);
  }

  Future<void> playPlaylist(List<MediaItem> mediaItems, int index) async {
    originalPlaybackContext = mediaItems;

    playbackContext = await queueGenerator.generateQueue(shuffleMode, mediaItems, index);
    mediaItemQueue = playbackContext.map((e) => e.mediaItem).toList();

    AudioServiceBackground.setQueue(mediaItemQueue);
    queue = queueGenerator.mediaItemsToAudioSource(mediaItemQueue);
    audioPlayer.play();
    final int startIndex = shuffleMode == ShuffleMode.none ? index : 0;
    await audioPlayer.load(queue, initialIndex: startIndex);
  }

  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    _log.info('move: $oldIndex -> $newIndex');
    final MediaItem mediaItem = mediaItemQueue.removeAt(oldIndex);
    final index = newIndex < oldIndex ? newIndex : newIndex - 1;
    mediaItemQueue.insert(index, mediaItem);
    AudioServiceBackground.setQueue(mediaItemQueue);
    queue.move(oldIndex, index);
  }

  Future<void> removeQueueItem(int index) async {
    mediaItemQueue.removeAt(index);
    AudioServiceBackground.setQueue(mediaItemQueue);
    queue.removeAt(index);
  }

  void handlePlayerState(PlayerState ps) {
    _log.info('handlePlayerState called');
    if (ps.processingState == ProcessingState.ready && ps.playing) {
      AudioServiceBackground.setState(
        controls: [
          MediaControl.skipToPrevious,
          MediaControl.pause,
          MediaControl.skipToNext
        ],
        playing: true,
        processingState: AudioProcessingState.ready,
        updateTime:
            Duration(milliseconds: DateTime.now().millisecondsSinceEpoch),
        position: audioPlayer.position,
      );
    } else if (ps.processingState == ProcessingState.ready && !ps.playing) {
      AudioServiceBackground.setState(
        controls: [
          MediaControl.skipToPrevious,
          MediaControl.play,
          MediaControl.skipToNext
        ],
        processingState: AudioProcessingState.ready,
        updateTime:
            Duration(milliseconds: DateTime.now().millisecondsSinceEpoch),
        position: audioPlayer.position,
        playing: false,
      );
    }
  }

  // TODO: this can only be a temporary solution! gets called too often.
  void handleSequenceState(SequenceState st) {
    _log.info('handleSequenceState called');
    if (0 <= playbackIndex && playbackIndex < playbackContext.length) {
      _log.info('handleSequenceState: setting MediaItem');
      AudioServiceBackground.setMediaItem(
          mediaItemQueue[playbackIndex]);
    }
  }
}
