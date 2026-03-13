import '../entities/playable.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';
import '../repositories/platform_integration_repository.dart';
import '../usecases/play_songs.dart';
import '../usecases/seek_to_next.dart';

class PlatformIntegrationActor {
  PlatformIntegrationActor(
    this._platformIntegrationInfoRepository,
    this._seekToNext,
    this._audioPlayerRepository,
    this._musicDataRepository,
    this._playSongs,
  ) {
    _platformIntegrationInfoRepository.eventStream
        .listen((event) => _handlePlatformIntegrationEvent(event));
  }

  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataRepository _musicDataRepository;
  final PlatformIntegrationInfoRepository _platformIntegrationInfoRepository;
  final PlaySongs _playSongs;

  final SeekToNext _seekToNext;

  Future<void> _handlePlatformIntegrationEvent(PlatformIntegrationEvent event) async {
    switch (event.type) {
      case PlatformIntegrationEventType.play:
        _audioPlayerRepository.play();
        break;
      case PlatformIntegrationEventType.pause:
        _audioPlayerRepository.pause();
        break;
      case PlatformIntegrationEventType.skipNext:
        _seekToNext();
        break;
      case PlatformIntegrationEventType.skipPrevious:
        _audioPlayerRepository.seekToPrevious();
        break;
      case PlatformIntegrationEventType.stop:
        break;
      case PlatformIntegrationEventType.seek:
        _seekToPosition(event.payload!['position'] as Duration);
        break;
      case PlatformIntegrationEventType.playMediaId:
        final mediaId = event.payload?['mediaId'] as String?;
        final playlistId = event.payload?['playlistId'] as int?;
        if (mediaId != null) {
          await _playFromMediaId(mediaId, playlistId: playlistId);
        }
        break;
      case PlatformIntegrationEventType.like:
        final path = event.payload?['path'];
        if (path != null) {
          final song = await _musicDataRepository.getSongByPath(path as String);
          _musicDataRepository.incrementLikeCount(song);
        }
        break;
    }
  }

  Future<void> _seekToPosition(Duration position) async {
    final song = await _audioPlayerRepository.currentSongStream.first;

    if (song != null) {
      _audioPlayerRepository.seekToPosition(position.inMilliseconds / song.duration.inMilliseconds);
    }
  }

  Future<void> _playFromMediaId(String mediaId, {int? playlistId}) async {
    if (playlistId != null) {
      final playlist = await _musicDataRepository.getPlaylistStream(playlistId).first;
      final songs = await _musicDataRepository.getPlaylistSongStream(playlist).first;
      final index = songs.indexWhere((song) => song.path == mediaId);
      if (index < 0) return;

      await _playSongs(
        songs: songs,
        initialIndex: index,
        playable: playlist,
        keepInitialIndex: true,
      );
      return;
    }

    final songs = await _musicDataRepository.songsStream.first;
    final index = songs.indexWhere((song) => song.path == mediaId);
    if (index < 0) return;

    await _playSongs(
      songs: songs,
      initialIndex: index,
      playable: AllSongs(),
      keepInitialIndex: true,
    );
  }
}
