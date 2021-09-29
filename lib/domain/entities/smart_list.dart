import 'package:equatable/equatable.dart';

import 'artist.dart';
import 'shuffle_mode.dart';

class SmartList extends Equatable {
  const SmartList({
    this.id,
    required this.name,
    required this.position,
    required this.filter,
    required this.orderBy,
    this.shuffleMode,
  });

  final int? id;
  final String name;
  final int position;
  final Filter filter;
  final OrderBy orderBy;
  final ShuffleMode? shuffleMode;

  @override
  List<Object?> get props => [name, filter, orderBy, shuffleMode];
}

class Filter extends Equatable {
  const Filter({
    required this.artists,
    required this.excludeArtists,
    this.minPlayCount,
    this.maxPlayCount,
    required this.minLikeCount,
    required this.maxLikeCount,
    this.minYear,
    this.maxYear,
    required this.excludeBlocked,
    this.limit,
  });

  final List<Artist> artists;
  final bool excludeArtists;

  final int? minPlayCount;
  final int? maxPlayCount;

  final int minLikeCount;
  final int maxLikeCount;

  final int? minYear;
  final int? maxYear;

  final bool excludeBlocked;

  final int? limit;

  @override
  List<Object?> get props => [
        artists,
        excludeArtists,
        minPlayCount,
        maxPlayCount,
        minLikeCount,
        maxLikeCount,
        minYear,
        maxYear,
        limit,
      ];
}

class OrderBy extends Equatable {
  const OrderBy({
    required this.orderCriteria,
    required this.orderDirections,
  });

  final List<OrderCriterion> orderCriteria;
  final List<OrderDirection> orderDirections;

  @override
  List<Object?> get props => [orderCriteria, orderDirections];
}

enum OrderCriterion {
  artistName,
  likeCount,
  playCount,
  songTitle,
  timeAdded,
  year,
}

extension OrderCriterionExtension on String {
  OrderCriterion? toOrderCriterion() {
    switch (this) {
      case 'OrderCriterion.artistName':
        return OrderCriterion.artistName;
      case 'OrderCriterion.likeCount':
        return OrderCriterion.likeCount;
      case 'OrderCriterion.playCount':
        return OrderCriterion.playCount;
      case 'OrderCriterion.songTitle':
        return OrderCriterion.songTitle;
      case 'OrderCriterion.timeAdded':  
        return OrderCriterion.timeAdded;
      case 'OrderCriterion.year':
        return OrderCriterion.year;
      default:
        return null;
    }
  }
}

enum OrderDirection {
  ascending,
  descending,
}

extension OrderDirectionExtension on String {
  OrderDirection? toOrderDirection() {
    switch (this) {
      case 'OrderDirection.ascending':
        return OrderDirection.ascending;
      case 'OrderDirection.descending':
        return OrderDirection.descending;
      default:
        return null;
    }
  }
}
