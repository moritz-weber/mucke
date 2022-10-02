import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../domain/entities/home_widgets/home_widget.dart';
import '../../../domain/entities/home_widgets/shuffle_all.dart';
import '../../../domain/entities/shuffle_mode.dart';
import '../../datasources/moor_database.dart';
import 'home_widget_model.dart';

class HomeShuffleAllModel extends HomeShuffleAll implements HomeWidgetModel {
  HomeShuffleAllModel(
    int position,
    ShuffleMode shuffleMode,
  ) : super(
          position: position,
          shuffleMode: shuffleMode,
        );

  factory HomeShuffleAllModel.fromMoor(MoorHomeWidget moorHomeWidget) {
    final type = moorHomeWidget.type.toHomeWidgetType();
    if (type != HomeWidgetType.shuffle_all) {
      throw TypeError();
    }

    final data = jsonDecode(moorHomeWidget.data);
    final shuffleMode = (data['shuffleMode'] as String).toShuffleMode();
    return HomeShuffleAllModel(moorHomeWidget.position, shuffleMode);
  }

  factory HomeShuffleAllModel.fromEntity(HomeWidget entity) {
    if (entity.type != HomeWidgetType.shuffle_all) {
      throw TypeError();
    }
    entity as HomeShuffleAll;
    return HomeShuffleAllModel(entity.position, entity.shuffleMode);
  }

  @override
  HomeWidgetsCompanion toMoor() {
    final data = {'shuffleMode': '$shuffleMode'};
    return HomeWidgetsCompanion(
      position: Value(position),
      type: Value(type.toString()),
      data: Value(json.encode(data)),
    );
  }
}
