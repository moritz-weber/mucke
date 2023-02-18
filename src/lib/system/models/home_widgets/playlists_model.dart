import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../domain/entities/enums.dart';
import '../../../domain/entities/home_widgets/home_widget.dart';
import '../../../domain/entities/home_widgets/playlists.dart';
import '../../datasources/drift_database.dart';
import 'home_widget_model.dart';

class HomePlaylistsModel extends HomePlaylists implements HomeWidgetModel {
  HomePlaylistsModel(
    int position,
    int maxEntries,
    String title,
    HomePlaylistsOrder orderCriterion,
    OrderDirection orderDirection,
    HomePlaylistsFilter filter,
  ) : super(
          position: position,
          maxEntries: maxEntries,
          title: title,
          orderCriterion: orderCriterion,
          orderDirection: orderDirection,
          filter: filter,
        );

  factory HomePlaylistsModel.fromDrift(DriftHomeWidget driftHomeWidget) {
    final type = driftHomeWidget.type.toHomeWidgetType();
    if (type != HomeWidgetType.playlists) {
      throw TypeError();
    }

    final data = json.decode(driftHomeWidget.data);

    return HomePlaylistsModel(
      driftHomeWidget.position,
      data['maxEntries'] as int,
      data['title'] as String,
      (data['orderCriterion'] as String).toHomePlaylistsOrder()!,
      (data['orderDirection'] as String).toOrderDirection()!,
      (data['filter'] as String).toHomePlaylistsFilter()!,
    );
  }

  factory HomePlaylistsModel.fromEntity(HomeWidget entity) {
    if (entity.type != HomeWidgetType.playlists) {
      throw TypeError();
    }
    entity as HomePlaylists;
    return HomePlaylistsModel(
      entity.position,
      entity.maxEntries,
      entity.title,
      entity.orderCriterion,
      entity.orderDirection,
      entity.filter,
    );
  }

  @override
  HomeWidgetsCompanion toDrift() {
    final Map<String, dynamic> data = {
      'title': title,
      'maxEntries': maxEntries,
      'orderCriterion': orderCriterion.toString(),
      'orderDirection': orderDirection.toString(),
      'filter': filter.toString(),
    };
    return HomeWidgetsCompanion(
      position: Value(position),
      type: Value(type.toString()),
      data: Value(json.encode(data)),
    );
  }
}
