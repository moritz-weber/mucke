import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
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
  Stream<PlaybackState> get playbackStateStream =>
      _audioManager.playbackStateStream;

  @override
  Stream<List<Song>> get queueStream => _audioManager.queueStream;

  @override
  Stream<int> get queueIndexStream => _audioManager.queueIndexStream;

  @override
  Stream<ShuffleMode> get shuffleModeStream => _audioManager.shuffleModeStream;

  @override
  Stream<int> get currentPositionStream => _audioManager.currentPositionStream;

  @override
  Future<Either<Failure, void>> playSong(int index, List<Song> songList) async {
    final List<SongModel> songModelList =
        songList.map((song) => song as SongModel).toList();

    if (0 <= index && index < songList.length) {
      await _audioManager.playSong(index, songModelList);
      return const Right(null);
    }
    return Left(IndexFailure());
  }

  @override
  Future<Either<Failure, void>> play() async {
    await _audioManager.play();
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> pause() async {
    await _audioManager.pause();
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> skipToNext() async {
    await _audioManager.skipToNext();
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> skipToPrevious() async {
    await _audioManager.skipToPrevious();
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> setShuffleMode(ShuffleMode shuffleMode) async {
    await _audioManager.setShuffleMode(shuffleMode);
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> shuffleAll() async {
    await _audioManager.shuffleAll();
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> addToQueue(Song song) async {
    await _audioManager.addToQueue(song as SongModel);
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> moveQueueItem(int oldIndex, int newIndex) async {
    await _audioManager.moveQueueItem(oldIndex, newIndex);
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> removeQueueIndex(int index) async {
    await _audioManager.removeQueueIndex(index);
    return const Right(null);
  }
}
