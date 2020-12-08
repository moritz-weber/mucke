import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/playback_state.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';

abstract class AudioRepository {
  Stream<Song> get currentSongStream;
  Stream<PlaybackState> get playbackStateStream;
  Stream<List<Song>> get queueStream;
  Stream<int> get queueIndexStream;
  Stream<int> get currentPositionStream;
  Stream<ShuffleMode> get shuffleModeStream;

  Future<Either<Failure, void>> playSong(int index, List<Song> songList);
  Future<Either<Failure, void>> play();
  Future<Either<Failure, void>> pause();
  Future<Either<Failure, void>> skipToNext();
  Future<Either<Failure, void>> skipToPrevious();
  Future<Either<Failure, void>> setShuffleMode(ShuffleMode shuffleMode);
  Future<Either<Failure, void>> shuffleAll();
  Future<Either<Failure, void>> addToQueue(Song song);
  Future<Either<Failure, void>> moveQueueItem(int oldIndex, int newIndex);
  Future<Either<Failure, void>> removeQueueIndex(int index);
}
