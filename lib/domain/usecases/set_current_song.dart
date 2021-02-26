import '../entities/song.dart';
import '../repositories/platform_integration_repository.dart';

class SetCurrentSong {
  SetCurrentSong(this._platformIntegrationRepository);

  final PlatformIntegrationRepository _platformIntegrationRepository;

  Future<void> call(Song song) async {
    _platformIntegrationRepository.setCurrentSong(song);
  }
}