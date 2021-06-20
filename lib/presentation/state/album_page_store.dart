import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';

part 'album_page_store.g.dart';

class AlbumPageStore extends _AlbumPageStore with _$AlbumPageStore {
  AlbumPageStore({
    required MusicDataInfoRepository musicDataInfoRepository,
    required Album album,
  }) : super(musicDataInfoRepository, album);
}

abstract class _AlbumPageStore with Store {
  _AlbumPageStore(
    this._musicDataInfoRepository,
    this.album,
  );

  final Album album;

  final MusicDataInfoRepository _musicDataInfoRepository;

  @observable
  late ObservableStream<List<Song>> albumSongStream =
      _musicDataInfoRepository.getAlbumSongStream(album).asObservable(initialValue: []);

  void dispose() {}
}
