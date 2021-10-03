import '../entities/song.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';
import '../usecases/handle_playback_state.dart';
import '../usecases/set_current_song.dart';

class AudioPlayerActor {
  AudioPlayerActor(
    this._audioPlayerRepository,
    this._musicDataRepository,
    this._handlePlaybackEvent,
    this._setCurrentSong,
  ) {
    _audioPlayerRepository.currentSongStream.listen(_handleCurrentSong);
    _audioPlayerRepository.playbackEventStream.listen(_handlePlaybackEvent);
    _audioPlayerRepository.positionStream
        .listen((duration) => _handlePosition(duration, _currentSong));

    _musicDataRepository.songUpdateStream.listen(_handleSongUpdate);
  }

  // TODO: is this against a previous design choice? only direct "read" access to repos?
  // Should this actor only listen to AudioPlayer events? --> move song update to new actor?
  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataRepository _musicDataRepository;

  final HandlePlaybackEvent _handlePlaybackEvent;
  final SetCurrentSong _setCurrentSong;

  Song? _currentSong;
  bool _countSongPlayback = false;

  Future<void> _handleCurrentSong(Song song) async {
    _currentSong = song;
    return _setCurrentSong(song);
  }

  Future<void> _handlePosition(Duration? position, Song? song) async {
    if (song == null || position == null) {
      return;
    }

    final int pos = position.inMilliseconds;

    if (pos < song.duration * 0.05) {
      _countSongPlayback = true;
    } else if (pos > song.duration * 0.95 && _countSongPlayback) {
      _countSongPlayback = false;
      await _musicDataRepository.incrementPlayCount(song);
      _musicDataRepository.resetSkipCount(song);
    }
  }

  void _handleSongUpdate(Map<String, Song> songs) {
    _audioPlayerRepository.updateSongs(songs);
  }
}
