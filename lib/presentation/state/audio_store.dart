import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:mucke/domain/repositories/music_data_repository.dart';

import '../../domain/entities/playback_state.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/audio_repository.dart';

part 'audio_store.g.dart';

class AudioStore extends _AudioStore with _$AudioStore {
  AudioStore({
    @required AudioRepository audioRepository,
    @required MusicDataRepository musicDataRepository,
  }) : super(audioRepository, musicDataRepository);
}

abstract class _AudioStore with Store {
  _AudioStore(this._audioRepository, this._musicDataRepository) {
    currentSongStream =
        _audioRepository.currentSongStream.distinct().asObservable();

    currentPositionStream =
        _audioRepository.currentPositionStream.asObservable(initialValue: 0);

    queueStream =
        _musicDataRepository.queueStream.asObservable(initialValue: []);

    queueIndexStream = _audioRepository.queueIndexStream.asObservable();

    shuffleModeStream = _audioRepository.shuffleModeStream
        .asObservable(initialValue: ShuffleMode.none);

    playbackStateStream = _audioRepository.playbackStateStream.asObservable();
  }

  final AudioRepository _audioRepository;
  final MusicDataRepository _musicDataRepository;

  @observable
  ObservableStream<Song> currentSongStream;

  @computed
  Song get currentSong {
    print('currentSong!!!');
    if (queueStream.value != [] && queueIndexStream.status == StreamStatus.active) {
      final song = queueStream.value[queueIndexStream.value];
      return song;
    }

    return null;
  }

  @observable
  ObservableStream<PlaybackState> playbackStateStream;

  @observable
  ObservableStream<int> currentPositionStream;

  @observable
  ObservableStream<List<Song>> queueStream;

  @observable
  ObservableStream<int> queueIndexStream;

  @observable
  ObservableStream<ShuffleMode> shuffleModeStream;

  @action
  Future<void> playSong(int index, List<Song> songList) async {
    _audioRepository.playSong(index, songList);
  }

  @action
  Future<void> play() async {
    _audioRepository.play();
  }

  @action
  Future<void> pause() async {
    _audioRepository.pause();
  }

  @action
  Future<void> skipToNext() async {
    _audioRepository.skipToNext();
  }

  @action
  Future<void> skipToPrevious() async {
    _audioRepository.skipToPrevious();
  }

  Future<void> setShuffleMode(ShuffleMode shuffleMode) async {
    _audioRepository.setShuffleMode(shuffleMode);
  }

  Future<void> shuffleAll() async {
    _audioRepository.shuffleAll();
  }

  Future<void> addToQueue(Song song) async {
    _audioRepository.addToQueue(song);
  }

  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    _audioRepository.moveQueueItem(oldIndex, newIndex);
  }

  Future<void> removeQueueIndex(int index) async {
    _audioRepository.removeQueueIndex(index);
  }
}
