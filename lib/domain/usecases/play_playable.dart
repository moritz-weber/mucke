import 'dart:math';

import '../entities/album.dart';
import '../entities/artist.dart';
import '../entities/playable.dart';
import '../entities/playlist.dart';
import '../entities/shuffle_mode.dart';
import '../entities/smart_list.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';
import 'play_album.dart';
import 'play_artist.dart';
import 'play_playlist.dart';
import 'play_smart_list.dart';
import 'play_songs.dart';

class PlayPlayable {
  PlayPlayable(
    this._audioPlayerRepository,
    this._musicDataRepository,
    this._playSongs,
    this._playAlbum,
    this._playArtist,
    this._playPlaylist,
    this._playSmartList,
  );

  final PlaySongs _playSongs;
  final PlayAlbum _playAlbum;
  final PlayArtist _playArtist;
  final PlayPlaylist _playPlaylist;
  final PlaySmartList _playSmartList;

  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataRepository _musicDataRepository;

  Future<void> call(Playable playable, ShuffleMode? shuffleMode) async {
    switch (playable.type) {
      case PlayableType.all:
        break;
      case PlayableType.album:
        _playAlbum(playable as Album);
        break;
      case PlayableType.artist:
        _playArtist(playable as Artist, shuffleMode);
        break;
      case PlayableType.playlist:
        _playPlaylist(playable as Playlist);
        break;
      case PlayableType.smartlist:
        _playSmartList(playable as SmartList);
        break;
      case PlayableType.search:
        final songs = await _musicDataRepository.searchSongs((playable as SearchQuery).query);

        if (shuffleMode != null) {
          await _audioPlayerRepository.setShuffleMode(shuffleMode, updateQueue: false);
        }

        final activeShuffleMode = _audioPlayerRepository.shuffleModeStream.value;
        int index = 0;
        if (activeShuffleMode != ShuffleMode.none) {
          final rng = Random();
          index = rng.nextInt(songs.length);
        }

        _playSongs(songs: songs, initialIndex: index, keepInitialIndex: true, playable: playable);
        break;
    }
  }
}
