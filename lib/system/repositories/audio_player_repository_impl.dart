import 'package:rxdart/rxdart.dart';

import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/playback_event.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/audio_player_repository.dart';
import '../datasources/audio_player_data_source.dart';
import '../models/song_model.dart';

class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  AudioPlayerRepositoryImpl(this._audioPlayerDataSource) {
    _shuffleModeSubject.add(ShuffleMode.none);
    _loopModeSubject.add(LoopMode.off);

    _audioPlayerDataSource.currentIndexStream.listen(
      (index) {
        print('CURRENT INDEX: $index');
        _updateCurrentSong(queueStream.value, index);
      },
    );
    _queueSubject.listen((queue) => _updateCurrentSong(queue, currentIndexStream.value));
  }

  final AudioPlayerDataSource _audioPlayerDataSource;

  // final BehaviorSubject<int> _currentIndexSubject = BehaviorSubject();
  final BehaviorSubject<Song> _currentSongSubject = BehaviorSubject<Song>();
  final BehaviorSubject<LoopMode> _loopModeSubject = BehaviorSubject();
  final BehaviorSubject<List<Song>> _queueSubject = BehaviorSubject();
  final BehaviorSubject<ShuffleMode> _shuffleModeSubject = BehaviorSubject();

  @override
  Stream<AudioPlayerEvent> eventStream;

  @override
  ValueStream<ShuffleMode> get shuffleModeStream => _shuffleModeSubject.stream;

  @override
  ValueStream<LoopMode> get loopModeStream => _loopModeSubject.stream;

  @override
  ValueStream<List<Song>> get queueStream => _queueSubject.stream;

  @override
  ValueStream<int> get currentIndexStream => _audioPlayerDataSource.currentIndexStream;

  @override
  Stream<Song> get currentSongStream => _currentSongSubject.stream;

  @override
  Stream<PlaybackEvent> get playbackEventStream => _audioPlayerDataSource.playbackEventStream;

  @override
  Stream<bool> get playingStream => _audioPlayerDataSource.playingStream;

  @override
  Stream<Duration> get positionStream => _audioPlayerDataSource.positionStream;

  @override
  Future<void> addToQueue(Song song) async {
    _audioPlayerDataSource.addToQueue(song as SongModel);
    _queueSubject.add(_queueSubject.value + [song]);
  }

  @override
  Future<void> dispose() async {
    _audioPlayerDataSource.dispose();
  }

  @override
  Future<void> loadQueue({List<Song> queue, int initialIndex}) async {
    // _currentSongSubject.add(queue[initialIndex]);
    _queueSubject.add(queue);
    // _currentIndexSubject.add(initialIndex);

    await _audioPlayerDataSource.loadQueue(
      initialIndex: initialIndex,
      queue: queue.map((e) => e as SongModel).toList(),
    );
  }

  @override
  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    final _songList = _queueSubject.value.toList();

    _audioPlayerDataSource.moveQueueItem(oldIndex, newIndex);

    final song = _songList.removeAt(oldIndex);
    _songList.insert(newIndex, song);

    _queueSubject.add(_songList);
  }

  @override
  Future<void> pause() async {
    _audioPlayerDataSource.pause();
  }

  @override
  Future<void> play() async {
    _audioPlayerDataSource.play();
  }

  @override
  Future<void> playSong(Song song) async {
    await _audioPlayerDataSource.loadQueue(
      initialIndex: 0,
      queue: [song as SongModel],
    );
    _audioPlayerDataSource.play();
  }

  @override
  Future<void> playNext(Song song) async {
    final index = currentIndexStream.value + 1;
    final _songList = _queueSubject.value;

    _audioPlayerDataSource.playNext(song as SongModel);
    _queueSubject.add(_songList.sublist(0, index) + [song] + _songList.sublist(index));
  }

  @override
  Future<void> removeQueueIndex(int index) async {
    final _songList = _queueSubject.value;

    _audioPlayerDataSource.removeQueueIndex(index);

    _queueSubject.add(_songList.sublist(0, index) + _songList.sublist(index + 1));
  }

  @override
  Future<void> replaceQueueAroundIndex({List<Song> before, List<Song> after, int index}) async {
    _queueSubject.add(before + [_queueSubject.value[index]] + after);

    await _audioPlayerDataSource.replaceQueueAroundIndex(
      before: before.map((e) => e as SongModel).toList(),
      after: after.map((e) => e as SongModel).toList(),
      index: index,
    );
  }

  @override
  Future<bool> seekToNext() async {
    return await _audioPlayerDataSource.seekToNext();
  }

  @override
  Future<void> seekToPrevious() async {
    await _audioPlayerDataSource.seekToPrevious();
  }

  @override
  Future<void> seekToIndex(int index) async {
    await _audioPlayerDataSource.seekToIndex(index);
  }

  @override
  Future<void> setLoopMode(LoopMode loopMode) async {
    _loopModeSubject.add(loopMode);
    await _audioPlayerDataSource.setLoopMode(loopMode);
  }

  @override
  Future<void> setShuffleMode(ShuffleMode shuffleMode) async {
    _shuffleModeSubject.add(shuffleMode);
  }

  @override
  Future<void> stop() {
    // TODO: implement stop
    throw UnimplementedError();
  }

  void _updateCurrentSong(List<Song> queue, int index) {
    if (queue != null && index != null && index < queue.length) {
      _currentSongSubject.add(queue[index]);
    }
  }
}
