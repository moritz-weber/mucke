import '../entities/loop_mode.dart';
import '../entities/song.dart';

abstract class PlayerStateRepository {
  Stream<List<Song>> get queueStream;
  Stream<int> get currentIndexStream;
  Stream<LoopMode> get loopModeStream;
}
