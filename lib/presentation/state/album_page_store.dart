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

  @observable
  bool isMultiSelectEnabled = false;

  @observable
  ObservableList<bool> isSelected = ObservableList();

  @computed
  bool get isAllSelected => isSelected.every((e) => e);

  @action
  void toggleMultiSelect() {
    if (!isMultiSelectEnabled) {
      isSelected = List.generate(albumSongStream.value?.length ?? 0, (index) => false).asObservable();
    }
    isMultiSelectEnabled = !isMultiSelectEnabled;
  }

  @action
  void setSelected(bool selected, int index) {
    isSelected[index] = selected;
  }

  @action
  void selectAll() {
    isSelected = List.generate(albumSongStream.value?.length ?? 0, (index) => true).asObservable();
  }

  @action
  void deselectAll() {
    isSelected = List.generate(albumSongStream.value?.length ?? 0, (index) => false).asObservable();
  }

  void dispose() {}
}
