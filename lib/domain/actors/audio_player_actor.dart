import '../entities/song.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';
import '../usecases/handle_playback_state.dart';
import '../usecases/set_current_song.dart';

class AudioPlayerActor {
  AudioPlayerActor(this._audioPlayerRepository, this._musicDataInfoRepository, this._handlePlaybackEvent, this._setCurrentSong) {
    _audioPlayerRepository.currentSongStream.listen(_handleCurrentSong);
    _audioPlayerRepository.playbackEventStream.listen(_handlePlaybackEvent);

    _musicDataInfoRepository.songUpdateStream.listen(_handleSongUpdate);
  }

  // TODO: is this against a previous design choice? only direct "read" access to repos?
  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataInfoRepository _musicDataInfoRepository;

  final HandlePlaybackEvent _handlePlaybackEvent;
  final SetCurrentSong _setCurrentSong;

  void _handleCurrentSong(Song song) => _setCurrentSong(song);

  void _handleSongUpdate(Map<String, Song> songs) {
    _audioPlayerRepository.updateSongs(songs);
  }
}