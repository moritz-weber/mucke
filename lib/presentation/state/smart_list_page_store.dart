import 'package:mobx/mobx.dart';

import '../../domain/entities/smart_list.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../../domain/repositories/settings_repository.dart';

part 'smart_list_page_store.g.dart';

class SmartListPageStore extends _SmartListPageStore with _$SmartListPageStore {
  SmartListPageStore({
    required SmartList smartList,
    required MusicDataInfoRepository musicDataInfoRepository,
    required SettingsRepository settingsRepository,
  }) : super(smartList, musicDataInfoRepository, settingsRepository);
}

abstract class _SmartListPageStore with Store {
  _SmartListPageStore(this._smartList, this._musicDataInfoRepository, this._settingsRepository);

  final MusicDataInfoRepository _musicDataInfoRepository;
  final SettingsRepository _settingsRepository;

  final SmartList _smartList;
  late List<ReactionDisposer> _disposers;

  @observable
  late ObservableStream<SmartList> smartListStream =
      _settingsRepository.getSmartListStream(_smartList.id!).asObservable();

  // TODO: how would I transform the stream from db to a more easily usable value here?
  // @computed
  // SmartList? get smartList => smartListStream.value;

  @observable
  late ObservableStream<List<Song>> smartListSongStream =
      _musicDataInfoRepository.getSmartListSongStream(_smartList).asObservable(initialValue: []);

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
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
