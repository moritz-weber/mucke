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

  Future<void> call(Artist artist) async {
    final songs = await _musicDataRepository.getArtistSongStream(artist).first;
    final rng = Random();
    final index = rng.nextInt(songs.length);

    await _audioPlayerRepository.setShuffleMode(ShuffleMode.plus, updateQueue: false);
    _playSongs(songs: songs, initialIndex: index);
  }
}
