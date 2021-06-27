import 'package:mobx/mobx.dart';

import '../../domain/repositories/music_data_repository.dart';

part 'search_page_store.g.dart';

class SearchPageStore extends _SearchPageStore with _$SearchPageStore {
  SearchPageStore({
    required MusicDataInfoRepository musicDataInfoRepository,
  }) : super(musicDataInfoRepository);
}

abstract class _SearchPageStore with Store {
  _SearchPageStore(
    this._musicDataInfoRepository,
  );


  final MusicDataInfoRepository _musicDataInfoRepository;

  @observable
  ObservableList searchResults = [].asObservable();

  @action
  Future<void> search(String searchText) async {
    searchResults = (await _musicDataInfoRepository.search(searchText)).asObservable();
  }

  @action
  void reset() {
    searchResults = [].asObservable();
  }

  void dispose() {}
}
