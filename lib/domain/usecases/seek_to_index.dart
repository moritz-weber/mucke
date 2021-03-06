import '../repositories/audio_player_repository.dart';

class SeekToIndex {
  SeekToIndex(this._audioPlayerRepository);

  final AudioPlayerRepository _audioPlayerRepository;

  Future<void> call(int index) async {
    await _audioPlayerRepository.seekToIndex(index);
  }
}
