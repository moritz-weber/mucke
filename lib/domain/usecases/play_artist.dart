import 'dart:math';

import '../entities/artist.dart';
import '../entities/shuffle_mode.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';
import 'play_songs.dart';

class PlayArtist {
  PlayArtist(
    this._audioPlayerRepository,
    this._musicDataRepository,
    this._playSongs,
  );

  final PlaySongs _playSongs;

  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataRepository _musicDataRepository;

  Future<void> call(Artist artist, ShuffleMode? shuffleMode) async {
    final songs = await _musicDataRepository.getArtistSongStream(artist).first;
    if (shuffleMode != null) {
      await _audioPlayerRepository.setShuffleMode(shuffleMode, updateQueue: false);
    }
    
    final activeShuffleMode = _audioPlayerRepository.shuffleModeStream.value;
    int index = 0;
    if (activeShuffleMode != ShuffleMode.none) {
      final rng = Random();
      index = rng.nextInt(songs.length);
    }

    _playSongs(songs: songs, initialIndex: index, playable: artist, keepInitialIndex: false);
  }
}
