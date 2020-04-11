import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/playback_state.dart';
import '../entities/song.dart';

abstract class AudioRepository {
  Stream<Song> get currentSongStream;
  Stream<PlaybackState> get playbackStateStream;
  Stream<int> get currentPositionStream;

  Future<Either<Failure, void>> playSong(int index, List<Song> songList);
  Future<Either<Failure, void>> play();
  Future<Either<Failure, void>> pause();
}