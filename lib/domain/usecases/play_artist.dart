import 'dart:math';

import '../entities/artist.dart';
import '../entities/shuffle_mode.dart';
import '../repositories/music_data_repository.dart';
import 'play_songs.dart';
import 'set_shuffle_mode.dart';

class PlayArtist {
  PlayArtist(
    this._musicDataRepository,
    this._playSongs,
    this._setShuffleMode,
  );

  final PlaySongs _playSongs;
  final SetShuffleMode _setShuffleMode;

  final MusicDataRepository _musicDataRepository;

  Future<void> call(Artist artist) async {
    final songs = await _musicDataRepository.getArtistSongStream(artist).first;
    final rng = Random();
    final index = rng.nextInt(songs.length);

    await _setShuffleMode(ShuffleMode.plus, updateQueue: false);
    _playSongs(songs: songs, initialIndex: index);
  }
}
