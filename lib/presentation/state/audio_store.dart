import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/playable.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/smart_list.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/audio_player_repository.dart';
import '../../domain/usecases/play_album.dart';
import '../../domain/usecases/play_artist.dart';
import '../../domain/usecases/play_smart_list.dart';
import '../../domain/usecases/play_songs.dart';
import '../../domain/usecases/seek_to_next.dart';
import '../../domain/usecases/shuffle_all.dart';

part 'audio_store.g.dart';

class AudioStore extends _AudioStore with _$AudioStore {
  AudioStore({
    required PlayAlbum playAlbum,
    required PlayArtist playArtist,
    required PlaySongs playSongs,
    required PlaySmartList playSmartList,
    required SeekToNext seekToNext,
    required ShuffleAll shuffleAll,
    required AudioPlayerRepository audioPlayerRepository,
  }) : super(
          playSongs,
          audioPlayerRepository,
          playAlbum,
          playArtist,
          playSmartList,
          seekToNext,
          shuffleAll,
        );
}

abstract class _AudioStore with Store {
  _AudioStore(
    this._playSongs,
    this._audioPlayerRepository,
    this._playAlbum,
    this._playArtist,
    this._playSmartList,
    this._seekToNext,
    this._shuffleAll,
  );

  final AudioPlayerRepository _audioPlayerRepository;

  final PlayAlbum _playAlbum;
  final PlayArtist _playArtist;
  final PlaySmartList _playSmartList;
  final PlaySongs _playSongs;
  final SeekToNext _seekToNext;
  final ShuffleAll _shuffleAll;

  @observable
  late ObservableStream<Song> currentSongStream =
      _audioPlayerRepository.currentSongStream.asObservable();

  @observable
  late ObservableStream<bool> playingStream = _audioPlayerRepository.playingStream.asObservable();

  @observable
  late ObservableStream<Duration> currentPositionStream =
      _audioPlayerRepository.positionStream.asObservable(initialValue: const Duration(seconds: 0));

  // beware that this only triggers reactions when a new list (new reference) is set
  // doesn't work if the same reference is added to BehaviorSubject
  @observable
  late ObservableStream<List<Song>> queueStream = _audioPlayerRepository.queueStream.asObservable();

  @observable
  late ObservableStream<int> queueIndexStream =
      _audioPlayerRepository.currentIndexStream.asObservable();

  @observable
  late ObservableStream<ShuffleMode> shuffleModeStream =
      _audioPlayerRepository.shuffleModeStream.asObservable();

  @observable
  late ObservableStream<LoopMode> loopModeStream =
      _audioPlayerRepository.loopModeStream.asObservable();

  @computed
  bool get hasNext => (queueIndexStream.value != null &&
          queueStream.value != null &&
          queueIndexStream.value! < queueStream.value!.length - 1) ||
      (loopModeStream.value ?? LoopMode.off) != LoopMode.off;

  Future<void> playSong(int index, List<Song> songList, Playable playable) async {
    _playSongs(songs: songList, initialIndex: index, playable: playable);
  }

  Future<void> play() async => _audioPlayerRepository.play();

  Future<void> pause() async => _audioPlayerRepository.pause();

  Future<void> skipToNext() async => _seekToNext();

  Future<void> skipToPrevious() async => _audioPlayerRepository.seekToPrevious();

  Future<void> seekToIndex(int index) async => _audioPlayerRepository.seekToIndex(index);

  Future<void> seekToPosition(double position) async =>
      _audioPlayerRepository.seekToPosition(position);

  Future<void> setShuffleMode(ShuffleMode shuffleMode) async =>
      _audioPlayerRepository.setShuffleMode(shuffleMode);

  Future<void> setLoopMode(LoopMode loopMode) async => _audioPlayerRepository.setLoopMode(loopMode);

  Future<void> shuffleAll() async => _shuffleAll();

  Future<void> addToQueue(List<Song> songs) async => _audioPlayerRepository.addToQueue(songs);

  Future<void> playNext(List<Song> songs) async => _audioPlayerRepository.playNext(songs);

  Future<void> appendToNext(List<Song> songs) async => _audioPlayerRepository.addToNext(songs);

  Future<void> moveQueueItem(int oldIndex, int newIndex) async =>
      _audioPlayerRepository.moveQueueItem(oldIndex, newIndex);

  Future<void> removeQueueIndex(int index) async => _audioPlayerRepository.removeQueueIndex(index);

  Future<void> playAlbum(Album album) async => _playAlbum(album);

  Future<void> playSmartList(SmartList smartList) async => _playSmartList(smartList);

  Future<void> shuffleArtist(Artist artist) async => _playArtist(artist);
}
