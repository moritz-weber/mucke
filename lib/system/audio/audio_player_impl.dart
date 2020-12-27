import 'package:just_audio/just_audio.dart' as ja;
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/queue_item.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../models/loop_mode_model.dart';
import '../models/playback_event_model.dart';
import '../models/queue_item_model.dart';
import '../models/song_model.dart';
import 'audio_player_contract.dart';
import 'queue_generator.dart';

class AudioPlayerImpl implements AudioPlayer {
  AudioPlayerImpl(this._audioPlayer, this._queueGenerator) {
    _audioPlayer.currentIndexStream.listen((event) {
      _log.info('currentIndex: $event');
      _currentIndexSubject.add(event);
      if (_queueSubject.value != null) {
        _currentSongSubject.add(_queueSubject.value[event].song);
      }
    });

    _audioPlayer.playingStream.listen((event) {
      _log.info('playing: $event');
      _playingSubject.add(event);
    });

    _audioPlayer.positionStream.listen((event) {
      _positionSubject.add(event);
    });

    _audioPlayer.loopModeStream.listen((event) {
      _log.info('loopMode: $event');
      _loopModeSubject.add(event.toEntity());
    });

    _queueSubject.listen((event) {
      if (_currentIndexSubject.value != null) {
        _currentSongSubject.add(event[_currentIndexSubject.value].song);
      }
    });

    _playbackEventModelStream = Rx.combineLatest2<ja.PlaybackEvent, bool, PlaybackEventModel>(
      _audioPlayer.playbackEventStream,
      _audioPlayer.playingStream,
      (a, b) => PlaybackEventModel.fromJAPlaybackEvent(a, b),
    ).distinct();
  }

  final ja.AudioPlayer _audioPlayer;
  ja.ConcatenatingAudioSource _audioSource;
  final QueueGenerator _queueGenerator;

  List<SongModel> _inputQueue;
  List<QueueItemModel> _queue;

  static final _log = Logger('AudioPlayer');

  final BehaviorSubject<int> _currentIndexSubject = BehaviorSubject();
  final BehaviorSubject<SongModel> _currentSongSubject = BehaviorSubject();
  final BehaviorSubject<PlaybackEventModel> _playbackEventSubject = BehaviorSubject();
  final BehaviorSubject<bool> _playingSubject = BehaviorSubject();
  final BehaviorSubject<Duration> _positionSubject = BehaviorSubject();
  final BehaviorSubject<List<QueueItemModel>> _queueSubject = BehaviorSubject();
  final BehaviorSubject<ShuffleMode> _shuffleModeSubject = BehaviorSubject.seeded(ShuffleMode.none);
  final BehaviorSubject<LoopMode> _loopModeSubject = BehaviorSubject();

  Stream<PlaybackEventModel> _playbackEventModelStream;

  @override
  ValueStream<int> get currentIndexStream => _currentIndexSubject.stream;

  @override
  ValueStream<SongModel> get currentSongStream => _currentSongSubject.stream;

  @override
  Stream<PlaybackEventModel> get playbackEventStream => _playbackEventModelStream;

  @override
  ValueStream<Duration> get positionStream => _positionSubject.stream;

  @override
  ValueStream<bool> get playingStream => _playingSubject.stream;

  @override
  ValueStream<List<QueueItemModel>> get queueStream => _queueSubject.stream;

  @override
  ValueStream<ShuffleMode> get shuffleModeStream => _shuffleModeSubject.stream;

  @override
  ValueStream<LoopMode> get loopModeStream => _loopModeSubject.stream;

  @override
  Future<void> dispose() async {
    await _currentIndexSubject.close();
    await _currentSongSubject.close();
    await _playbackEventSubject.close();
    await _positionSubject.close();
    await _queueSubject.close();
    await _shuffleModeSubject.close();
    await _loopModeSubject.close();
    await _audioPlayer.dispose();
  }

  @override
  Future<void> loadQueue({List<QueueItemModel> queue, int initialIndex = 0}) async {
    if (queue == null || initialIndex == null || initialIndex >= queue.length) {
      return;
    }
    _queue = queue;
    _queueSubject.add(queue);

    // final smallQueue = queue.sublist(max(initialIndex - 10, 0), min(initialIndex + 140, queue.length));

    final songModelQueue = queue.map((e) => e.song).toList();
    _audioSource = _queueGenerator.songModelsToAudioSource(songModelQueue);
    _audioPlayer.setAudioSource(_audioSource, initialIndex: initialIndex);
  }

  @override
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> play() async {
    _audioPlayer.play();
  }

  @override
  Future<void> playSongList(List<SongModel> songs, int startIndex) async {
    _inputQueue = songs;

    final firstSong = songs[startIndex];
    _queueSubject.add([QueueItemModel(firstSong, originalIndex: startIndex)]);
    _audioSource = _queueGenerator.songModelsToAudioSource([firstSong]);
    await _audioPlayer.setAudioSource(_audioSource);
    _audioPlayer.play();

    _queue = await _queueGenerator.generateQueue(_shuffleModeSubject.value, songs, startIndex);
    final songModelQueue = _queue.map((e) => e.song).toList();
    _queueSubject.add(_queue);

    final int splitIndex = _shuffleModeSubject.value == ShuffleMode.none ? startIndex : 0;
    final newQueue = _queueGenerator.songModelsToAudioSource(songModelQueue);
    await _audioSource.insertAll(0, newQueue.children.sublist(0, splitIndex));
    _audioSource.addAll(newQueue.children.sublist(splitIndex + 1, newQueue.length));
  }

  @override
  Future<void> seekToNext() async {
    await _audioPlayer.seekToNext();
  }

  @override
  Future<void> seekToPrevious() async {
    await _audioPlayer.seekToPrevious();
  }

  @override
  Future<void> setIndex(int index) async {
    await _audioPlayer.seek(const Duration(seconds: 0), index: index);
  }

  @override
  Future<void> stop() async {
    _audioPlayer.stop();
  }

  @override
  Future<void> addToQueue(SongModel song) async {
    await _audioSource.add(ja.AudioSource.uri(Uri.file(song.path)));
    _queue.add(QueueItemModel(song, originalIndex: -1, type: QueueItemType.added));
    _queueSubject.add(_queue);
  }

  @override
  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    final QueueItemModel queueItem = _queue.removeAt(oldIndex);
    final index = newIndex < oldIndex ? newIndex : newIndex - 1;
    _queue.insert(index, queueItem);
    _queueSubject.add(_queue);
    await _audioSource.move(oldIndex, index);
  }

  @override
  Future<void> removeQueueIndex(int index) async {
    _queue.removeAt(index);
    _queueSubject.add(_queue);
    await _audioSource.removeAt(index);
  }

  @override
  Future<void> setShuffleMode(ShuffleMode shuffleMode, bool updateQueue) async {
    if (shuffleMode == null) return;
    _shuffleModeSubject.add(shuffleMode);

    if (updateQueue) {
      final QueueItem currentQueueItem = _queue[_currentIndexSubject.value];
      final int index = currentQueueItem.originalIndex;
      _queue = await _queueGenerator.generateQueue(shuffleMode, _inputQueue, index);
      // TODO: maybe refactor _queue to a subject and listen for changes
      final songModelQueue = _queue.map((e) => e.song).toList();
      _queueSubject.add(_queue);

      final newQueue = _queueGenerator.songModelsToAudioSource(songModelQueue);
      _updateQueue(newQueue, currentQueueItem);
    }
  }

  @override
  Future<void> setLoopMode(LoopMode loopMode) async {
    if (loopMode == null) return;
    await _audioPlayer.setLoopMode(loopMode.toJA());
  }

  Future<void> _updateQueue(
      ja.ConcatenatingAudioSource newQueue, QueueItem currentQueueItem) async {
    final int index = currentQueueItem.originalIndex;

    _audioSource.removeRange(0, _currentIndexSubject.value);
    _audioSource.removeRange(1, _audioSource.length);

    if (_shuffleModeSubject.value == ShuffleMode.none) {
      switch (currentQueueItem.type) {
        case QueueItemType.added:
        case QueueItemType.standard:
          await _audioSource.insertAll(0, newQueue.children.sublist(0, index));
          _audioSource.addAll(newQueue.children.sublist(index + 1));
          break;
        case QueueItemType.predecessor:
          await _audioSource.insertAll(0, newQueue.children.sublist(0, index));
          _audioSource.addAll(newQueue.children.sublist(index));
          break;
        case QueueItemType.successor:
          await _audioSource.insertAll(0, newQueue.children.sublist(0, index + 1));
          _audioSource.addAll(newQueue.children.sublist(index + 1));
          break;
      }
      _currentIndexSubject.add(index);
    } else {
      _audioSource.addAll(newQueue.children.sublist(1));
    }
  }
}
