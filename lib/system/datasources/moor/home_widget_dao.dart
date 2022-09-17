import 'package:drift/drift.dart';

import '../../../domain/entities/home_widgets/home_widget.dart';
import '../../models/home_widgets/album_of_day_model.dart';
import '../../models/home_widgets/artist_of_day_model.dart';
import '../../models/home_widgets/home_widget_model.dart';
import '../../models/home_widgets/playlists_model.dart';
import '../../models/home_widgets/shuffle_all_model.dart';
import '../home_widget_data_source.dart';
import '../moor_database.dart';

part 'home_widget_dao.g.dart';

@DriftAccessor(tables: [HomeWidgets, KeyValueEntries])
class HomeWidgetDao extends DatabaseAccessor<MoorDatabase>
    with _$HomeWidgetDaoMixin
    implements HomeWidgetDataSource {
  HomeWidgetDao(MoorDatabase db) : super(db);

  @override
  Stream<List<HomeWidgetModel>> get homeWidgetsStream {
    return (select(homeWidgets)..orderBy([(t) => OrderingTerm(expression: t.position)]))
        .watch()
        .map((widgets) => widgets.map((w) => _getHomeWidget(w)).toList());
  }

  @override
  Future<void> insertHomeWidget(HomeWidgetModel homeWidget) async {
    into(homeWidgets).insert(homeWidget.toMoor());
  }

  @override
  Future<void> moveHomeWidget(int oldPosition, int newPosition) {
    // TODO: implement moveHomeWidget
    throw UnimplementedError();
  }

  @override
  Future<void> removeHomeWidget(HomeWidgetModel homeWidget) {
    // TODO: implement removeHomeWidget
    throw UnimplementedError();
  }

  @override
  Future<void> updateHomeWidget(HomeWidgetModel homeWidget) {
    // TODO: implement updateHomeWidget
    throw UnimplementedError();
  }

  HomeWidgetModel _getHomeWidget(MoorHomeWidget moorHomeWidget) {
    final type = moorHomeWidget.type.toHomeWidgetType();

    switch (type) {
      case HomeWidgetType.shuffle_all:
        return HomeShuffleAllModel.fromMoor(moorHomeWidget);
      case HomeWidgetType.album_of_day:
        return HomeAlbumOfDayModel.fromMoor(moorHomeWidget);
      case HomeWidgetType.artist_of_day:
        return HomeArtistOfDayModel.fromMoor(moorHomeWidget);
      case HomeWidgetType.playlists:
        return HomePlaylistsModel.fromMoor(moorHomeWidget);
      // case HomeWidgetType.history:
    }
  }
}
