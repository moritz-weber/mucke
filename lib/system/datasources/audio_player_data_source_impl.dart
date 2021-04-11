import 'dart:math';

import 'package:just_audio/just_audio.dart' as ja;
import 'package:logging/logging.dart';
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
      _log.info('currentIndexSteam.listen: $index');
      if (!_lockUpdate) {
        if (!await _updateLoadedQueue(index)) {
          _updateCurrentIndex(index);
        }
      }
    });

    _audioPlayer.playingStream.listen((event) => _playingSubject.add(event));

    _audioPlayer.positionStream.listen((event) => _positionSubject.add(event));

    _playbackEventModelStream = Rx.combineLatest2<ja.PlaybackEvent, bool, PlaybackEventModel>(
      _audioPlayer.playbackEventStream,
      _audioPlayer.playingStream,
      (a, b) => PlaybackEventModel.fromJAPlaybackEvent(a, b),
    ).distinct();
  }

  final ja.AudioPlayer _audioPlayer;
  ja.ConcatenatingAudioSource _audioSource;

  static final _log = Logger('AudioPlayer');
  bool _lockUpdate = false;

  final BehaviorSubject<int> _currentIndexSubject = BehaviorSubject();
  final BehaviorSubject<PlaybackEventModel> _playbackEventSubject = BehaviorSubject();
  final BehaviorSubject<bool> _playingSubject = BehaviorSubject();
  final BehaviorSubject<Duration> _positionSubject = BehaviorSubject();

  Stream<PlaybackEventModel> _playbackEventModelStream;
  List<SongModel> _queue;
  int _loadStartIndex;
  int _loadEndIndex;

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
  Future<void> loadQueue({List<SongModel> queue, int initialIndex = 0}) async {
    if (queue == null || initialIndex == null || initialIndex >= queue.length) {
      return;
    }
    _queue = queue;
    final queueToLoad = _getQueueToLoad(queue, initialIndex);

    _audioSource = _songModelsToAudioSource(queueToLoad);

    await _audioPlayer.setAudioSource(_audioSource, initialIndex: _calcSourceIndex(initialIndex));
    _currentIndexSubject.add(initialIndex);
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
    final oldCurrentIndex = currentIndexStream.value;
    int newCurrentIndex = oldCurrentIndex;
    if (oldIndex == oldCurrentIndex) {
      newCurrentIndex = newIndex;
    } else {
      if (oldIndex < oldCurrentIndex) {
        newCurrentIndex--;
      }
      if (newIndex < oldCurrentIndex) {
        newCurrentIndex++;
      }
    }

    final song = _queue[oldIndex];
    final newQueue = List<SongModel>.from(_queue);
    newQueue.removeAt(oldIndex);
    newQueue.insert(newIndex, song);

    final before = newQueue.sublist(0, newCurrentIndex);
    final after = newQueue.sublist(min(newCurrentIndex + 1, newQueue.length));

    replaceQueueAroundCurrentIndex(
      before: before,
      after: after,
    );
  }

  @override
  Future<void> playNext(SongModel song) async {
    final index = currentIndexStream.value + 1;
    _queue.insert(index, song);
    if (index < _loadEndIndex) {
      _loadEndIndex++;
    }
    await _audioSource.insert(
        _audioPlayer.currentIndex + 1, ja.AudioSource.uri(Uri.file(song.path)));
  }

  @override
  Future<void> removeQueueIndex(int index) async {
    _queue.removeAt(index);
    if (_isQueueIndexInLoadInterval(index)) {
      if (index < _loadStartIndex) _loadStartIndex--;
      if (index < _loadEndIndex) _loadEndIndex--;
      await _audioSource.removeAt(_calcSourceIndex(index));
    }
  }

  // TODO: maybe remove this
  @override
  Future<void> replaceQueueAroundIndex({
    List<SongModel> before,
    List<SongModel> after,
    int index,
  }) async {
    _log.info('REPLACE QUEUE AROUND INDEX: $index');
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

  Future<void> replaceQueueAroundCurrentIndex({
    List<SongModel> before,
    List<SongModel> after,
  }) async {
    _log.info('REPLACE QUEUE AROUND CURRENT INDEX');
    final currIndex = currentIndexStream.value;
    final newIndex = before.length;
    _queue = before + [_queue[currIndex]] + after;

    final oldSourceIndex = _calcSourceIndex(currIndex);
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
    if (loopMode == null) return;
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
  Future<bool> _updateLoadedQueue(int newIndex) async {
    _log.info('updateLoadedQueue: $newIndex');
    _log.info('[$_loadStartIndex, $_loadEndIndex]');

    if (_loadStartIndex == null || _loadEndIndex == null || newIndex == null) return false;

    if (_loadStartIndex == _loadEndIndex ||
        (_loadStartIndex == 0 && _loadEndIndex == _queue.length)) return false;

    if (_loadStartIndex < _loadEndIndex) {
      _log.info('base case');
      return await _updateLoadedQueueBaseCase(newIndex);
    } else {
      _log.info('inverted case');
      return await _updateLoadedQueueInverted(newIndex);
    }
  }

  Future<bool> _updateLoadedQueueBaseCase(int newIndex) async {
    if (newIndex < LOAD_INTERVAL) {
      // nearing the start of the loaded songs
      if (_loadStartIndex > 0) {
        // load the song previous to the already loaded songs
        _log.info('loadStartIndex--');
        _loadStartIndex--;
        await _audioSource.insert(0, ja.AudioSource.uri(Uri.file(_queue[_loadStartIndex].path)));
        return true;
      } else if (_loadEndIndex < _queue.length) {
        // load the last song, if it isn't already loaded
        _log.info('loadStartIndex = ${_queue.length - 1}');
        _loadStartIndex = _queue.length - 1;
        await _audioSource.add(ja.AudioSource.uri(Uri.file(_queue.last.path)));
        return false;
      }
    } else if (newIndex > _audioSource.length - LOAD_INTERVAL - 1) {
      // need to load next song
      if (_loadEndIndex < _queue.length) {
        // we ARE NOT at the end of the queue -> load next song
        _log.info('loadEndIndex++');
        _loadEndIndex++;
        await _audioSource.add(ja.AudioSource.uri(Uri.file(_queue[_loadEndIndex - 1].path)));
        return false;
      } else if (_loadStartIndex > 0) {
        // we ARE at the end of the queue AND the first song has not been loaded yet
        // -> load first song
        _log.info('loadEndIndex = 1');
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
      _log.info('inv: loadStartIndex--');
      _loadStartIndex--;
      await _audioSource.insert(
          _loadEndIndex, ja.AudioSource.uri(Uri.file(_queue[_loadStartIndex].path)));
      return rightOfLoadEnd;
    } else if (rightBorder >= _loadEndIndex) {
      // need to load next song
      // we ARE NOT at the end of the queue -> load next song
      _log.info('inv: loadEndIndex++');
      _loadEndIndex++;
      await _audioSource.insert(
          _loadEndIndex - 1, ja.AudioSource.uri(Uri.file(_queue[_loadEndIndex - 1].path)));
      return rightOfLoadEnd;
    }
    return false;
  }

  void _updateCurrentIndex(int apIndex) {
    if (_loadStartIndex == null || _loadEndIndex == null) {
      _currentIndexSubject.add(apIndex);
      return;
    }

    int result;
    if (_audioSource != null && _audioSource.length == _queue.length) {
      _log.info('EVERYTHING LOADED');
      result = apIndex;
    } else if (_loadStartIndex < _loadEndIndex) {
      // base case
      result = apIndex != null ? (apIndex + (_loadStartIndex ?? 0)) : null;
    } else {
      // inverted case
      if (apIndex < _loadEndIndex) {
        result = apIndex;
      } else {
        result = apIndex + (_loadStartIndex - _loadEndIndex);
      }
    }

    _currentIndexSubject.add(result);
    _log.info('updateCurrentIndex: $result');
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
    if (_audioSource.length == _queue.length) return index < _queue.length;

    final int leftBorder = (_loadStartIndex + LOAD_INTERVAL - 1) % _queue.length;
    final int rightBorder = (_loadEndIndex - LOAD_INTERVAL + 1) % _queue.length;

    if (leftBorder < rightBorder) {
      return leftBorder <= index && index < rightBorder;
    } else {
      return leftBorder <= index || index < rightBorder;
    }
  }
}
