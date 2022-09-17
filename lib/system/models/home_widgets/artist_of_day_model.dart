import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../domain/entities/home_widgets/artist_of_day.dart';
import '../../../domain/entities/home_widgets/home_widget.dart';
import '../../../domain/entities/shuffle_mode.dart';
import '../../datasources/moor_database.dart';
import 'home_widget_model.dart';

class HomeArtistOfDayModel extends HomeArtistOfDay implements HomeWidgetModel {
  HomeArtistOfDayModel(super.position, super.shuffleMode);

  factory HomeArtistOfDayModel.fromMoor(MoorHomeWidget moorHomeWidget) {
    final type = moorHomeWidget.type.toHomeWidgetType();
    if (type != HomeWidgetType.artist_of_day) {
      throw TypeError();
    }

    final data = jsonDecode(moorHomeWidget.data);
    final shuffleMode = (data['shuffleMode'] as String).toShuffleMode();
    return HomeArtistOfDayModel(moorHomeWidget.position, shuffleMode);
  }

  factory HomeArtistOfDayModel.fromEntity(HomeWidget entity) {
    if (entity.type != HomeWidgetType.artist_of_day) {
      throw TypeError();
    }
    entity as HomeArtistOfDay;
    return HomeArtistOfDayModel(entity.position, entity.shuffleMode);
  }

  @override
  HomeWidgetsCompanion toMoor() {
    final data = '{"shuffleMode": $shuffleMode}';
    return HomeWidgetsCompanion(
      position: Value(position),
      type: Value(type.toString()),
      data: Value(data),
    );
  }
}
