import 'package:moor/moor.dart' as m;

import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/smart_list.dart';
import '../datasources/moor_database.dart';
import 'artist_model.dart';

class SmartListModel extends SmartList {
  const SmartListModel({
    required int id,
    required String name,
    required Filter filter,
    required OrderBy orderBy,
    ShuffleMode? shuffleMode,
  }) : super(
          id: id,
          name: name,
          filter: filter,
          orderBy: orderBy,
          shuffleMode: shuffleMode,
        );

  factory SmartListModel.fromMoor(MoorSmartList moorSmartList, List<MoorArtist> artists) {
    final filter = Filter(
      artists: artists.map((MoorArtist a) => ArtistModel.fromMoor(a)).toList(),
      excludeArtists: moorSmartList.excludeArtists,
      minLikeCount: moorSmartList.minLikeCount,
      maxLikeCount: moorSmartList.maxLikeCount,
      minPlayCount: moorSmartList.minPlayCount,
      maxPlayCount: moorSmartList.maxPlayCount,
      minYear: moorSmartList.minYear,
      maxYear: moorSmartList.maxYear,
      excludeBlocked: moorSmartList.excludeBlocked,
      limit: moorSmartList.limit, 
    );

    final orderBy = OrderBy(
      orderCriteria: _parseOrderCriteria(moorSmartList.orderCriteria),
      orderDirections: _parseOrderDirections(moorSmartList.orderDirections),
    );

    return SmartListModel(
      id: moorSmartList.id,
      name: moorSmartList.name,
      filter: filter,
      orderBy: orderBy,
      shuffleMode: moorSmartList.shuffleMode?.toShuffleMode(),
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
        minYear: m.Value(filter.minYear),
        maxYear: m.Value(filter.maxYear),
        excludeBlocked: m.Value(filter.excludeBlocked),
        limit: m.Value(filter.limit),
        orderCriteria: m.Value(orderBy.orderCriteria.join(',')),
        orderDirections: m.Value(orderBy.orderDirections.join(',')),
      );

  List<SmartListArtistsCompanion> toMoorArtists() {
    return filter.artists
        .map(
          (e) => SmartListArtistsCompanion(
            smartListId: m.Value(id),
            artistName: m.Value(e.name),
          ),
        )
        .toList();
  }
}

List<OrderCriterion> _parseOrderCriteria(String orderCriteria) {
  if (orderCriteria == '') return [];
  final ocList = orderCriteria.split(',');
  return ocList.map((e) => e.toOrderCriterion()!).toList();
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
