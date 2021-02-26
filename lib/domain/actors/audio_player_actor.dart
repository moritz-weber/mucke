import '../entities/song.dart';
import '../repositories/audio_player_repository.dart';
import '../usecases/handle_playback_state.dart';
import '../usecases/set_current_song.dart';

class AudioPlayerActor {
  AudioPlayerActor(this._audioPlayerInfoRepository, this._handlePlaybackEvent, this._setCurrentSong) {
    _audioPlayerInfoRepository.currentSongStream.listen(_handleCurrentSong);
    _audioPlayerInfoRepository.playbackEventStream.listen(_handlePlaybackEvent);
  }

  final AudioPlayerInfoRepository _audioPlayerInfoRepository;

  final HandlePlaybackEvent _handlePlaybackEvent;
  final SetCurrentSong _setCurrentSong;

  void _handleCurrentSong(Song song) => _setCurrentSong(song);
}