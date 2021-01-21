import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/playback_state.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/song_model.dart';

abstract class AudioManager {
  Stream<SongModel> get currentSongStream;
  Stream<PlaybackState> get playbackStateStream;

  /// Current position in the song in milliseconds.
  Stream<int> get currentPositionStream;

  Future<void> playSong(int index, List<SongModel> songList);
  Future<void> play();
  Future<void> pause();
  Future<void> skipToNext();
  Future<void> skipToPrevious();
  Future<void> setIndex(int index);
  Future<void> setShuffleMode(ShuffleMode shuffleMode);
  Future<void> setLoopMode(LoopMode loopMode);
  Future<void> shuffleAll();
  Future<void> addToQueue(SongModel songModel);
  Future<void> moveQueueItem(int oldIndex, int newIndex);
  Future<void> removeQueueIndex(int index);

  Future<void> playAlbum(AlbumModel albumModel);
  Future<void> playArtist(ArtistModel artistModel, ShuffleMode shuffleMode);
}
