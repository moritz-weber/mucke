import '../entities/playable.dart';
import '../entities/playlist.dart';
import '../entities/smart_list.dart';
import '../entities/song.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';

class PlaySongs {
  PlaySongs(
    this._audioPlayerRepository,
    this._musicDataRepository,
  );

  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataRepository _musicDataRepository;

  /// Generate and play a queue from the [songs] according to current AudioPlayer settings.
  Future<void> call({
    required List<Song> songs,
    required int initialIndex,
    required Playable playable,
    required bool keepInitialIndex,
  }) async {
    if (0 <= initialIndex && initialIndex < songs.length) {
      await _audioPlayerRepository.loadSongs(
        initialIndex: initialIndex,
        songs: songs,
        playable: playable,
        keepInitialIndex: keepInitialIndex,
      );
      _audioPlayerRepository.play();

      if (playable.type == PlayableType.playlist) {
        playable as Playlist;
        _musicDataRepository.updatePlaylist(
          Playlist(
            id: playable.id,
            gradientString: playable.gradientString,
            iconString: playable.iconString,
            name: playable.name,
            timeChanged: playable.timeChanged,
            timeCreated: playable.timeCreated,
            timeLastPlayed: DateTime.now(),
            shuffleMode: playable.shuffleMode,
          ),
        );
      } else if (playable.type == PlayableType.smartlist) {
        playable as SmartList;
        _musicDataRepository.updateSmartList(
          SmartList(
            id: playable.id,
            gradientString: playable.gradientString,
            iconString: playable.iconString,
            name: playable.name,
            timeChanged: playable.timeChanged,
            timeCreated: playable.timeCreated,
            timeLastPlayed: DateTime.now(),
            filter: playable.filter,
            orderBy: playable.orderBy,
            shuffleMode: playable.shuffleMode,
          ),
        );
      }
    }
  }
}
