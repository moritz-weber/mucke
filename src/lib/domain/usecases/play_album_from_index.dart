import 'package:mucke/system/datasources/settings_data_source.dart';

import '../entities/album.dart';
import '../entities/shuffle_mode.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';
import 'play_songs.dart';

class PlayAlbumFromIndex {
  PlayAlbumFromIndex(
    this._audioPlayerRepository,
    this._musicDataRepository,
    this._playSongs,
    this._settingsDataSource,
  );

  final PlaySongs _playSongs;

  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataRepository _musicDataRepository;
  final SettingsDataSource _settingsDataSource;

  Future<void> call(Album album, int initialIndex) async {
    final songs = await _musicDataRepository.getAlbumSongStream(album).first;

    final bool playInOrder = await _settingsDataSource.playAlbumsInOrderStream.first;
    if (playInOrder)
      await _audioPlayerRepository.setShuffleMode(ShuffleMode.none, updateQueue: false);

    _playSongs(songs: songs, initialIndex: initialIndex, playable: album, keepInitialIndex: false);
  }
}
