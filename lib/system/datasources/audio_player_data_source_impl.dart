import 'dart:math';

import 'package:just_audio/just_audio.dart' as ja;
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/loop_mode.dart';
import '../models/loop_mode_model.dart';
import '../models/playback_event_model.dart';
import '../models/song_model.dart';
import 'audio_player_data_source.dart';

/// beide fälle (start > ende und ende <= start) beim initialen laden schon behandeln
/// offset berechnung passt -> damit sollte die index ausgabe auch stimmen
/// vielleicht lässt sich allgemeiner fall mit modulo rechnung finden: loadIndex = (li+-1) % length
/// die beiden richtungen (skip next/prev) verhalten sich in den beiden fällen genau gegensätzlich

const int LOAD_INTERVAL = 2;

class AudioPlayerDataSourceImpl implements AudioPlayerDataSource {
  AudioPlayerDataSourceImpl(this._audioPlayer) {
    _audioPlayer.currentIndexStream.listen((index) async {
      _log.info('currentIndexSteam.listen: $index');
      if (!await _updateLoadedQueue(index)) {
        _updateCurrentIndex(index);
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

  final BehaviorSubject<int> _currentIndexSubject = BehaviorSubject();
  final BehaviorSubject<PlaybackEventModel> _playbackEventSubject = BehaviorSubject();
  final BehaviorSubject<bool> _playingSubject = BehaviorSubject();
  final BehaviorSubject<Duration> _positionSubject = BehaviorSubject();

  Stream<PlaybackEventModel> _playbackEventModelStream;
  List<SongModel> _queue;
  int _loadStartIndex;
  int _loadEndIndex;

  set loadStartIndex(int i) {
    _loadStartIndex = i;
    _log.info('loadStartIndex <- $i');
    // _updateCurrentIndex(_audioPlayer.currentIndex);
  }

  int get loadStartIndex => _loadStartIndex;

  set loadEndIndex(int i) {
    _loadEndIndex = i;
    _log.info('loadEndIndex <- $i');
    // _updateCurrentIndex(_audioPlayer.currentIndex);
  }

  int get loadEndIndex => _loadEndIndex;

  int get loadOffset {
    if (loadStartIndex != null && loadEndIndex != null) {
      final offset = loadStartIndex < loadEndIndex ? loadStartIndex : loadStartIndex - loadEndIndex;
      print('offset: $offset');
      return offset;
    }
    return null;
  }

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

    loadStartIndex = max(initialIndex - LOAD_INTERVAL, 0);
    loadEndIndex = min(initialIndex + LOAD_INTERVAL + 1, queue.length);

    final smallQueue = queue.sublist(loadStartIndex, loadEndIndex);

    _audioSource = _songModelsToAudioSource(smallQueue);

    // _loadStartIndex.add(loadStartIndex);
    // _loadEndIndex.add(loadEndIndex);
    _audioPlayer.setAudioSource(_audioSource, initialIndex: initialIndex - loadStartIndex);
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
    await _audioPlayer.seek(const Duration(seconds: 0), index: index);
  }

  @override
  Future<void> stop() async {
    _audioPlayer.stop();
  }

  @override
  Future<void> addToQueue(SongModel song) async {
    await _audioSource.add(ja.AudioSource.uri(Uri.file(song.path)));
    _queue.add(song);
  }

  @override
  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    await _audioSource.move(oldIndex, newIndex);
    final song = _queue.removeAt(oldIndex);
    _queue.insert(newIndex, song);
  }

  @override
  Future<void> playNext(SongModel song) async {
    final index = currentIndexStream.value + 1;
    await _audioSource.insert(index, ja.AudioSource.uri(Uri.file(song.path)));
    _queue.insert(index, song);
  }

  @override
  Future<void> removeQueueIndex(int index) async {
    await _audioSource.removeAt(index);
    _queue.removeAt(index);
  }

  @override
  Future<void> replaceQueueAroundIndex(
      {List<SongModel> before, List<SongModel> after, int index}) async {
    _queue = before + [_queue[index]] + after;

    final _before = _songModelsToAudioSource(before);
    final _after = _songModelsToAudioSource(after);

    await _audioSource.removeRange(0, index);
    await _audioSource.removeRange(1, _audioSource.length);

    await _audioSource.insertAll(0, _before.children);
    await _audioSource.addAll(_after.children);
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

  /// extend the loaded audiosource, when seeking to previous/next
  Future<bool> _updateLoadedQueue(int newIndex) async {
    _log.info('updateLoadedQueue: $newIndex');
    _log.info('[$loadStartIndex, $loadEndIndex]');

    if (loadStartIndex == null || loadEndIndex == null || newIndex == null) return false;

    if (loadStartIndex == loadEndIndex || (loadStartIndex == 0 && loadEndIndex == _queue.length))
      return false;

    if (loadStartIndex < loadEndIndex) {
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
      if (loadStartIndex > 0) {
        // load the song previous to the already loaded songs
        _log.info('loadStartIndex--');
        loadStartIndex--;
        await _audioSource.insert(0, ja.AudioSource.uri(Uri.file(_queue[loadStartIndex].path)));
        return true;
      } else if (loadEndIndex < _queue.length) {
        // load the last song, if it isn't already loaded
        _log.info('loadStartIndex = ${_queue.length - 1}');
        loadStartIndex = _queue.length - 1;
        await _audioSource.add(ja.AudioSource.uri(Uri.file(_queue.last.path)));
        return false;
      }
    } else if (newIndex > _audioSource.length - LOAD_INTERVAL - 1) {
      // need to load next song
      if (loadEndIndex < _queue.length) {
        // we ARE NOT at the end of the queue -> load next song
        _log.info('loadEndIndex++');
        loadEndIndex++;
        await _audioSource.add(ja.AudioSource.uri(Uri.file(_queue[loadEndIndex - 1].path)));
        return false;
      } else if (loadStartIndex > 0) {
        // we ARE at the end of the queue AND the first song has not been loaded yet
        // -> load first song
        _log.info('loadEndIndex = 1');
        loadEndIndex = 1;
        await _audioSource.insert(0, ja.AudioSource.uri(Uri.file(_queue[0].path)));
        return true;
      }
    }
    return false;
  }

  Future<bool> _updateLoadedQueueInverted(int newIndex) async {
    final rightOfLoadEnd = newIndex >= loadEndIndex;

    int leftBorder = newIndex - LOAD_INTERVAL;
    if (newIndex  < loadEndIndex) {
      leftBorder += _audioSource.length;
    }

    int rightBorder = newIndex + LOAD_INTERVAL;
    if (newIndex > loadEndIndex) {
      rightBorder -= _audioSource.length;
    }

    if (leftBorder < loadEndIndex) {
      // nearing the start of the loaded songs
      // load the song previous to the already loaded songs
      _log.info('inv: loadStartIndex--');
      loadStartIndex--;
      await _audioSource.insert(
          loadEndIndex, ja.AudioSource.uri(Uri.file(_queue[loadStartIndex].path)));
      return rightOfLoadEnd;
    } else if (rightBorder >= loadEndIndex) {
      // need to load next song
      // we ARE NOT at the end of the queue -> load next song
      _log.info('inv: loadEndIndex++');
      loadEndIndex++;
      await _audioSource.insert(
          loadEndIndex - 1, ja.AudioSource.uri(Uri.file(_queue[loadEndIndex - 1].path)));
      return rightOfLoadEnd;
    }
    return false;
  }

  void _updateCurrentIndex(int apIndex) {
    if (loadStartIndex == null || loadEndIndex == null) {
      _currentIndexSubject.add(apIndex);
      return;
    }

    int result;
    if (_audioSource != null && _audioSource.length == _queue.length) {
      _log.info('EVERYTHING LOADED');
      result = apIndex;
    } else if (loadStartIndex < loadEndIndex) {
      // base case
      result = apIndex != null ? (apIndex + (loadStartIndex ?? 0)) : null;
    } else {
      // inverted case
      if (apIndex < loadEndIndex) {
        result = apIndex;
      } else  {
        result = apIndex + (loadStartIndex - loadEndIndex);
      }
    }

    _currentIndexSubject.add(result);
    _log.info('updateCurrentIndex: $result');
  }
}
