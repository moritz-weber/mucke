import 'package:mobx/mobx.dart';

import '../../domain/entities/smart_list.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';
import 'selection_store.dart';

part 'smart_list_page_store.g.dart';

class SmartListPageStore extends _SmartListPageStore with _$SmartListPageStore {
  SmartListPageStore({
    required SmartList smartList,
    required MusicDataInfoRepository musicDataInfoRepository,
  }) : super(smartList, musicDataInfoRepository);
}

abstract class _SmartListPageStore with Store {
  _SmartListPageStore(this._smartList, this._musicDataInfoRepository);

  final SmartList _smartList;

  final MusicDataInfoRepository _musicDataInfoRepository;

  final selection = SelectionStore();
  late List<ReactionDisposer> _disposers;

  @observable
  late ObservableStream<SmartList> smartListStream =
      _musicDataInfoRepository.getSmartListStream(_smartList.id).asObservable();

  // TODO: how would I transform the stream from db to a more easily usable value here?
  // @computed
  // SmartList? get smartList => smartListStream.value;

  @observable
  late ObservableStream<List<Song>> smartListSongStream =
      _musicDataInfoRepository.getSmartListSongStream(_smartList).asObservable(initialValue: []);

  // TODO: das is ja sau umständlich...
  @action
  void _updateSmartList(SmartList? smartList) {
    if (smartList != null) {
      smartListSongStream = _musicDataInfoRepository.getSmartListSongStream(smartList).asObservable(
        initialValue: [],
      );
    }
  }

  void setupReactions() {
    _disposers = [
      reaction((_) => smartListStream.value, _updateSmartList),
      autorun((_) => selection.setItemCount(smartListSongStream.value?.length ?? 0)),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
