import 'package:drift/drift.dart';

import '../../../domain/entities/home_widgets/album_of_day.dart';
import '../../../domain/entities/home_widgets/home_widget.dart';
import '../../datasources/drift_database.dart';
import 'home_widget_model.dart';

class HomeAlbumOfDayModel extends HomeAlbumOfDay implements HomeWidgetModel {
  HomeAlbumOfDayModel(super.position);

  factory HomeAlbumOfDayModel.fromDrift(DriftHomeWidget driftHomeWidget) {
    final type = driftHomeWidget.type.toHomeWidgetType();
    if (type != HomeWidgetType.album_of_day) {
      throw TypeError();
    }

    return HomeAlbumOfDayModel(driftHomeWidget.position);
  }

  factory HomeAlbumOfDayModel.fromEntity(HomeWidget entity) {
    if (entity.type != HomeWidgetType.album_of_day) {
      throw TypeError();
    }
    entity as HomeAlbumOfDay;
    return HomeAlbumOfDayModel(entity.position);
  }

  @override
  HomeWidgetsCompanion toDrift() {
    const data = '{}';
    return HomeWidgetsCompanion(
      position: Value(position),
      type: Value(type.toString()),
      data: const Value(data),
    );
  }
}
