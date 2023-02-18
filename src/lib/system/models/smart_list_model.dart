import 'package:drift/drift.dart' as m;

import '../../domain/entities/enums.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/smart_list.dart';
import '../datasources/drift_database.dart';
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

  factory SmartListModel.fromDrift(DriftSmartList driftSmartList, List<DriftArtist>? artists) {
    final filter = Filter(
      artists: artists?.map((DriftArtist a) => ArtistModel.fromDrift(a)).toList(),
      excludeArtists: driftSmartList.excludeArtists,
      minLikeCount: driftSmartList.minLikeCount,
      maxLikeCount: driftSmartList.maxLikeCount,
      minPlayCount: driftSmartList.minPlayCount,
      maxPlayCount: driftSmartList.maxPlayCount,
      minYear: driftSmartList.minYear,
      maxYear: driftSmartList.maxYear,
      blockLevel: driftSmartList.blockLevel,
      limit: driftSmartList.limit,
    );

    final criteria = _parseOrderCriteria(driftSmartList.orderCriteria);
    final directions = _parseOrderDirections(driftSmartList.orderDirections);

    final filteredDirections = <OrderDirection>[];
    criteria.asMap().forEach((key, value) {
      if (value != null) filteredDirections.add(directions[key]);
    });

    final orderBy = OrderBy(
      orderCriteria: criteria.whereType<OrderCriterion>().toList(),
      orderDirections: filteredDirections,
    );

    return SmartListModel(
      id: driftSmartList.id,
      name: driftSmartList.name,
      filter: filter,
      orderBy: orderBy,
      shuffleMode: driftSmartList.shuffleMode?.toShuffleMode(),
      iconString: driftSmartList.icon,
      gradientString: driftSmartList.gradient,
      timeChanged: driftSmartList.timeChanged,
      timeCreated: driftSmartList.timeCreated,
      timeLastPlayed: driftSmartList.timeLastPlayed,
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

  List<SmartListArtistsCompanion> toDriftArtists() {
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

extension ToDriftExtension on OrderDirection {
  m.OrderingMode toDrift() {
    switch (this) {
      case OrderDirection.ascending:
        return m.OrderingMode.asc;
      case OrderDirection.descending:
        return m.OrderingMode.desc;
    }
  }
}
