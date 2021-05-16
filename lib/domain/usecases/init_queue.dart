import '../entities/queue_item.dart';
import '../entities/song.dart';
import '../repositories/audio_player_repository.dart';

class InitQueue {
  InitQueue(this._audioPlayerRepository);

  final AudioPlayerRepository _audioPlayerRepository;

  Future<void> call(List<QueueItem> queueItems, List<Song> originalSongs, List<Song> addedSongs, int index) async {
    await _audioPlayerRepository.initQueue(queueItems, originalSongs, addedSongs, index);
  }
}
