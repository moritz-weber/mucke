import 'package:drift/drift.dart';

import '../../../domain/entities/home_widgets/home_widget.dart';
import '../../models/home_widgets/album_of_day_model.dart';
import '../../models/home_widgets/artist_of_day_model.dart';
import '../../models/home_widgets/history_model.dart';
import '../../models/home_widgets/home_widget_model.dart';
import '../../models/home_widgets/playlists_model.dart';
import '../../models/home_widgets/shuffle_all_model.dart';
import '../home_widget_data_source.dart';
import '../drift_database.dart';

part 'home_widget_dao.g.dart';

@DriftAccessor(tables: [HomeWidgets, KeyValueEntries])
class HomeWidgetDao extends DatabaseAccessor<MainDatabase>
    with _$HomeWidgetDaoMixin
    implements HomeWidgetDataSource {
  HomeWidgetDao(MainDatabase db) : super(db);

  @override
  Stream<List<HomeWidgetModel>> get homeWidgetsStream {
    return (select(homeWidgets)..orderBy([(t) => OrderingTerm(expression: t.position)]))
        .watch()
        .map((widgets) => widgets.map((w) => _getHomeWidget(w)).toList());
  }

  @override
  Future<void> insertHomeWidget(HomeWidgetModel homeWidget) async {
    into(homeWidgets).insert(homeWidget.toDrift());
  }

  @override
  Future<void> moveHomeWidget(int oldPosition, int newPosition) async {
    if (oldPosition != newPosition) {
      transaction(() async {
        await (update(homeWidgets)..where((tbl) => tbl.position.equals(oldPosition)))
            .write(const HomeWidgetsCompanion(position: Value(-1)));
        if (oldPosition < newPosition) {
          for (int i = oldPosition + 1; i <= newPosition; i++) {
            await (update(homeWidgets)..where((tbl) => tbl.position.equals(i)))
                .write(HomeWidgetsCompanion(position: Value(i - 1)));
          }
        } else {
          for (int i = oldPosition - 1; i >= newPosition; i--) {
            await (update(homeWidgets)..where((tbl) => tbl.position.equals(i)))
                .write(HomeWidgetsCompanion(position: Value(i + 1)));
          }
        }
        await (update(homeWidgets)..where((tbl) => tbl.position.equals(-1)))
            .write(HomeWidgetsCompanion(position: Value(newPosition)));
      });
    }
  }

  @override
  Future<void> removeHomeWidget(HomeWidgetModel homeWidget) async {
    final entries = await select(homeWidgets).get();
    final count = entries.length;

    transaction(() async {
      await (delete(homeWidgets)..where((tbl) => tbl.position.equals(homeWidget.position))).go();
      for (int i = homeWidget.position + 1; i < count; i++) {
        await (update(homeWidgets)..where((tbl) => tbl.position.equals(i)))
            .write(HomeWidgetsCompanion(position: Value(i - 1)));
      }
    });
  }

  @override
  Future<void> updateHomeWidget(HomeWidgetModel homeWidget) async {
    await (update(homeWidgets)..where((tbl) => tbl.position.equals(homeWidget.position)))
        .write(homeWidget.toDrift());
  }

  HomeWidgetModel _getHomeWidget(DriftHomeWidget driftHomeWidget) {
    final type = driftHomeWidget.type.toHomeWidgetType();

    switch (type) {
      case HomeWidgetType.shuffle_all:
        return HomeShuffleAllModel.fromDrift(driftHomeWidget);
      case HomeWidgetType.album_of_day:
        return HomeAlbumOfDayModel.fromDrift(driftHomeWidget);
      case HomeWidgetType.artist_of_day:
        return HomeArtistOfDayModel.fromDrift(driftHomeWidget);
      case HomeWidgetType.playlists:
        return HomePlaylistsModel.fromDrift(driftHomeWidget);
      case HomeWidgetType.history:
      return HomeHistoryModel.fromDrift(driftHomeWidget);
    }
  }
}
