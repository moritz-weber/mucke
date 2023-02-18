import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../domain/entities/home_widgets/home_widget.dart';
import '../../../domain/entities/home_widgets/shuffle_all.dart';
import '../../../domain/entities/shuffle_mode.dart';
import '../../datasources/drift_database.dart';
import 'home_widget_model.dart';

class HomeShuffleAllModel extends HomeShuffleAll implements HomeWidgetModel {
  HomeShuffleAllModel(
    int position,
    ShuffleMode shuffleMode,
  ) : super(
          position: position,
          shuffleMode: shuffleMode,
        );

  factory HomeShuffleAllModel.fromDrift(DriftHomeWidget driftHomeWidget) {
    final type = driftHomeWidget.type.toHomeWidgetType();
    if (type != HomeWidgetType.shuffle_all) {
      throw TypeError();
    }

    final data = jsonDecode(driftHomeWidget.data);
    final shuffleMode = (data['shuffleMode'] as String).toShuffleMode();
    return HomeShuffleAllModel(driftHomeWidget.position, shuffleMode);
  }

  factory HomeShuffleAllModel.fromEntity(HomeWidget entity) {
    if (entity.type != HomeWidgetType.shuffle_all) {
      throw TypeError();
    }
    entity as HomeShuffleAll;
    return HomeShuffleAllModel(entity.position, entity.shuffleMode);
  }

  @override
  HomeWidgetsCompanion toDrift() {
    final data = {'shuffleMode': '$shuffleMode'};
    return HomeWidgetsCompanion(
      position: Value(position),
      type: Value(type.toString()),
      data: Value(json.encode(data)),
    );
  }
}
