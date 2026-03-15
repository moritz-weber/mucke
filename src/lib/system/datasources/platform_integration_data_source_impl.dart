import 'package:audio_service/audio_service.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/playback_event.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../../domain/repositories/platform_integration_repository.dart';
import '../models/playback_event_model.dart';
import '../models/song_model.dart';
import 'platform_integration_data_source.dart';

const favs = [
  MediaControl(
    androidIcon: 'drawable/favorite_0',
    label: 'Like',
    action: MediaAction.rewind,
  ),
  MediaControl(
    androidIcon: 'drawable/favorite_1',
    label: 'Like',
    action: MediaAction.rewind,
  ),
  MediaControl(
    androidIcon: 'drawable/favorite_2',
    label: 'Like',
    action: MediaAction.rewind,
  ),
  MediaControl(
    androidIcon: 'drawable/favorite_3',
    label: 'Like',
    action: MediaAction.rewind,
  ),
];

const playCtrl = MediaControl(
  androidIcon: 'drawable/play',
  label: 'Play',
  action: MediaAction.play,
);
const pauseCtrl = MediaControl(
  androidIcon: 'drawable/pause',
  label: 'Pause',
  action: MediaAction.pause,
);
const nextCtrl = MediaControl(
  androidIcon: 'drawable/skip_next',
  label: 'Next',
  action: MediaAction.skipToNext,
);
const prevCtrl = MediaControl(
  androidIcon: 'drawable/skip_prev',
  label: 'Previous',
  action: MediaAction.skipToPrevious,
);

class PlatformIntegrationDataSourceImpl extends BaseAudioHandler
    implements PlatformIntegrationDataSource {
  PlatformIntegrationDataSourceImpl(this._musicDataInfoRepository);

  static const String _rootMediaId = 'root';
  static const String _allSongsMediaId = 'all_songs';
  static const String _playlistsMediaId = 'playlists';
  static const String _playlistPrefix = 'playlist:';
  static const String _playlistSongPrefix = 'playlist_song:';

  final MusicDataInfoRepository _musicDataInfoRepository;

  static final _log = Logger('PlatformIntegrationDataSourceImpl');

  final BehaviorSubject<PlatformIntegrationEvent> _eventSubject = BehaviorSubject();

  // BaseAudioHandler interface

  @override
  Future<void> play() async {
    _log.fine('play');
    _eventSubject.add(PlatformIntegrationEvent(type: PlatformIntegrationEventType.play));
  }

  @override
  Future<void> pause() async {
    _log.fine('pause');
    _eventSubject.add(PlatformIntegrationEvent(type: PlatformIntegrationEventType.pause));
  }

  @override
  Future<void> skipToNext() async {
    _log.fine('skipToNext');
    _eventSubject.add(PlatformIntegrationEvent(type: PlatformIntegrationEventType.skipNext));
  }

  @override
  Future<void> skipToPrevious() async {
    _log.fine('skipToPrevious');
    _eventSubject.add(PlatformIntegrationEvent(type: PlatformIntegrationEventType.skipPrevious));
  }

  @override
  Future<List<MediaItem>> getChildren(String parentMediaId, [Map<String, dynamic>? options]) async {
    if (parentMediaId == _allSongsMediaId) {
      final songs = await _musicDataInfoRepository.songsStream.first;
      return songs
          .take(10)
          .map((song) => (song as SongModel).toMediaItem())
          .toList();
    }

    if (parentMediaId == _playlistsMediaId) {
      final playlists = await _musicDataInfoRepository.smartListsStream.first;
      print('playlists: $playlists');
      return playlists
          .map(
            (playlist) => MediaItem(
              id: '$_playlistPrefix${playlist.id}',
              title: playlist.name,
              playable: true,
            ),
          )
          .toList();
    }

    if (parentMediaId.startsWith(_playlistPrefix)) {
      final playlistId = int.tryParse(parentMediaId.substring(_playlistPrefix.length));
      if (playlistId == null) return const [];

      final playlist = await _musicDataInfoRepository.getSmartListStream(playlistId).first;
      final songs = await _musicDataInfoRepository.getSmartListSongStream(playlist).first;

      return songs
          .map((song) {
            final songModel = song as SongModel;
            return songModel.toMediaItem();
          })
          .toList();
    }

    return const [
      MediaItem(
        id: _playlistsMediaId,
        title: 'Playlists',
        playable: false,
      ),
      MediaItem(
        id: _allSongsMediaId,
        title: 'All songs',
        playable: false,
      ),
    ];
  }

  @override
  Future<MediaItem?> getMediaItem(String mediaId) async {
    if (mediaId == _allSongsMediaId) {
      return const MediaItem(
        id: _allSongsMediaId,
        title: 'All songs',
        playable: false,
      );
    }

    if (mediaId == _rootMediaId) {
      return const MediaItem(
        id: _rootMediaId,
        title: 'mucke',
        playable: false,
      );
    }

    if (mediaId == _playlistsMediaId) {
      return const MediaItem(
        id: _playlistsMediaId,
        title: 'Playlists',
        playable: false,
      );
    }

    if (mediaId.startsWith(_playlistPrefix)) {
      final playlistId = int.tryParse(mediaId.substring(_playlistPrefix.length));
      if (playlistId == null) return null;

      try {
        final playlist = await _musicDataInfoRepository.getPlaylistStream(playlistId).first;
        return MediaItem(
          id: mediaId,
          title: playlist.name,
          playable: false,
        );
      } catch (_) {
        return null;
      }
    }

    if (mediaId.startsWith(_playlistSongPrefix)) {
      final metadata = _parsePlaylistSongMediaId(mediaId);
      if (metadata == null) return null;

      try {
        final song = await _musicDataInfoRepository.getSongByPath(metadata.songPath);
        return (song as SongModel).toMediaItem();
      } catch (_) {
        return null;
      }
    }

    try {
      final song = await _musicDataInfoRepository.getSongByPath(mediaId);
      return (song as SongModel).toMediaItem();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> playFromMediaId(String mediaId, [Map<String, dynamic>? extras]) async {
    if (mediaId == _allSongsMediaId || mediaId == _playlistsMediaId || mediaId == _rootMediaId) {
      return;
    }

    final playlistSongMetadata = _parsePlaylistSongMediaId(mediaId);
    if (playlistSongMetadata != null) {
      _eventSubject.add(PlatformIntegrationEvent(
        type: PlatformIntegrationEventType.playMediaId,
        payload: {
          'mediaId': playlistSongMetadata.songPath,
          'playlistId': playlistSongMetadata.playlistId,
        },
      ));
      return;
    }

    _eventSubject.add(PlatformIntegrationEvent(
      type: PlatformIntegrationEventType.playMediaId,
      payload: {'mediaId': mediaId},
    ));
  }

  _PlaylistSongMediaId? _parsePlaylistSongMediaId(String mediaId) {
    if (!mediaId.startsWith(_playlistSongPrefix)) return null;

    final idPayload = mediaId.substring(_playlistSongPrefix.length);
    final separator = idPayload.indexOf(':');
    if (separator <= 0) return null;

    final playlistIdString = idPayload.substring(0, separator);
    final encodedPath = idPayload.substring(separator + 1);

    final playlistId = int.tryParse(playlistIdString);
    if (playlistId == null || encodedPath.isEmpty) return null;

    return _PlaylistSongMediaId(
      playlistId: playlistId,
      songPath: Uri.decodeComponent(encodedPath),
    );
  }

  @override
  Future<void> seek(Duration position) async {
    _log.fine('skipToPrevious');
    _eventSubject.add(PlatformIntegrationEvent(
      type: PlatformIntegrationEventType.seek,
      payload: {'position': position},
    ));
  }

  @override
  Future<void> rewind() async {
    _log.fine('rewind -> like');
    _eventSubject.add(PlatformIntegrationEvent(
        type: PlatformIntegrationEventType.like, payload: {'path': mediaItem.value?.id}));
  }

  @override
  Future<void> click([MediaButton button = MediaButton.media]) async {
    _log.fine(button.toString());

    switch (button) {
      case MediaButton.media:
        if (!playbackState.value.playing) {
          await play();
        } else {
          await pause();
        }
        break;
      case MediaButton.next:
        await skipToNext();
        break;
      case MediaButton.previous:
        await skipToPrevious();
        break;
    }
  }

  // PlatformIntegrationDataSource interface

  @override
  Stream<PlatformIntegrationEvent> get eventStream => _eventSubject.stream;

  @override
  Future<void> handlePlaybackEvent(PlaybackEventModel pe) async {
    final mi = mediaItem.value;
    final int likeCount = mi == null ? 0 : mi.extras!['likeCount'] as int;

    if (pe.processingState == ProcessingState.ready) {
      final timeDelta = DateTime.now().difference(pe.updateTime);
      if (pe.playing) {
        playbackState.add(playbackState.value.copyWith(
          controls: [favs[likeCount], prevCtrl, pauseCtrl, nextCtrl],
          systemActions: const {
            MediaAction.seek,
          },
          playing: true,
          processingState: AudioProcessingState.ready,
          updatePosition: pe.updatePosition + timeDelta,
          androidCompactActionIndices: [0, 2, 3],
        ));
      } else {
        playbackState.add(playbackState.value.copyWith(
          controls: [favs[likeCount], prevCtrl, playCtrl, nextCtrl],
          systemActions: const {
            MediaAction.seek,
          },
          processingState: AudioProcessingState.ready,
          updatePosition: pe.updatePosition + timeDelta,
          playing: false,
          androidCompactActionIndices: [0, 2, 3],
        ));
      }
    } else if (pe.processingState == ProcessingState.completed) {
      final timeDelta = DateTime.now().difference(pe.updateTime);
      playbackState.add(playbackState.value.copyWith(
        controls: [favs[likeCount], prevCtrl, playCtrl, nextCtrl],
        systemActions: const {
          MediaAction.seek,
        },
        processingState: AudioProcessingState.ready,
        updatePosition: pe.updatePosition + timeDelta,
        playing: false,
        androidCompactActionIndices: [0, 2, 3],
      ));
    } else if (pe.processingState == ProcessingState.none) {
      stop();
    } else {
      _log.fine(pe.processingState.toString());
    }
  }

  @override
  Future<void> setCurrentSong(SongModel? songModel) async {
    final mediaItemValue = songModel == null
        ? null
        : songModel.toMediaItem();
    mediaItem.add(mediaItemValue);

    if (songModel != null) {
      final state = playbackState.value;
      final controls = state.controls.sublist(1);
      final timeDelta = state.playing ? DateTime.now().difference(state.updateTime) : Duration.zero;

      playbackState.add(playbackState.value.copyWith(
        controls: [favs[songModel.likeCount]] + controls,
        updatePosition: state.updatePosition + timeDelta,
      ));
    }
  }
}

class _PlaylistSongMediaId {
  const _PlaylistSongMediaId({required this.playlistId, required this.songPath});

  final int playlistId;
  final String songPath;
}
