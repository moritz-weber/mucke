import 'package:just_audio/just_audio.dart' as ja;
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/shuffle_mode.dart';
import '../models/player_state_model.dart';
import '../models/queue_item.dart';
import '../models/song_model.dart';
import 'audio_player_contract.dart';
import 'queue_generator.dart';

class AudioPlayerImpl implements AudioPlayer {
  AudioPlayerImpl(this._audioPlayer, this._queueGenerator) {
    _audioPlayer.currentIndexStream.listen((event) {
      _currentIndexSubject.add(event);
      _currentSongSubject.add(_queueSubject.value[event]);
    });

    _audioPlayer.positionStream.listen((event) {
      _positionSubject.add(event);
    });

    _audioPlayer.playerStateStream.listen((event) {
      _playerStateSubject.add(PlayerStateModel.fromJAPlayerState(event));
    });

    _queueSubject.listen((event) {
      _currentSongSubject.add(event[_currentIndexSubject.value]);
    });
  }

  final ja.AudioPlayer _audioPlayer;
  ja.ConcatenatingAudioSource _audioSource;
  final QueueGenerator _queueGenerator;

  List<SongModel> _inputQueue;
  List<QueueItem> _queue;

  final BehaviorSubject<int> _currentIndexSubject = BehaviorSubject();
  final BehaviorSubject<SongModel> _currentSongSubject = BehaviorSubject();
  final BehaviorSubject<PlayerStateModel> _playerStateSubject = BehaviorSubject();
  final BehaviorSubject<Duration> _positionSubject = BehaviorSubject();
  final BehaviorSubject<List<SongModel>> _queueSubject = BehaviorSubject.seeded([]);
  final BehaviorSubject<ShuffleMode> _shuffleModeSubject = BehaviorSubject.seeded(ShuffleMode.none);

  @override
  ValueStream<int> get currentIndexStream => _currentIndexSubject.stream;

  @override
  ValueStream<SongModel> get currentSongStream => _currentSongSubject.stream;

  @override
  ValueStream<PlayerStateModel> get playerStateStream => _playerStateSubject.stream;

  @override
  ValueStream<Duration> get positionStream => _positionSubject.stream;

  @override
  ValueStream<List<SongModel>> get queueStream => _queueSubject.stream;

  @override
  ValueStream<ShuffleMode> get shuffleModeStream => _shuffleModeSubject.stream;

  @override
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }

  @override
  Future<void> loadQueue(List<QueueItem> queue) {
    // TODO: implement loadQueue
    throw UnimplementedError();
  }

  @override
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> play() async {
    await _audioPlayer.play();
  }

  @override
  Future<void> playSongList(List<SongModel> songs, int startIndex) async {
    _inputQueue = songs;

    final firstSong = songs.sublist(startIndex, startIndex + 1);
    _queueSubject.add(firstSong);
    _audioSource = _queueGenerator.songModelsToAudioSource(firstSong);
    _audioPlayer.play();
    await _audioPlayer.load(_audioSource, initialIndex: 0);

    _queue = await _queueGenerator.generateQueue(_shuffleModeSubject.value, songs, startIndex);
    final songModelQueue = _queue.map((e) => e.song).toList();
    _queueSubject.add(songModelQueue);

    final int splitIndex = _shuffleModeSubject.value == ShuffleMode.none ? startIndex : 0;
    final newQueue = _queueGenerator.songModelsToAudioSource(songModelQueue);
    _audioSource.insertAll(0, newQueue.children.sublist(0, splitIndex));
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
    _queue.add(QueueItem(song, originalIndex: -1, type: QueueItemType.added));
    _queueSubject.add(_queue.map((e) => e.song).toList());
  }

  @override
  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    final QueueItem queueItem = _queue.removeAt(oldIndex);
    final index = newIndex < oldIndex ? newIndex : newIndex - 1;
    _queue.insert(index, queueItem);
    _queueSubject.add(_queue.map((e) => e.song).toList());
    await _audioSource.move(oldIndex, index);
  }

  @override
  Future<void> removeQueueIndex(int index) async {
    _queue.removeAt(index);
    _queueSubject.add(_queue.map((e) => e.song).toList());
    await _audioSource.removeAt(index);
  }

  @override
  Future<void> setShuffleMode(ShuffleMode shuffleMode, bool updateQueue) async {
    _shuffleModeSubject.add(shuffleMode);

    if (updateQueue) {
      final QueueItem currentQueueItem = _queue[_currentIndexSubject.value];
      final int index = currentQueueItem.originalIndex;
      _queue = await _queueGenerator.generateQueue(shuffleMode, _inputQueue, index);
      // TODO: maybe refactor _queue to a subject and listen for changes
      final songModelQueue = _queue.map((e) => e.song).toList();
      _queueSubject.add(songModelQueue);

      final newQueue = _queueGenerator.songModelsToAudioSource(songModelQueue);
      _updateQueue(newQueue, currentQueueItem);
    }
  }

  void _updateQueue(ja.ConcatenatingAudioSource newQueue, QueueItem currentQueueItem) {
    final int index = currentQueueItem.originalIndex;

    _audioSource.removeRange(0, _currentIndexSubject.value);
    _audioSource.removeRange(1, _audioSource.length);

    if (_shuffleModeSubject.value == ShuffleMode.none) {
      switch (currentQueueItem.type) {
        case QueueItemType.added:
        case QueueItemType.standard:
          _audioSource.insertAll(0, newQueue.children.sublist(0, index));
          _audioSource.addAll(newQueue.children.sublist(index + 1));
          break;
        case QueueItemType.predecessor:
          _audioSource.insertAll(0, newQueue.children.sublist(0, index));
          _audioSource.addAll(newQueue.children.sublist(index));
          break;
        case QueueItemType.successor:
          _audioSource.insertAll(0, newQueue.children.sublist(0, index + 1));
          _audioSource.addAll(newQueue.children.sublist(index + 1));
          break;
      }
      _currentIndexSubject.add(index);
    } else {
      _audioSource.addAll(newQueue.children.sublist(1));
    }
  }
}
