import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/playback_state.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/audio_repository.dart';
import '../audio/audio_manager_contract.dart';
import '../models/song_model.dart';

class AudioRepositoryImpl implements AudioRepository {
  AudioRepositoryImpl(this._audioManager);

  final AudioManager _audioManager;

  @override
  Stream<Song> get currentSongStream => _audioManager.currentSongStream;

  @override
  Stream<PlaybackState> get playbackStateStream => _audioManager.playbackStateStream;

  @override
  Stream<int> get currentPositionStream => _audioManager.currentPositionStream;

  @override
  Future<void> playSong(int index, List<Song> songList) async {
    final List<SongModel> songModelList = songList.map((song) => song as SongModel).toList();

    if (0 <= index && index < songList.length) {
      await _audioManager.playSong(index, songModelList);
    }
  }

  @override
  Future<void> play() async {
    await _audioManager.play();
  }

  @override
  Future<void> pause() async {
    await _audioManager.pause();
  }

  @override
  Future<void> skipToNext() async {
    await _audioManager.skipToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    await _audioManager.skipToPrevious();
  }

  @override
  Future<void> setShuffleMode(ShuffleMode shuffleMode) async {
    await _audioManager.setShuffleMode(shuffleMode);
  }

  @override
  Future<void> shuffleAll() async {
    await _audioManager.shuffleAll();
  }

  @override
  Future<void> addToQueue(Song song) async {
    await _audioManager.addToQueue(song as SongModel);
  }

  @override
  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    await _audioManager.moveQueueItem(oldIndex, newIndex);
  }

  @override
  Future<void> removeQueueIndex(int index) async {
    await _audioManager.removeQueueIndex(index);
  }

  @override
  Future<void> setLoopMode(LoopMode loopMode) async {
    await _audioManager.setLoopMode(loopMode);
  }

  @override
  Future<void> setIndex(int index) async {
    await _audioManager.setIndex(index);
  }
}
