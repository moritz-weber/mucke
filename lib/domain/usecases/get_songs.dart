import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecase.dart';
import '../entities/song.dart';
import '../repositories/music_data_repository.dart';

class GetSongs implements UseCase<List<Song>, void> {
  GetSongs(this.musicDataRepository);

  final MusicDataRepository musicDataRepository;

  @override
  Future<Either<Failure, List<Song>>> call([_]) async {
    return await musicDataRepository.getSongs();
  }
}
