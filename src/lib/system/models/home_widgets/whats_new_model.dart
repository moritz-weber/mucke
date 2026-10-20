import 'package:drift/drift.dart';

import '../../../domain/entities/home_widgets/home_widget.dart';
import '../../../domain/entities/home_widgets/whats_new.dart';
import '../../datasources/drift_database.dart';
import 'home_widget_model.dart';

class HomeWhatsNewModel extends HomeWhatsNew implements HomeWidgetModel {
  HomeWhatsNewModel(int position) : super(position: position);

  factory HomeWhatsNewModel.fromDrift(DriftHomeWidget driftHomeWidget) {
    final type = driftHomeWidget.type.toHomeWidgetType();
    if (type != HomeWidgetType.whats_new) {
      throw TypeError();
    }

    return HomeWhatsNewModel(driftHomeWidget.position);
  }

  factory HomeWhatsNewModel.fromEntity(HomeWidget entity) {
    if (entity.type != HomeWidgetType.whats_new) {
      throw TypeError();
    }
    entity as HomeWhatsNew;
    return HomeWhatsNewModel(entity.position);
  }

  @override
  HomeWidgetsCompanion toDrift() {
    return HomeWidgetsCompanion(
      position: Value(position),
      type: Value(type.toString()),
      data: const Value('{}'),
    );
  }
}
