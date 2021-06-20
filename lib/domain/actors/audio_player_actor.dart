import '../entities/song.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';
import '../usecases/handle_playback_state.dart';
import '../usecases/increment_play_count.dart';
import '../usecases/set_current_song.dart';

class AudioPlayerActor {
  AudioPlayerActor(
    this._audioPlayerRepository,
    this._musicDataInfoRepository,
    this._handlePlaybackEvent,
    this._incrementPlayCount,
    this._setCurrentSong,
  ) {
    _audioPlayerRepository.currentSongStream.listen(_handleCurrentSong);
    _audioPlayerRepository.playbackEventStream.listen(_handlePlaybackEvent);
    _audioPlayerRepository.positionStream
        .listen((duration) => _handlePosition(duration, _currentSong));

    _musicDataInfoRepository.songUpdateStream.listen(_handleSongUpdate);
  }

  // TODO: is this against a previous design choice? only direct "read" access to repos?
  // Should this actor only listen to AudioPlayer events? --> move song update to new actor?
  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataInfoRepository _musicDataInfoRepository;

  final HandlePlaybackEvent _handlePlaybackEvent;
  final IncrementPlayCount _incrementPlayCount;
  final SetCurrentSong _setCurrentSong;

  Song? _currentSong;
  bool _countSongPlayback = false;

  Future<void> _handleCurrentSong(Song song) async {
    _currentSong = song;
    return _setCurrentSong(song);
  }

  void _handlePosition(Duration? position, Song? song) {
    if (song == null || position == null) {
      return;
    }

    final int pos = position.inMilliseconds;

    if (pos < song.duration * 0.05) {
      _countSongPlayback = true;
    } else if (pos > song.duration * 0.95 && _countSongPlayback) {
      _countSongPlayback = false;
      _incrementPlayCount(song);
    }
  }

  void _handleSongUpdate(Map<String, Song> songs) {
    _audioPlayerRepository.updateSongs(songs);
  }
}
