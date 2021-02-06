import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/playback_state.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/audio_repository.dart';
import '../../domain/repositories/persistent_player_state_repository.dart';

part 'audio_store.g.dart';

class AudioStore extends _AudioStore with _$AudioStore {
  AudioStore({
    @required AudioRepository audioRepository,
    @required PlayerStateRepository persistentPlayerStateRepository,
  }) : super(audioRepository, persistentPlayerStateRepository);
}

abstract class _AudioStore with Store {
  _AudioStore(this._audioRepository, this._persistentPlayerStateRepository) {
    currentPositionStream = _audioRepository.currentPositionStream.asObservable(initialValue: 0);

    queueStream = _persistentPlayerStateRepository.queueStream.asObservable();

    queueIndexStream = _persistentPlayerStateRepository.currentIndexStream.asObservable();

    currentSongStream = _persistentPlayerStateRepository.currentSongStream.asObservable();

    shuffleModeStream = _persistentPlayerStateRepository.shuffleModeStream.asObservable();

    loopModeStream = _persistentPlayerStateRepository.loopModeStream.asObservable();

    playbackStateStream = _audioRepository.playbackStateStream.asObservable();
  }

  final AudioRepository _audioRepository;
  final PlayerStateRepository _persistentPlayerStateRepository;

  @observable
  ObservableStream<Song> currentSongStream;

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

  @observable
  ObservableStream<LoopMode> loopModeStream;

  Future<void> playSong(int index, List<Song> songList) async {
    _audioRepository.playSong(index, songList);
  }

  Future<void> play() async {
    _audioRepository.play();
  }

  Future<void> pause() async {
    _audioRepository.pause();
  }

  Future<void> skipToNext() async {
    _audioRepository.skipToNext();
  }

  Future<void> skipToPrevious() async {
    _audioRepository.skipToPrevious();
  }

  Future<void> setIndex(int index) async {
    _audioRepository.setIndex(index);
  }

  Future<void> setShuffleMode(ShuffleMode shuffleMode) async {
    _audioRepository.setShuffleMode(shuffleMode);
  }

  Future<void> setLoopMode(LoopMode loopMode) async {
    _audioRepository.setLoopMode(loopMode);
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

  Future<void> playAlbum(Album album) async {
    _audioRepository.playAlbum(album);
  }

  Future<void> shuffleArtist(Artist artist) async {
    _audioRepository.playArtist(artist, shuffleMode: ShuffleMode.plus);
  }
}
