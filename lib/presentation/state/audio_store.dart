import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/playback_state.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/audio_repository.dart';
import '../../domain/repositories/music_data_repository.dart';

part 'audio_store.g.dart';

class AudioStore extends _AudioStore with _$AudioStore {
  AudioStore(
      {@required MusicDataRepository musicDataRepository,
      @required AudioRepository audioRepository})
      : super(musicDataRepository, audioRepository);
}

abstract class _AudioStore with Store {
  _AudioStore(this._musicDataRepository, this._audioRepository);

  final MusicDataRepository _musicDataRepository;
  final AudioRepository _audioRepository;

  bool _initialized = false;
  final List<ReactionDisposer> _disposers = [];

  @observable
  ObservableStream<Song> currentSong;
  @observable
  Song song;

  @observable
  ObservableStream<PlaybackState> playbackStateStream;

  @observable
  ObservableStream<int> currentPositionStream;

  @observable
  ObservableStream<List<Song>> queueStream;

  @observable
  ObservableStream<int> queueIndexStream;

  @action
  void init() {
    if (!_initialized) {
      print('AudioStore.init');
      currentSong = _audioRepository.currentSongStream.asObservable();

      currentPositionStream =
          _audioRepository.currentPositionStream.asObservable(initialValue: 0);

      queueStream = _audioRepository.queueStream.asObservable(initialValue: []);

      queueIndexStream = _audioRepository.queueIndexStream.asObservable();

      _disposers.add(autorun((_) {
        updateSong(currentSong.value);
      }));

      playbackStateStream = _audioRepository.playbackStateStream.asObservable();

      _initialized = true;
    }
  }

  void dispose() {
    print('AudioStore.dispose');
    _disposers.forEach((d) => d());
  }

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

  @action
  Future<void> updateSong(Song streamValue) async {
    print('updateSong');
    if (streamValue != null && streamValue != song) {
      print('actually updating...');
      song = streamValue;
    }
  }
}
