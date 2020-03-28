import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecase.dart';
import '../entities/album.dart';
import '../repositories/music_data_repository.dart';

class GetAlbums implements UseCase<List<Album>, void> {
  GetAlbums(this.musicDataRepository);

  final MusicDataRepository musicDataRepository;

  @override
  Future<Either<Failure, List<Album>>> call([_]) async {
    return await musicDataRepository.getAlbums();
  }
}
