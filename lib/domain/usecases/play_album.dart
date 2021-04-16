import '../entities/album.dart';
import '../entities/shuffle_mode.dart';
import '../repositories/music_data_repository.dart';
import 'play_songs.dart';
import 'set_shuffle_mode.dart';

class PlayAlbum {
  PlayAlbum(
    this._musicDataRepository,
    this._playSongs,
    this._setShuffleMode,
  );

  final PlaySongs _playSongs;
  final SetShuffleMode _setShuffleMode;

  final MusicDataRepository _musicDataRepository;

  Future<void> call(Album album) async {
      final songs = await _musicDataRepository.getAlbumSongStream(album).first;

      await _setShuffleMode(ShuffleMode.none, updateQueue: false);
      _playSongs(songs: songs, initialIndex: 0);
  }
}
