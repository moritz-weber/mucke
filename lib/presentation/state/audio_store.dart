import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/audio_player_repository.dart';
import '../../domain/usecases/pause.dart';
import '../../domain/usecases/play.dart';
import '../../domain/usecases/play_songs.dart';
import '../../domain/usecases/seek_to_next.dart';
import '../../domain/usecases/seek_to_previous.dart';
import '../../domain/usecases/set_loop_mode.dart';
import '../../domain/usecases/shuffle_all.dart';

part 'audio_store.g.dart';

class AudioStore extends _AudioStore with _$AudioStore {
  AudioStore({
    @required Pause pause,
    @required Play play,
    @required PlaySongs playSongs,
    @required SeekToNext seekToNext,
    @required SeekToPrevious seekToPrevious,
    @required SetLoopMode setLoopMode,
    @required ShuffleAll shuffleAll,
    @required AudioPlayerInfoRepository audioPlayerInfoRepository,
  }) : super(playSongs, audioPlayerInfoRepository, pause, play, seekToNext, seekToPrevious,
            setLoopMode, shuffleAll);
}

abstract class _AudioStore with Store {
  _AudioStore(
    this._playSongs,
    this._audioPlayerInfoRepository,
    this._pause,
    this._play,
    this._seekToNext,
    this._seekToPrevious,
    this._setLoopMode,
    this._shuffleAll,
  ) {
    currentPositionStream = _audioPlayerInfoRepository.positionStream
        .asObservable(initialValue: const Duration(seconds: 0));

    queueStream = _audioPlayerInfoRepository.songListStream.asObservable();

    queueIndexStream = _audioPlayerInfoRepository.currentIndexStream.asObservable();

    currentSongStream = _audioPlayerInfoRepository.currentSongStream.asObservable();

    shuffleModeStream = _audioPlayerInfoRepository.shuffleModeStream.asObservable();

    loopModeStream = _audioPlayerInfoRepository.loopModeStream.asObservable();

    playingStream = _audioPlayerInfoRepository.playingStream.asObservable();
  }

  final AudioPlayerInfoRepository _audioPlayerInfoRepository;

  final Pause _pause;
  final Play _play;
  final PlaySongs _playSongs;
  final SeekToNext _seekToNext;
  final SeekToPrevious _seekToPrevious;
  final SetLoopMode _setLoopMode;
  final ShuffleAll _shuffleAll;

  @observable
  ObservableStream<Song> currentSongStream;

  @observable
  ObservableStream<bool> playingStream;

  @observable
  ObservableStream<Duration> currentPositionStream;

  @observable
  ObservableStream<List<Song>> queueStream;

  @observable
  ObservableStream<int> queueIndexStream;

  @observable
  ObservableStream<ShuffleMode> shuffleModeStream;

  @observable
  ObservableStream<LoopMode> loopModeStream;

  Future<void> playSong(int index, List<Song> songList) async {
    _playSongs(songs: songList, initialIndex: index);
  }

  Future<void> play() async {
    _play();
  }

  Future<void> pause() async {
    _pause();
  }

  Future<void> skipToNext() async {
    _seekToNext();
  }

  Future<void> skipToPrevious() async {
    _seekToPrevious();
  }

  Future<void> setIndex(int index) async {
    // _audioInterface.setIndex(index);
  }

  Future<void> setShuffleMode(ShuffleMode shuffleMode) async {
    // _audioInterface.setShuffleMode(shuffleMode);
  }

  Future<void> setLoopMode(LoopMode loopMode) async {
    _setLoopMode(loopMode);
  }

  Future<void> shuffleAll() async {
    _shuffleAll();
  }

  Future<void> addToQueue(Song song) async {
    // _audioInterface.addToQueue(song);
  }

  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    // _audioInterface.moveQueueItem(oldIndex, newIndex);
  }

  Future<void> removeQueueIndex(int index) async {
    // _audioInterface.removeQueueIndex(index);
  }

  Future<void> playAlbum(Album album) async {
    // _audioInterface.playAlbum(album);
  }

  Future<void> shuffleArtist(Artist artist) async {
    // _audioInterface.playArtist(artist, shuffleMode: ShuffleMode.plus);
  }
}
