import '../entities/song.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';
import '../repositories/platform_integration_repository.dart';

class AudioPlayerActor {
  AudioPlayerActor(
    this._audioPlayerRepository,
    this._musicDataRepository,
    this._platformIntegrationRepository,
  ) {
    _audioPlayerRepository.currentSongStream.listen(_handleCurrentSong);
    _audioPlayerRepository.playbackEventStream
        .listen(_platformIntegrationRepository.handlePlaybackEvent);
    _audioPlayerRepository.positionStream
        .listen((duration) => _handlePosition(duration, _currentSong));
    // TODO: uncomment when implemented
    // _audioPlayerRepository.queueStream.listen(_platformIntegrationRepository.setQueue);

    // TODO: this doesn't quite fit the design: listening to audioplayer events
    _musicDataRepository.songUpdateStream.listen(_handleSongUpdate);
  }

  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataRepository _musicDataRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;

  Song? _currentSong;
  bool _countSongPlayback = false;

  Future<void> _handleCurrentSong(Song song) async {
    _currentSong = song;
    return _platformIntegrationRepository.setCurrentSong(song);
  }

  Future<void> _handlePosition(Duration? position, Song? song) async {
    if (song == null || position == null) {
      return;
    }

    if (position < song.duration * 0.05) {
      _countSongPlayback = true;
    } else if (position > song.duration * 0.95 && _countSongPlayback) {
      _countSongPlayback = false;
      await _musicDataRepository.incrementPlayCount(song);
      _musicDataRepository.resetSkipCount(song);
    }
  }

  void _handleSongUpdate(Map<String, Song> songs) {
    _audioPlayerRepository.updateSongs(songs);
  }
}
