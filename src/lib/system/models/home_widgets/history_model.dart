import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../domain/entities/home_widgets/history.dart';
import '../../../domain/entities/home_widgets/home_widget.dart';
import '../../datasources/moor_database.dart';
import 'home_widget_model.dart';

class HomeHistoryModel extends HomeHistory implements HomeWidgetModel {
  HomeHistoryModel(
    int position,
    int maxEntries,
  ) : super(
          position: position,
          maxEntries: maxEntries,
        );

  factory HomeHistoryModel.fromMoor(MoorHomeWidget moorHomeWidget) {
    final type = moorHomeWidget.type.toHomeWidgetType();
    if (type != HomeWidgetType.history) {
      throw TypeError();
    }

    final data = jsonDecode(moorHomeWidget.data);
    final maxEntries = data['maxEntries'] as int;
    return HomeHistoryModel(moorHomeWidget.position, maxEntries);
  }

  factory HomeHistoryModel.fromEntity(HomeWidget entity) {
    if (entity.type != HomeWidgetType.history) {
      throw TypeError();
    }
    entity as HomeHistory;
    return HomeHistoryModel(entity.position, entity.maxEntries);
  }

  @override
  HomeWidgetsCompanion toMoor() {
    final data = {'maxEntries': maxEntries};
    return HomeWidgetsCompanion(
      position: Value(position),
      type: Value(type.toString()),
      data: Value(json.encode(data)),
    );
  }
}
