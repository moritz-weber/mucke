import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:logging/logging.dart';

import '../../domain/entities/shuffle_mode.dart';
import '../datasources/music_data_source_contract.dart';
import '../datasources/player_state_data_source.dart';
import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/song_model.dart';

const String SET_CURRENT_SONG = 'SET_CURRENT_SONG';
const String PLAY = 'PLAY';
const String PAUSE = 'PAUSE';

class MyAudioHandler extends BaseAudioHandler {
  MyAudioHandler(this._musicDataSource, this._playerStateDataSource) {
    // _audioPlayer.queueStream.skip(1).listen((event) {
    //   _handleSetQueue(event);
    // });

    // _audioPlayer.playbackEventStream.listen((event) => _handlePlaybackEvent(event));

    // _audioPlayer.shuffleModeStream.skip(1).listen((shuffleMode) {
    //   _playerStateDataSource.setShuffleMode(shuffleMode);
    // });

    // _audioPlayer.loopModeStream.skip(1).listen((event) {
    //   _playerStateDataSource.setLoopMode(event);
    // });

    // _audioPlayer.positionStream.listen((event) {
    //   _handlePosition(event, _audioPlayer.currentSongStream.value);
    // });

    // _initAudioPlayer();
  }

  // Future<void> _initAudioPlayer() async {
  //   if (_playerStateDataSource.loopModeStream != null) {
  //     _audioPlayer.setLoopMode(await _playerStateDataSource.loopModeStream.first);
  //   }

  //   if (_playerStateDataSource.shuffleModeStream != null) {
  //     _audioPlayer.setShuffleMode(await _playerStateDataSource.shuffleModeStream.first, false);
  //   }

  //   if (_playerStateDataSource.queueStream != null &&
  //       _playerStateDataSource.currentIndexStream != null) {
  //     _audioPlayer.loadQueue(
  //       queue: await _playerStateDataSource.queueStream.first,
  //       initialIndex: await _playerStateDataSource.currentIndexStream.first,
  //     );
  //   }
  // }

  // final AudioPlayerDataSource _audioPlayer;
  final MusicDataSource _musicDataSource;
  final PlayerStateDataSource _playerStateDataSource;

  static final _log = Logger('AudioHandler');

  bool _countSongPlayback = true;

  @override
  Future<void> stop() async {
    // await _audioPlayer.stop();
    // await _audioPlayer.dispose();
    await super.stop();
  }

  @override
  Future<void> skipToNext() async {
    // _audioPlayer.seekToNext().then((value) {
    //   if (value) {
    //     _musicDataSource.incrementSkipCount(_audioPlayer.currentSongStream.value);
    //   }
    // });
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    // _audioPlayer.addToQueue(SongModel.fromMediaItem(mediaItem));
  }

  @override
  Future<void> removeQueueItemAt(int index) async {
    // _audioPlayer.removeQueueIndex(index);
  }

  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    // _audioPlayer.moveQueueItem(oldIndex, newIndex);
  }

  Future<void> setIndex(int index) async {
    // _audioPlayer.setIndex(index);
  }

  Future<void> playAlbum(AlbumModel album) async {
    // _audioPlayer.setShuffleMode(ShuffleMode.none, false);
    final List<SongModel> songs = await _musicDataSource.getAlbumSongStream(album).first;

    // _audioPlayer.playSongList(songs, 0);
  }

  Future<void> playArtist(ArtistModel artist, ShuffleMode shuffleMode) async {
    // _audioPlayer.setShuffleMode(shuffleMode, false);
    final List<SongModel> songs = await _musicDataSource.getArtistSongStream(artist).first;

    final rng = Random();
    final index = rng.nextInt(songs.length);

    // _audioPlayer.playSongList(songs, index);
  }

  // void _handleSetQueue(List<QueueItemModel> queueItems) {
  //   _playerStateDataSource.setQueue(queueItems);

  //   final mediaItems = queueItems.map((e) => e.song.toMediaItem()).toList();
  //   queue.add(mediaItems);
  // }

  // void _handlePosition(Duration position, SongModel song) {
  //   if (song == null || position == null) return;

  //   final int pos = position.inMilliseconds;

  //   if (pos < song.duration * 0.05) {
  //     _countSongPlayback = true;
  //   } else if (pos > song.duration * 0.95 && _countSongPlayback) {
  //     _countSongPlayback = false;
  //     _musicDataSource.incrementPlayCount(song);
  //   }
  // }
}
