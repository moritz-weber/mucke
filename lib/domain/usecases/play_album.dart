import '../entities/album.dart';
import '../entities/shuffle_mode.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';
import 'play_songs.dart';

class PlayAlbum {
  PlayAlbum(
    this._audioPlayerRepository,
    this._musicDataRepository,
    this._playSongs,
  );

  final PlaySongs _playSongs;

  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataRepository _musicDataRepository;

  Future<void> call(Album album) async {
    final songs = await _musicDataRepository.getAlbumSongStream(album).first;

    await _audioPlayerRepository.setShuffleMode(ShuffleMode.none, updateQueue: false);
    _playSongs(songs: songs, initialIndex: 0, playable: album);
  }
}
