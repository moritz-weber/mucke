import 'package:mobx/mobx.dart';

import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';

part 'song_store.g.dart';

class SongStore extends _SongStore with _$SongStore {
  SongStore({
    required MusicDataInfoRepository musicDataInfoRepository,
    required Song song,
  }) : super(musicDataInfoRepository, song);
}

abstract class _SongStore with Store {
  _SongStore(
    this._musicDataInfoRepository,
    this.song,
  );

  final Song song;

  final MusicDataInfoRepository _musicDataInfoRepository;

  @observable
  late ObservableStream<Song> songStream =
      _musicDataInfoRepository.getSongStream(song.path).asObservable(initialValue: song);

  void dispose() {}
}
