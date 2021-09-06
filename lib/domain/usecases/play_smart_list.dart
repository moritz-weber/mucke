import '../entities/smart_list.dart';
import '../repositories/music_data_repository.dart';
import 'play_songs.dart';

class PlaySmartList {
  PlaySmartList(
    this._musicDataRepository,
    this._playSongs,
  );

  final PlaySongs _playSongs;

  final MusicDataRepository _musicDataRepository;

  Future<void> call(SmartList smartList) async {
      final songs = await _musicDataRepository.getSmartListSongStream(smartList).first;

      _playSongs(songs: songs, initialIndex: 0);
  }
}
