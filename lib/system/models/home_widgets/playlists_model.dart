import 'package:drift/drift.dart';

import '../../../domain/entities/home_widgets/home_widget.dart';
import '../../../domain/entities/home_widgets/playlists.dart';
import '../../datasources/moor_database.dart';
import 'home_widget_model.dart';

class HomePlaylistsModel extends HomePlaylists implements HomeWidgetModel {
  HomePlaylistsModel(super.position);

  factory HomePlaylistsModel.fromMoor(MoorHomeWidget moorHomeWidget) {
    final type = moorHomeWidget.type.toHomeWidgetType();
    if (type != HomeWidgetType.playlists) {
      throw TypeError();
    }

    return HomePlaylistsModel(moorHomeWidget.position);
  }

  factory HomePlaylistsModel.fromEntity(HomeWidget entity) {
    if (entity.type != HomeWidgetType.playlists) {
      throw TypeError();
    }
    entity as HomePlaylists;
    return HomePlaylistsModel(entity.position);
  }

  @override
  HomeWidgetsCompanion toMoor() {
    const data = '{}';
    return HomeWidgetsCompanion(
      position: Value(position),
      type: Value(type.toString()),
      data: const Value(data),
    );
  }
}
