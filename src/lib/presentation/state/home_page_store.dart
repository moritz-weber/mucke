import 'package:mobx/mobx.dart';

import '../../domain/entities/home_widgets/album_of_day.dart';
import '../../domain/entities/home_widgets/artist_of_day.dart';
import '../../domain/entities/home_widgets/history.dart';
import '../../domain/entities/home_widgets/home_widget.dart';
import '../../domain/entities/home_widgets/playlists.dart';
import '../../domain/entities/home_widgets/shuffle_all.dart';
import '../../domain/repositories/home_widget_repository.dart';
import '../home_widgets/album_of_day_repr.dart';
import '../home_widgets/artist_of_day_repr.dart';
import '../home_widgets/history_repr.dart';
import '../home_widgets/home_widget_repr.dart';
import '../home_widgets/playlists_repr.dart';
import '../home_widgets/shuffle_all_repr.dart';

part 'home_page_store.g.dart';

class HomePageStore extends _HomePageStore with _$HomePageStore {
  HomePageStore({
    required HomeWidgetRepository homeWidgetRepository,
  }) : super(homeWidgetRepository);
}

abstract class _HomePageStore with Store {
  _HomePageStore(this._homeWidgetRepository);

  final HomeWidgetRepository _homeWidgetRepository;

  @observable
  late ObservableStream<List<HomeWidgetRepr>> homeWidgetsStream = _homeWidgetRepository
      .homeWidgetsStream
      .map((homeWidgets) => homeWidgets.map(_mapHomeWidget).toList())
      .asObservable();

  Future<void> moveHomeWidget(int oldPosition, int newPosition) =>
      _homeWidgetRepository.moveHomeWidget(oldPosition, newPosition);

  Future<void> addHomeWidget(HomeWidget homeWidget) =>
      _homeWidgetRepository.insertHomeWidget(homeWidget);

  Future<void> removeHomeWidget(HomeWidget homeWidget) =>
      _homeWidgetRepository.removeHomeWidget(homeWidget);

  HomeWidgetRepr _mapHomeWidget(HomeWidget homeWidget) {
    if (homeWidget is HomeAlbumOfDay) {
      return AlbumOfDayRepr(homeWidget);
    } else if (homeWidget is HomeArtistOfDay) {
      return ArtistOfDayRepr(homeWidget);
    } else if (homeWidget is HomeHistory) {
      return HistoryRepr(homeWidget);
    } else if (homeWidget is HomePlaylists) {
      return PlaylistsRepr(homeWidget);
    } else if (homeWidget is HomeShuffleAll) {
      return ShuffleAllRepr(homeWidget);
    }
    throw TypeError();
  }
}
