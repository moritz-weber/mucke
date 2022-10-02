import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';
import 'selection_store.dart';

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
  ) {
    _disposers = [
      autorun((_) => selection.setItemCount(albumSongStream.value?.length ?? 0)),
    ];
  }

  final Album album;

  final MusicDataInfoRepository _musicDataInfoRepository;

  final selection = SelectionStore();
  late List<ReactionDisposer> _disposers;

  @observable
  late ObservableStream<List<Song>> albumSongStream =
      _musicDataInfoRepository.getAlbumSongStream(album).asObservable(initialValue: []);


  void dispose() {
    for (final d in _disposers) {
      d();
    }
    selection.dispose();
  }
}
