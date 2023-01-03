import '../entities/song.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';

class MusicDataActor {
  MusicDataActor(
    this._audioPlayerRepository,
    this._musicDataRepository,
  ) {
    _musicDataRepository.songUpdateStream.listen(_handleSongUpdate);
    _musicDataRepository.songRemovalStream.listen(_handleSongRemoval);
  }

  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataRepository _musicDataRepository;

  void _handleSongUpdate(Map<String, Song> songs) {
    _audioPlayerRepository.updateSongs(songs);
  }

  void _handleSongRemoval(List<String> paths) {
    _audioPlayerRepository.removeBlockedSongs(paths);
  }
}
