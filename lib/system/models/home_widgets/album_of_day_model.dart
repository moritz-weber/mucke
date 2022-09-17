import 'package:drift/drift.dart';

import '../../../domain/entities/home_widgets/album_of_day.dart';
import '../../../domain/entities/home_widgets/home_widget.dart';
import '../../datasources/moor_database.dart';
import 'home_widget_model.dart';

class HomeAlbumOfDayModel extends HomeAlbumOfDay implements HomeWidgetModel {
  HomeAlbumOfDayModel(super.position);

  factory HomeAlbumOfDayModel.fromMoor(MoorHomeWidget moorHomeWidget) {
    final type = moorHomeWidget.type.toHomeWidgetType();
    if (type != HomeWidgetType.album_of_day) {
      throw TypeError();
    }

    return HomeAlbumOfDayModel(moorHomeWidget.position);
  }

  factory HomeAlbumOfDayModel.fromEntity(HomeWidget entity) {
    if (entity.type != HomeWidgetType.album_of_day) {
      throw TypeError();
    }
    entity as HomeAlbumOfDay;
    return HomeAlbumOfDayModel(entity.position);
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
