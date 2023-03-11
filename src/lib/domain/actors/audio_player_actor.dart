import '../entities/song.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';
import '../repositories/platform_integration_repository.dart';
import '../repositories/settings_repository.dart';

class AudioPlayerActor {
  AudioPlayerActor(
    this._audioPlayerRepository,
    this._musicDataRepository,
    this._platformIntegrationRepository,
    this._settingsInfoRepository,
  ) {
    _audioPlayerRepository.currentSongStream.listen(_handleCurrentSong);
    _audioPlayerRepository.playbackEventStream
        .listen(_platformIntegrationRepository.handlePlaybackEvent);
    _audioPlayerRepository.positionStream
        .listen((duration) => _handlePosition(duration, _currentSong));

    _listenedPercentage = _settingsInfoRepository.listenedPercentageStream.valueOrNull ?? 50;
    _settingsInfoRepository.listenedPercentageStream.listen((event) => _listenedPercentage = event);
  }

  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataRepository _musicDataRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;
  final SettingsInfoRepository _settingsInfoRepository;

  Song? _currentSong;
  bool _countSongPlayback = false;
  late int _listenedPercentage;

  Future<void> _handleCurrentSong(Song? song) async {
    _currentSong = song;
    return _platformIntegrationRepository.setCurrentSong(song);
  }

  Future<void> _handlePosition(Duration? position, Song? song) async {
    if (song == null || position == null) {
      return;
    }

    if (position < song.duration * 0.01) {
      _countSongPlayback = true;
    } else if (position > song.duration * (_listenedPercentage / 100) && _countSongPlayback) {
      _countSongPlayback = false;
      await _musicDataRepository.incrementPlayCount(song);
    }
  }
}
