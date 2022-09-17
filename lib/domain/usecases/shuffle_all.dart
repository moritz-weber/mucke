import 'dart:math';

import '../entities/playable.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';
import 'play_songs.dart';

class ShuffleAll {
  ShuffleAll(
    this._audioPlayerRepository,
    this._musicDataRepository,
    this._playSongs,
  );

  final PlaySongs _playSongs;

  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataRepository _musicDataRepository;

  Future<void> call(ShuffleMode shuffleMode) async {
    final List<Song> songs = await _musicDataRepository.songsStream.first;
    final rng = Random();
    final index = rng.nextInt(songs.length);

    await _audioPlayerRepository.setShuffleMode(shuffleMode, updateQueue: false);
    _playSongs(
      songs: songs,
      initialIndex: index,
      playable: AllSongs(),
      keepInitialIndex: false,
    );
  }
}
