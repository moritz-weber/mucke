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
  late int _loadStartIndex;
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
      return;
    }
    _queue = queue;
    final queueToLoad = _getQueueToLoad(queue, initialIndex);
    _audioSource = _songModelsToAudioSource(queueToLoad);
    isQueueLoaded = true;

    await _audioPlayer.setAudioSource(_audioSource, initialIndex: _calcSourceIndex(initialIndex));
    _currentIndexSubject.add(initialIndex);
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
  Future<void> addToQueue(SongModel song) async {
    _queue.add(song);

    if (_loadStartIndex < _loadEndIndex) {
      if (_loadEndIndex == _queue.length) {
        _loadEndIndex++;
        await _audioSource.add(ja.AudioSource.uri(Uri.file(song.path)));
      }
    } else {
      await _audioSource.add(ja.AudioSource.uri(Uri.file(song.path)));
    }
  }

  @override
  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    _log.d('moveQueueItem: $oldIndex -> $newIndex');
    final int oldCurrentIndex = currentIndexStream.value;
    int newCurrentIndex = oldCurrentIndex;
    if (oldIndex == oldCurrentIndex) {
      newCurrentIndex = newIndex;
    } else {
      if (oldIndex < oldCurrentIndex) {
        newCurrentIndex--;
      }
      if (newIndex <= oldCurrentIndex) {
        newCurrentIndex++;
      }
    }

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
    _queue.insertAll(index, songs);
    if (index < _loadEndIndex) {
      _loadEndIndex = _loadEndIndex + songs.length;
    }
    await _audioSource.insertAll(_audioPlayer.currentIndex! + 1,
        songs.map((e) => ja.AudioSource.uri(Uri.file(e.path))).toList());
  }

  @override
  Future<void> removeQueueIndex(int index) async {
    _log.d('removeQueueIndex: $index');
    _queue.removeAt(index);
    final sourceIndex = _calcSourceIndex(index);
    final currentSourceIndex = _audioPlayer.currentIndex!;
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
      await _audioSource.removeAt(sourceIndex);
      if (sourceIndex >= currentSourceIndex) {
        _updateLoadedQueue(currentSourceIndex);
      }
    } else {
      _updateCurrentIndex(_audioPlayer.currentIndex!);
    }
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
      _loadEndIndex = (initialIndex + LOAD_INTERVAL + 1) % queue.length;

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
}
