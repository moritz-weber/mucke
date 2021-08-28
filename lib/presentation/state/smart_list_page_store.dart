import 'package:mobx/mobx.dart';

import '../../domain/entities/smart_list.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';

part 'smart_list_page_store.g.dart';

class SmartListPageStore extends _SmartListPageStore with _$SmartListPageStore  {
  SmartListPageStore({
    required MusicDataInfoRepository musicDataInfoRepository,
    required SmartList smartList,
  }) : super(musicDataInfoRepository, smartList);
}

abstract class _SmartListPageStore with Store {
  _SmartListPageStore(this._musicDataInfoRepository, this._smartList);

  final MusicDataInfoRepository _musicDataInfoRepository;

  final SmartList _smartList;

  @observable
  late ObservableStream<List<Song>> smartListSongStream =
      _musicDataInfoRepository.getSmartListSongStream(_smartList).asObservable(initialValue: []);

  void dispose() {}
}
