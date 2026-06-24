import 'package:audio_service/audio_service.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

import '../../constants.dart';
import '../../domain/entities/playable.dart';
import '../../domain/entities/playback_event.dart';
import '../../domain/entities/shuffle_mode.dart';
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
    androidIcon: 'drawable/favorite_1_3',
    label: 'Like',
    action: MediaAction.rewind,
  ),
  MediaControl(
    androidIcon: 'drawable/favorite_2_3',
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
  static const String _smartListsMediaId = 'smart_lists';
  static const String _smartListPrefix = 'smart_list:';
  static const String _smartListSongPrefix = 'smart_list_song:';
  static const String _smartListPlayPrefix = 'smart_list_play:';
  static const String _playlistPrefix = 'playlist:';
  static const String _playlistSongPrefix = 'playlist_song:';

  final MusicDataInfoRepository _musicDataInfoRepository;

  static final _log = Logger('PlatformIntegrationDataSourceImpl');

  final BehaviorSubject<PlatformIntegrationEvent> _eventSubject = BehaviorSubject();

  static Uri _shuffleModeArtUri(ShuffleMode? shuffleMode) {
    switch (shuffleMode) {
      case ShuffleMode.none:
        return Uri.parse('android.resource://$PACKAGE_NAME/drawable/shuffle_none');
      case ShuffleMode.plus:
        return Uri.parse('android.resource://$PACKAGE_NAME/drawable/shuffle_heart');
      case ShuffleMode.standard:
        return Uri.parse('android.resource://$PACKAGE_NAME/drawable/shuffle');
      default:
        return Uri.parse('android.resource://$PACKAGE_NAME/drawable/play_arrow');
    }
  }

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
      return songs.take(10).map((song) => (song as SongModel).toMediaItem()).toList();
    }

    if (parentMediaId == _smartListsMediaId) {
      final smartLists = await _musicDataInfoRepository.smartListsStream.first;
      final playlists = await _musicDataInfoRepository.playlistsStream.first;

      final smartListItems = smartLists.map(
        (smartList) => MediaItem(
          id: '$_smartListPrefix${smartList.id}',
          title: smartList.name,
          playable: false,
        ),
      );

      final playlistItems = playlists.map(
        (playlist) => MediaItem(
          id: '$_playlistPrefix${playlist.id}',
          title: playlist.name,
          playable: false,
        ),
      );

      return [...smartListItems, ...playlistItems]..sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
    }

    if (parentMediaId.startsWith(_smartListPrefix)) {
      final smartListId = int.tryParse(parentMediaId.substring(_smartListPrefix.length));
      if (smartListId == null) return const [];

      final smartList = await _musicDataInfoRepository.getSmartListStream(smartListId).first;
      final songs = await _musicDataInfoRepository.getSmartListSongStream(smartList).first;

      final playAction = MediaItem(
        id: '$_smartListPlayPrefix$smartListId',
        title: '${smartList.name} ▶',
        playable: true,
        duration: const Duration(milliseconds: 1),
        artUri: _shuffleModeArtUri(smartList.shuffleMode),
      );

      final songItems = songs.map((song) {
        final songModel = song as SongModel;
        return songModel.toMediaItem().copyWith(
              id: '$_smartListSongPrefix$smartListId:${Uri.encodeComponent(songModel.path)}',
            );
      }).toList();

      return [playAction, ...songItems];
    }

    if (parentMediaId.startsWith(_playlistPrefix)) {
      final playlistId = int.tryParse(parentMediaId.substring(_playlistPrefix.length));
      if (playlistId == null) return const [];

      final playlist = await _musicDataInfoRepository.getPlaylistStream(playlistId).first;
      final songs = await _musicDataInfoRepository.getPlaylistSongStream(playlist).first;

      return songs.map((song) {
        final songModel = song as SongModel;
        return songModel.toMediaItem().copyWith(
              id: '$_playlistSongPrefix$playlistId:${Uri.encodeComponent(songModel.path)}',
            );
      }).toList();
    }

    return const [
      MediaItem(
        id: _smartListsMediaId,
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

    if (mediaId == _smartListsMediaId) {
      return const MediaItem(
        id: _smartListsMediaId,
        title: 'Playlists',
        playable: false,
      );
    }

    if (mediaId.startsWith(_smartListPlayPrefix)) {
      final smartListId = int.tryParse(mediaId.substring(_smartListPlayPrefix.length));
      if (smartListId == null) return null;

      try {
        final smartList = await _musicDataInfoRepository.getSmartListStream(smartListId).first;
        return MediaItem(
          id: mediaId,
          title: '${smartList.name} ▶',
          duration: const Duration(milliseconds: 1),
          playable: true,
          artUri: _shuffleModeArtUri(smartList.shuffleMode),
        );
      } catch (_) {
        return null;
      }
    }

    if (mediaId.startsWith(_smartListSongPrefix)) {
      final metadata = _parseSmartListSongMediaId(mediaId);
      if (metadata == null) return null;

      try {
        final song = await _musicDataInfoRepository.getSongByPath(metadata.songPath);
        return (song as SongModel).toMediaItem().copyWith(id: mediaId);
      } catch (_) {
        return null;
      }
    }

    if (mediaId.startsWith(_smartListPrefix)) {
      final smartListId = int.tryParse(mediaId.substring(_smartListPrefix.length));
      if (smartListId == null) return null;

      try {
        final smartList = await _musicDataInfoRepository.getSmartListStream(smartListId).first;
        return MediaItem(
          id: mediaId,
          title: smartList.name,
          playable: false,
        );
      } catch (_) {
        return null;
      }
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

    if (mediaId.startsWith(_smartListSongPrefix)) {
      final metadata = _parseSmartListSongMediaId(mediaId);
      if (metadata == null) return null;

      try {
        final song = await _musicDataInfoRepository.getSongByPath(metadata.songPath);
        return (song as SongModel).toMediaItem().copyWith(id: mediaId);
      } catch (_) {
        return null;
      }
    }

    if (mediaId.startsWith(_playlistSongPrefix)) {
      final metadata = _parsePlaylistSongMediaId(mediaId);
      if (metadata == null) return null;

      try {
        final song = await _musicDataInfoRepository.getSongByPath(metadata.songPath);
        return (song as SongModel).toMediaItem().copyWith(id: mediaId);
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
    if (mediaId == _allSongsMediaId || mediaId == _smartListsMediaId || mediaId == _rootMediaId) {
      return;
    }

    if (mediaId.startsWith(_smartListPlayPrefix)) {
      final smartListId = int.tryParse(mediaId.substring(_smartListPlayPrefix.length));
      if (smartListId == null) return;

      _eventSubject.add(PlatformIntegrationEvent(
        type: PlatformIntegrationEventType.playSmartList,
        payload: {'smartListId': smartListId},
      ));
      return;
    }

    final smartListSongMetadata = _parseSmartListSongMediaId(mediaId);
    if (smartListSongMetadata != null) {
      _eventSubject.add(PlatformIntegrationEvent(
        type: PlatformIntegrationEventType.playMediaId,
        payload: {
          'mediaId': smartListSongMetadata.songPath,
          'playableId': smartListSongMetadata.smartListId,
          'playableType': PlayableType.smartlist.toString(),
        },
      ));
      return;
    }

    final playlistSongMetadata = _parsePlaylistSongMediaId(mediaId);
    if (playlistSongMetadata != null) {
      _eventSubject.add(PlatformIntegrationEvent(
        type: PlatformIntegrationEventType.playMediaId,
        payload: {
          'mediaId': playlistSongMetadata.songPath,
          'playableId': playlistSongMetadata.playlistId,
          'playableType': PlayableType.playlist.toString(),
        },
      ));
      return;
    }

    _eventSubject.add(PlatformIntegrationEvent(
      type: PlatformIntegrationEventType.playMediaId,
      payload: {'mediaId': mediaId, 'playableType': PlayableType.all.toString()},
    ));
  }

  _SmartListSongMediaId? _parseSmartListSongMediaId(String mediaId) {
    if (!mediaId.startsWith(_smartListSongPrefix)) return null;

    final idPayload = mediaId.substring(_smartListSongPrefix.length);
    final separator = idPayload.indexOf(':');
    if (separator <= 0) return null;

    final playlistIdString = idPayload.substring(0, separator);
    final encodedPath = idPayload.substring(separator + 1);

    final playlistId = int.tryParse(playlistIdString);
    if (playlistId == null || encodedPath.isEmpty) return null;

    return _SmartListSongMediaId(
      smartListId: playlistId,
      songPath: Uri.decodeComponent(encodedPath),
    );
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
    final mediaItemValue = songModel == null ? null : songModel.toMediaItem();
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

class _SmartListSongMediaId {
  const _SmartListSongMediaId({required this.smartListId, required this.songPath});

  final int smartListId;
  final String songPath;
}

class _PlaylistSongMediaId {
  const _PlaylistSongMediaId({required this.playlistId, required this.songPath});

  final int playlistId;
  final String songPath;
}
