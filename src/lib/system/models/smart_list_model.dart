import 'package:drift/drift.dart' as m;

import '../../domain/entities/enums.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/smart_list.dart';
import '../datasources/moor_database.dart';
import 'artist_model.dart';

class SmartListModel extends SmartList {
  const SmartListModel({
    required int id,
    required String name,
    required String iconString,
    required String gradientString,
    required DateTime timeCreated,
    required DateTime timeChanged,
    required DateTime timeLastPlayed,
    required Filter filter,
    required OrderBy orderBy,
    ShuffleMode? shuffleMode,
  }) : super(
          id: id,
          name: name,
          filter: filter,
          orderBy: orderBy,
          shuffleMode: shuffleMode,
          iconString: iconString,
          gradientString: gradientString,
          timeCreated: timeCreated,
          timeChanged: timeChanged,
          timeLastPlayed: timeLastPlayed,
        );

  factory SmartListModel.fromSmartList(SmartList smartList) {
    return SmartListModel(
      id: smartList.id,
      name: smartList.name,
      filter: smartList.filter,
      orderBy: smartList.orderBy,
      shuffleMode: smartList.shuffleMode,
      iconString: smartList.iconString,
      gradientString: smartList.gradientString,
      timeCreated: smartList.timeCreated,
      timeChanged: smartList.timeChanged,
      timeLastPlayed: smartList.timeLastPlayed,
    );
  }

  factory SmartListModel.fromMoor(MoorSmartList moorSmartList, List<MoorArtist>? artists) {
    final filter = Filter(
      artists: artists?.map((MoorArtist a) => ArtistModel.fromMoor(a)).toList(),
      excludeArtists: moorSmartList.excludeArtists,
      minLikeCount: moorSmartList.minLikeCount,
      maxLikeCount: moorSmartList.maxLikeCount,
      minPlayCount: moorSmartList.minPlayCount,
      maxPlayCount: moorSmartList.maxPlayCount,
      minYear: moorSmartList.minYear,
      maxYear: moorSmartList.maxYear,
      blockLevel: moorSmartList.blockLevel,
      limit: moorSmartList.limit,
    );

    final criteria = _parseOrderCriteria(moorSmartList.orderCriteria);
    final directions = _parseOrderDirections(moorSmartList.orderDirections);

    final filteredDirections = <OrderDirection>[];
    criteria.asMap().forEach((key, value) {
      if (value != null) filteredDirections.add(directions[key]);
    });

    final orderBy = OrderBy(
      orderCriteria: criteria.whereType<OrderCriterion>().toList(),
      orderDirections: filteredDirections,
    );

    return SmartListModel(
      id: moorSmartList.id,
      name: moorSmartList.name,
      filter: filter,
      orderBy: orderBy,
      shuffleMode: moorSmartList.shuffleMode?.toShuffleMode(),
      iconString: moorSmartList.icon,
      gradientString: moorSmartList.gradient,
      timeChanged: moorSmartList.timeChanged,
      timeCreated: moorSmartList.timeCreated,
      timeLastPlayed: moorSmartList.timeLastPlayed,
    );
  }

  SmartListsCompanion toCompanion() => SmartListsCompanion(
        id: m.Value(id),
        name: m.Value(name),
        shuffleMode: m.Value(shuffleMode?.toString()),
        excludeArtists: m.Value(filter.excludeArtists),
        minPlayCount: m.Value(filter.minPlayCount),
        maxPlayCount: m.Value(filter.maxPlayCount),
        minLikeCount: m.Value(filter.minLikeCount),
        maxLikeCount: m.Value(filter.maxLikeCount),
        minSkipCount: const m.Value(null),
        maxSkipCount: const m.Value(null),
        minYear: m.Value(filter.minYear),
        maxYear: m.Value(filter.maxYear),
        blockLevel: m.Value(filter.blockLevel),
        limit: m.Value(filter.limit),
        orderCriteria: m.Value(orderBy.orderCriteria.join(',')),
        orderDirections: m.Value(orderBy.orderDirections.join(',')),
        icon: m.Value(iconString),
        gradient: m.Value(gradientString),
        timeChanged: m.Value(timeChanged),
        timeCreated: m.Value(timeCreated),
        timeLastPlayed: m.Value(timeLastPlayed),
      );

  List<SmartListArtistsCompanion> toMoorArtists() {
    if (filter.artists == null) return [];
    return filter.artists!
        .map(
          (e) => SmartListArtistsCompanion(
            smartListId: m.Value(id),
            artistName: m.Value(e.name),
          ),
        )
        .toList();
  }
}

List<OrderCriterion?> _parseOrderCriteria(String orderCriteria) {
  if (orderCriteria == '') return [];
  final ocList = orderCriteria.split(',');
  return ocList.map((e) => e.toOrderCriterion()).toList();
}

List<OrderDirection> _parseOrderDirections(String orderDirections) {
  if (orderDirections == '') return [];
  final odList = orderDirections.split(',');
  return odList.map((e) => e.toOrderDirection()!).toList();
}

extension ToMoorExtension on OrderDirection {
  m.OrderingMode toMoor() {
    switch (this) {
      case OrderDirection.ascending:
        return m.OrderingMode.asc;
      case OrderDirection.descending:
        return m.OrderingMode.desc;
    }
  }
}
