import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/song.dart';

abstract class AudioRepository {
  Future<Either<Failure, void>> playSong(int index, List<Song> songList);
}