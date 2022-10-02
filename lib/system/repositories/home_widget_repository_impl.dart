import 'package:rxdart/rxdart.dart';

import '../../domain/entities/home_widgets/home_widget.dart';
import '../../domain/repositories/home_widget_repository.dart';
import '../datasources/home_widget_data_source.dart';
import '../models/home_widgets/album_of_day_model.dart';
import '../models/home_widgets/artist_of_day_model.dart';
import '../models/home_widgets/history_model.dart';
import '../models/home_widgets/home_widget_model.dart';
import '../models/home_widgets/playlists_model.dart';
import '../models/home_widgets/shuffle_all_model.dart';

class HomeWidgetRepositoryImpl implements HomeWidgetRepository {
  HomeWidgetRepositoryImpl(this._homeWidgetDataSource) {
    _homeWidgetDataSource.homeWidgetsStream.listen((event) {
      _homeWidgetSubject.add(event);
    });
  }

  final HomeWidgetDataSource _homeWidgetDataSource;

  final BehaviorSubject<List<HomeWidget>> _homeWidgetSubject = BehaviorSubject();

  @override
  ValueStream<List<HomeWidget>> get homeWidgetsStream => _homeWidgetSubject.stream;

  @override
  Future<void> insertHomeWidget(HomeWidget homeWidget) async {
    await _homeWidgetDataSource.insertHomeWidget(_getHomeWidgetModel(homeWidget));
  }

  @override
  Future<void> moveHomeWidget(int oldPosition, int newPosition) async {
    await _homeWidgetDataSource.moveHomeWidget(oldPosition, newPosition);
  }

  @override
  Future<void> removeHomeWidget(HomeWidget homeWidget) async {
    await _homeWidgetDataSource.removeHomeWidget(_getHomeWidgetModel(homeWidget));
  }

  @override
  Future<void> updateHomeWidget(HomeWidget homeWidget) async {
    await _homeWidgetDataSource.updateHomeWidget(_getHomeWidgetModel(homeWidget));
  }

  HomeWidgetModel _getHomeWidgetModel(HomeWidget homeWidget) {
    switch (homeWidget.type) {
      case HomeWidgetType.shuffle_all:
        return HomeShuffleAllModel.fromEntity(homeWidget);
      case HomeWidgetType.album_of_day:
        return HomeAlbumOfDayModel.fromEntity(homeWidget);
      case HomeWidgetType.artist_of_day:
        return HomeArtistOfDayModel.fromEntity(homeWidget);
      case HomeWidgetType.playlists:
        return HomePlaylistsModel.fromEntity(homeWidget);
      case HomeWidgetType.history:
        return HomeHistoryModel.fromEntity(homeWidget);
    }
  }
}
