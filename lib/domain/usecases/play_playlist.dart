import 'dart:math';

import '../entities/playlist.dart';
import '../entities/shuffle_mode.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';
import 'play_songs.dart';

class PlayPlaylist {
  PlayPlaylist(
    this._audioPlayerRepository,
    this._musicDataRepository,
    this._playSongs,
  );

  final PlaySongs _playSongs;

  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataRepository _musicDataRepository;

  Future<void> call(Playlist playlist) async {
    final songs = await _musicDataRepository.getPlaylistSongStream(playlist).first;
    final shuffleMode = await _audioPlayerRepository.shuffleModeStream.first;
    final rng = Random();
    final initialIndex = shuffleMode == ShuffleMode.none ? 0 : rng.nextInt(songs.length);

    _playSongs(songs: songs, initialIndex: initialIndex, playable: playlist, keepInitialIndex: false);
  }
}
