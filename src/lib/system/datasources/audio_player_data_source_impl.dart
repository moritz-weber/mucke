import 'dart:math';

import 'package:fimber/fimber.dart';
import 'package:just_audio/just_audio.dart' as ja;
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/loop_mode.dart';
import '../models/loop_mode_model.dart';
import '../models/playback_event_model.dart';
import '../models/song_model.dart';
import 'audio_player_data_source.dart';

const int LOAD_INTERVAL = 2;
const int LOAD_MAX = 6;

class AudioPlayerDataSourceImpl implements AudioPlayerDataSource {
  AudioPlayerDataSourceImpl(this._audioPlayer) {
    _audioPlayer.currentIndexStream.listen((index) async {
      _log.d('currentIndexStream.listen: $index');
      if (!_lockUpdate) {
        if (!await _updateLoadedQueue(index)) {
          _updateCurrentIndex(index);
        }
      }
    });

    _audioPlayer.playingStream.listen((event) => _playingSubject.add(event));

    _audioPlayer.positionStream.listen((event) => _positionSubject.add(event));

    _audioPlayer.playbackEventStream.listen((event) {
      if (event.processingState == ja.ProcessingState.completed && _audioPlayer.playing) {
        // AudioPlayer crashes if paused directly on completed
        Future.delayed(const Duration(milliseconds: 100)).then((_) => pause());
      }
    });

    _playbackEventModelStream = Rx.combineLatest2<ja.PlaybackEvent, bool, PlaybackEventModel>(
      _audioPlayer.playbackEventStream,
      _audioPlayer.playingStream,
      (a, b) => PlaybackEventModel.fromJAPlaybackEvent(a, b),
    ).distinct();
  }

  static final _log = FimberLog('AudioPlayerDataSourceImpl');

  final ja.AudioPlayer _audioPlayer;

  late ja.ConcatenatingAudioSource _audioSource;
  late List<SongModel> _queue;
  // inclusive
  late int _loadStartIndex;
  // exclusive
  late int _loadEndIndex;
  bool isQueueLoaded = false;

  bool _lockUpdate = false;

  final BehaviorSubject<int> _currentIndexSubject = BehaviorSubject();
  final BehaviorSubject<PlaybackEventModel> _playbackEventSubject = BehaviorSubject();
  final BehaviorSubject<bool> _playingSubject = BehaviorSubject();
  final BehaviorSubject<Duration> _positionSubject = BehaviorSubject();

  late Stream<PlaybackEventModel> _playbackEventModelStream;

  @override
  ValueStream<int> get currentIndexStream => _currentIndexSubject.stream;

  @override
  Stream<PlaybackEventModel> get playbackEventStream => _playbackEventModelStream;

  @override
  ValueStream<Duration> get positionStream => _positionSubject.stream;

  @override
  ValueStream<bool> get playingStream => _playingSubject.stream;

  @override
  Future<void> dispose() async {
    await _currentIndexSubject.close();
    await _playbackEventSubject.close();
    await _positionSubject.close();
    await _audioPlayer.dispose();
  }

  @override
  Future<void> loadQueue({
    required List<SongModel> queue,
    int initialIndex = 0,
  }) async {
    if (initialIndex >= queue.length) {
      // there is no queue or something is wrong -> initialize with sane defaults
      _queue = [];
      _audioSource = ja.ConcatenatingAudioSource(children: []);
      _audioPlayer.setAudioSource(_audioSource);
      _currentIndexSubject.add(0);
      _loadStartIndex = 0;
      _loadEndIndex = 0;
    } else {
      _queue = queue;
      final queueToLoad = _getQueueToLoad(queue, initialIndex);
      // if this was not set to false, _updateLoadedQueue would try to manipulate the _audioSource
      // in some cases and _audioPlayer doesn't like that
      isQueueLoaded = false;
      _audioSource = _songModelsToAudioSource(queueToLoad);
      await _audioPlayer.setAudioSource(_audioSource, initialIndex: _calcSourceIndex(initialIndex));
      isQueueLoaded = true;
      _currentIndexSubject.add(initialIndex);
    }
  }

  @override
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> play() async {
    if (_audioPlayer.playerState.processingState == ja.ProcessingState.completed) {
      await seekToPosition(0.0);
    }
    _audioPlayer.play();
  }

  @override
  Future<bool> seekToNext() async {
    final result = _audioPlayer.hasNext;
    await _audioPlayer.seekToNext();
    return result;
  }

  @override
  Future<void> seekToPrevious() async {
    if (_audioPlayer.position > const Duration(seconds: 3) || !_audioPlayer.hasPrevious) {
      await _audioPlayer.seek(const Duration(seconds: 0));
    } else {
      await _audioPlayer.seekToPrevious();
    }
  }

  @override
  Future<void> seekToIndex(int index) async {
    if (_isQueueIndexInSaveInterval(index)) {
      await _audioPlayer.seek(const Duration(seconds: 0), index: _calcSourceIndex(index));
    } else {
      await loadQueue(queue: _queue, initialIndex: index);
    }
  }

  @override
  Future<void> stop() async {
    _audioPlayer.stop();
  }

  @override
  Future<void> addToQueue(List<SongModel> songs) async {
    _queue.addAll(songs);

    if (_loadStartIndex < _loadEndIndex) {
      if (_loadEndIndex == _queue.length - 1) {
        // queue is loaded until the end -> load this song too and adapt the index
        _loadEndIndex++;
        await _audioSource.addAll(songs.map((e) => ja.AudioSource.uri(Uri.file(e.path))).toList());
      }
    } else {
      // note: when removing the whole queue and queueing new songs, this case will always be true
      // thus, from this point on, everything will be loaded immediately
      await _audioSource.addAll(songs.map((e) => ja.AudioSource.uri(Uri.file(e.path))).toList());
    }
  }

  @override
  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    _log.d('moveQueueItem: $oldIndex -> $newIndex');
    final newCurrentIndex = calcNewCurrentIndexOnMove(currentIndexStream.value, oldIndex, newIndex);

    final song = _queue[oldIndex];
    final newQueue = List<SongModel>.from(_queue);
    newQueue.removeAt(oldIndex);
    newQueue.insert(newIndex, song);

    final before = newQueue.sublist(0, newCurrentIndex);
    final after = newQueue.sublist(min(newCurrentIndex + 1, newQueue.length));

    await replaceQueueAroundIndex(
      index: currentIndexStream.value,
      before: before,
      after: after,
    );
  }

  @override
  Future<void> playNext(List<SongModel> songs) async {
    final index = currentIndexStream.value + 1;
    _queue.insertAll(min(index, _queue.length), songs);

    if (index < _loadStartIndex) {
      _loadStartIndex = _loadStartIndex + songs.length;
    }
    if (index < _loadEndIndex) {
      _loadEndIndex = _loadEndIndex + songs.length;
    }
    await _audioSource.insertAll(min(_audioSource.length, (_audioPlayer.currentIndex ?? 0) + 1),
        songs.map((e) => ja.AudioSource.uri(Uri.file(e.path))).toList());
  }

  @override
  Future<void> insertIntoQueue(List<SongModel> songs, int index) async {
    _queue.insertAll(min(index, _queue.length), songs);

    final sourceIndex = _calcSourceIndex(index);
    final isIndexLoaded = _isQueueIndexInLoadInterval(index);
    if (index < _loadStartIndex) {
      _loadStartIndex = _loadStartIndex + songs.length;
    }
    if (index < _loadEndIndex) {
      _loadEndIndex = _loadEndIndex + songs.length;
    }

    if (isIndexLoaded) {
      await _audioSource.insertAll(min(_audioSource.length, sourceIndex),
          songs.map((e) => ja.AudioSource.uri(Uri.file(e.path))).toList());
    } else {
      _updateCurrentIndex(_audioPlayer.currentIndex);
    }
  }

  @override
  Future<void> removeQueueIndices(List<int> indices) async {
    _log.d('removeQueueIndices');
    final sortedIndeces = Set<int>.from(indices).toList();
    sortedIndeces.sort((a, b) => -a.compareTo(b));

    bool isSomeIndexLoaded = false;
    bool needToLoadMore = false;

    final currentSourceIndex = _audioPlayer.currentIndex ?? 0;
    for (final index in sortedIndeces) {
      _queue.removeAt(index);
      final sourceIndex = _calcSourceIndex(index);
      final isIndexLoaded = _isQueueIndexInLoadInterval(index);

      if (index < _loadStartIndex) {
        _log.d('$index < $_loadStartIndex --> DECREMENT LOAD START INDEX');
        _loadStartIndex--;
      }
      if (index < _loadEndIndex) {
        _log.d('$index < $_loadEndIndex --> DECREMENT LOAD END INDEX');
        _loadEndIndex--;
      }

      if (isIndexLoaded) {
        _log.d('index is loaded');
        isSomeIndexLoaded = true;
        await _audioSource.removeAt(sourceIndex);
        if (sourceIndex >= currentSourceIndex) {
          needToLoadMore = true;
        }
      }
    }

    if (isSomeIndexLoaded) {
      if (needToLoadMore) {
        _updateLoadedQueue(currentSourceIndex);
      }
    }
    _updateCurrentIndex(_audioPlayer.currentIndex);
  }

  @override
  Future<void> replaceQueueAroundIndex({
    required List<SongModel> before,
    required List<SongModel> after,
    required int index,
  }) async {
    _log.d('REPLACE QUEUE AROUND INDEX: $index');
    _queue = before + [_queue[index]] + after;
    final newIndex = before.length;

    final oldSourceIndex = _calcSourceIndex(index);
    final queueToLoad = _getQueueToLoad(_queue, newIndex);
    final newSourceIndex = _calcSourceIndex(newIndex);

    final _before = _songModelsToAudioSource(queueToLoad.sublist(0, newSourceIndex));
    final _after = _songModelsToAudioSource(
      queueToLoad.sublist(min(newSourceIndex + 1, queueToLoad.length)),
    );

    _lockUpdate = true;
    await _audioSource.removeRange(0, oldSourceIndex);
    await _audioSource.removeRange(1, _audioSource.length);

    await _audioSource.insertAll(0, _before.children);
    await _audioSource.addAll(_after.children);
    _lockUpdate = false;
    _updateCurrentIndex(newSourceIndex);
  }

  @override
  Future<void> setLoopMode(LoopMode loopMode) async {
    await _audioPlayer.setLoopMode(loopMode.toJA());
  }

  ja.ConcatenatingAudioSource _songModelsToAudioSource(List<SongModel> songModels) {
    return ja.ConcatenatingAudioSource(
      children: songModels.map((SongModel m) => ja.AudioSource.uri(Uri.file(m.path))).toList(),
    );
  }

  /// Determine the songs to load and set loadStartIndex/loadEndIndex accordingly.
  List<SongModel> _getQueueToLoad(List<SongModel> queue, int initialIndex) {
    if (queue.length > LOAD_MAX) {
      _loadStartIndex = (initialIndex - LOAD_INTERVAL) % queue.length;
      _loadEndIndex = initialIndex + LOAD_INTERVAL + 1;
      if (_loadEndIndex > queue.length) _loadEndIndex %= queue.length;

      List<SongModel> smallQueue;
      if (_loadStartIndex < _loadEndIndex) {
        smallQueue = queue.sublist(_loadStartIndex, _loadEndIndex);
      } else {
        smallQueue = queue.sublist(0, _loadEndIndex) + queue.sublist(_loadStartIndex);
      }
      return smallQueue;
    } else {
      _loadStartIndex = 0;
      _loadEndIndex = queue.length;
      return queue;
    }
  }

  /// extend the loaded audiosource, when seeking to previous/next
  Future<bool> _updateLoadedQueue(int? newIndex) async {
    _log.d('updateLoadedQueue: $newIndex');
    if (!isQueueLoaded || newIndex == null) {
      return false;
    }

    _log.d('[$_loadStartIndex, $_loadEndIndex]');

    if (_loadStartIndex == _loadEndIndex ||
        (_loadStartIndex == 0 && _loadEndIndex == _queue.length)) {
      return false;
    }

    if (_loadStartIndex < _loadEndIndex) {
      _log.d('base case');
      return await _updateLoadedQueueBaseCase(newIndex);
    } else {
      _log.d('inverted case');
      return await _updateLoadedQueueInverted(newIndex);
    }
  }

  /// update loaded queue in case the loaded queue is one continous part of the queue
  /// return true if queue was changed
  Future<bool> _updateLoadedQueueBaseCase(int newIndex) async {
    if (newIndex < LOAD_INTERVAL) {
      // nearing the start of the loaded songs
      if (_loadStartIndex > 0) {
        // load the song previous to the already loaded songs
        _log.d('loadStartIndex--');
        _loadStartIndex--;
        await _audioSource.insert(0, ja.AudioSource.uri(Uri.file(_queue[_loadStartIndex].path)));
        return true;
      } else if (_loadEndIndex < _queue.length) {
        // load the last song, if it isn't already loaded
        _log.d('loadStartIndex = ${_queue.length - 1}');
        _loadStartIndex = _queue.length - 1;
        await _audioSource.add(ja.AudioSource.uri(Uri.file(_queue.last.path)));
        return false;
      }
    } else if (newIndex > _audioSource.length - LOAD_INTERVAL - 1) {
      // need to load next song
      if (_loadEndIndex < _queue.length) {
        // we ARE NOT at the end of the queue -> load next song
        _log.d('loadEndIndex++');
        _loadEndIndex++;
        await _audioSource.add(ja.AudioSource.uri(Uri.file(_queue[_loadEndIndex - 1].path)));
        return false;
      } else if (_loadStartIndex > 0) {
        // we ARE at the end of the queue AND the first song has not been loaded yet
        // -> load first song
        _log.d('loadEndIndex = 1');
        _loadEndIndex = 1;
        await _audioSource.insert(0, ja.AudioSource.uri(Uri.file(_queue[0].path)));
        return true;
      }
    }
    return false;
  }

  /// update loaded queue in case the loaded queue is split in two parts
  /// return true if queue was changed
  Future<bool> _updateLoadedQueueInverted(int newIndex) async {
    final rightOfLoadEnd = newIndex >= _loadEndIndex;

    int leftBorder = newIndex - LOAD_INTERVAL;
    if (newIndex < _loadEndIndex) {
      leftBorder += _audioSource.length;
    }

    int rightBorder = newIndex + LOAD_INTERVAL;
    if (newIndex > _loadEndIndex) {
      rightBorder -= _audioSource.length;
    }

    if (leftBorder < _loadEndIndex) {
      // nearing the start of the loaded songs
      // load the song previous to the already loaded songs
      _log.d('inv: loadStartIndex--');
      _loadStartIndex--;
      await _audioSource.insert(
          _loadEndIndex, ja.AudioSource.uri(Uri.file(_queue[_loadStartIndex].path)));
      return rightOfLoadEnd;
    } else if (rightBorder >= _loadEndIndex) {
      // need to load next song
      // we ARE NOT at the end of the queue -> load next song
      _log.d('inv: loadEndIndex++');
      _loadEndIndex++;
      await _audioSource.insert(
          _loadEndIndex - 1, ja.AudioSource.uri(Uri.file(_queue[_loadEndIndex - 1].path)));
      return rightOfLoadEnd;
    }
    return false;
  }

  void _updateCurrentIndex(int? apIndex) {
    if (apIndex == null || !isQueueLoaded) {
      return;
    }

    int result;
    if (_audioSource.length == _queue.length) {
      _log.d('EVERYTHING LOADED');
      result = apIndex;
    } else if (_loadStartIndex < _loadEndIndex) {
      // base case
      result = apIndex + _loadStartIndex;
    } else {
      // inverted case
      if (apIndex < _loadEndIndex) {
        result = apIndex;
      } else {
        result = apIndex + (_loadStartIndex - _loadEndIndex);
      }
    }

    _currentIndexSubject.add(result);
    _log.d('updateCurrentIndex: $result');
  }

  int _calcSourceIndex(int queueIndex) {
    if (_loadStartIndex < _loadEndIndex) {
      return queueIndex - _loadStartIndex;
    } else {
      if (queueIndex < _loadEndIndex) {
        return queueIndex;
      } else {
        return queueIndex - _loadStartIndex + _loadEndIndex;
      }
    }
  }

  bool _isQueueIndexInLoadInterval(int index) {
    if (_loadStartIndex < _loadEndIndex) {
      return _loadStartIndex <= index && index < _loadEndIndex;
    } else {
      return _loadStartIndex <= index || index < _loadEndIndex;
    }
  }

  bool _isQueueIndexInSaveInterval(int index) {
    if (_audioSource.length == _queue.length) {
      return index < _queue.length;
    }

    final int leftBorder = (_loadStartIndex + LOAD_INTERVAL - 1) % _queue.length;
    final int rightBorder = (_loadEndIndex - LOAD_INTERVAL + 1) % _queue.length;

    if (leftBorder < rightBorder) {
      return leftBorder <= index && index < rightBorder;
    } else {
      return leftBorder <= index || index < rightBorder;
    }
  }

  @override
  Future<void> seekToPosition(double position) async {
    final duration = _audioPlayer.duration;
    if (duration != null) {
      await _audioPlayer.seek(duration * position);
    }
  }
  
  @override
  int calcNewCurrentIndexOnMove(int currentIndex, int oldIndex, int newIndex) {
    int newCurrentIndex = currentIndex;
    if (oldIndex == currentIndex) {
      // moving the currently playing song
      newCurrentIndex = newIndex;
    } else {
      if (oldIndex < currentIndex) {
        // equality is caught by the first if
        newCurrentIndex--;
      }
      if (oldIndex > currentIndex && newIndex <= currentIndex) {
        newCurrentIndex++;
      } else if (newIndex < currentIndex) {
        newCurrentIndex++;
      }
    }
    return newCurrentIndex;
  }
}
