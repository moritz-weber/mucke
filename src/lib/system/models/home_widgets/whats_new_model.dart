import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../domain/entities/home_widgets/home_widget.dart';
import '../../../domain/entities/home_widgets/whats_new.dart';
import '../../datasources/drift_database.dart';
import 'home_widget_model.dart';

class HomeWhatsNewModel extends HomeWhatsNew implements HomeWidgetModel {
  HomeWhatsNewModel(
    int position, {
    bool dismissed = false,
    bool autoDismiss = true,
  }) : super(position: position, dismissed: dismissed, autoDismiss: autoDismiss);

  factory HomeWhatsNewModel.fromDrift(DriftHomeWidget driftHomeWidget) {
    final type = driftHomeWidget.type.toHomeWidgetType();
    if (type != HomeWidgetType.whats_new) {
      throw TypeError();
    }

    final data = driftHomeWidget.data.isEmpty
        ? const <String, dynamic>{}
        : jsonDecode(driftHomeWidget.data) as Map<String, dynamic>;
    final dismissed = data['dismissed'] as bool? ?? false;
    final autoDismiss = data['autoDismiss'] as bool? ?? true;
    return HomeWhatsNewModel(
      driftHomeWidget.position,
      dismissed: dismissed,
      autoDismiss: autoDismiss,
    );
  }

  factory HomeWhatsNewModel.fromEntity(HomeWidget entity) {
    if (entity.type != HomeWidgetType.whats_new) {
      throw TypeError();
    }
    entity as HomeWhatsNew;
    return HomeWhatsNewModel(
      entity.position,
      dismissed: entity.dismissed,
      autoDismiss: entity.autoDismiss,
    );
  }

  @override
  HomeWidgetsCompanion toDrift() {
    final data = {'dismissed': dismissed, 'autoDismiss': autoDismiss};
    return HomeWidgetsCompanion(
      position: Value(position),
      type: Value(type.toString()),
      data: Value(json.encode(data)),
    );
  }
}
