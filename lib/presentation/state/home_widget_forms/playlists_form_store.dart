import 'package:mobx/mobx.dart';

import '../../../domain/entities/enums.dart';
import '../../../domain/entities/home_widgets/playlists.dart';
import '../../../domain/repositories/home_widget_repository.dart';

part 'playlists_form_store.g.dart';

class PlaylistsFormStore extends _PlaylistsFormStore with _$PlaylistsFormStore {
  PlaylistsFormStore({
    required HomeWidgetRepository homeWidgetRepository,
    required HomePlaylists homePlaylists,
  }) : super(homeWidgetRepository, homePlaylists);
}

abstract class _PlaylistsFormStore with Store {
  _PlaylistsFormStore(
    this._homeWidgetRepository,
    this._playlists,
  );

  final HomeWidgetRepository _homeWidgetRepository;

  final HomePlaylists _playlists;

  @observable
  late String title = _playlists.title;

  @observable
  late String maxEntries = _intToString(_playlists.maxEntries > 0 ? _playlists.maxEntries : 3);

  @observable
  late bool maxEntriesEnabled = _playlists.maxEntries > 0;

  @observable
  late HomePlaylistsOrder orderCriterion = _playlists.orderCriterion;

  @observable
  late OrderDirection orderDirection = _playlists.orderDirection;

  @observable
  late HomePlaylistsFilter filter = _playlists.filter;

  Future<void> save() async {
    int maxEntriesInt = int.parse(maxEntries);
    if (!maxEntriesEnabled || maxEntriesInt < 1) {
      maxEntriesInt = 0;
    }

    _homeWidgetRepository.updateHomeWidget(
      HomePlaylists(
        position: _playlists.position,
        title: title,
        maxEntries: maxEntriesInt,
        orderCriterion: orderCriterion,
        orderDirection: orderDirection,
        filter: filter,
      ),
    );
  }
}

String _intToString(int? number) {
  if (number == null) return '0';
  return number.toString();
}
