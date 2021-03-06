import 'dart:math';

import '../entities/shuffle_mode.dart';
import '../entities/song.dart';
import '../repositories/music_data_repository.dart';
import 'play_songs.dart';
import 'set_shuffle_mode.dart';

const SHUFFLE_MODE = ShuffleMode.plus;

class ShuffleAll {
  ShuffleAll(
    this._musicDataRepository,
    this._playSongs,
    this._setShuffleMode,
  );

  final PlaySongs _playSongs;
  final SetShuffleMode _setShuffleMode;

  final MusicDataRepository _musicDataRepository;

  Future<void> call() async {
    final List<Song> songs = await _musicDataRepository.songStream.first;
    final rng = Random();
    final index = rng.nextInt(songs.length);

    await _setShuffleMode(SHUFFLE_MODE, updateQueue: false);
    _playSongs(songs: songs, initialIndex: index);
  }
}
