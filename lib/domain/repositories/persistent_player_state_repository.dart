import '../entities/loop_mode.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';

abstract class PlayerStateRepository {
  Stream<List<Song>> get queueStream;
  Stream<int> get currentIndexStream;
  Stream<Song> get currentSongStream;
  Stream<LoopMode> get loopModeStream;
  Stream<ShuffleMode> get shuffleModeStream;
}
