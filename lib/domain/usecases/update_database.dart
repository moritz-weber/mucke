import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecase.dart';
import '../repositories/music_data_repository.dart';

class UpdateDatabase implements UseCase<void, void> {
  UpdateDatabase(this._musicDataRepository);

  final MusicDataRepository _musicDataRepository;

  @override
  Future<Either<Failure, void>> call([_]) async {
    await _musicDataRepository.updateDatabase();
    return Right<Failure, void>(null);
  }
}
