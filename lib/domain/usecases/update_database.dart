import '../repositories/music_data_repository.dart';

class UpdateDatabase {
  UpdateDatabase(this._musicDataRepository);

  final MusicDataRepository _musicDataRepository;

  Future<void> call() async {
    await _musicDataRepository.updateDatabase();
  }
}