import 'package:equatable/equatable.dart';

import 'artist.dart';
import 'custom_list.dart';
import 'enums.dart';
import 'playable.dart';
import 'shuffle_mode.dart';

class SmartList extends CustomList with EquatableMixin implements Playable {
  const SmartList({
    required String name,
    required String iconString,
    required String gradientString,
    required DateTime timeCreated,
    required DateTime timeChanged,
    required DateTime timeLastPlayed,
    ShuffleMode? shuffleMode,
    required this.id,
    required this.filter,
    required this.orderBy,
  }) : super(
          name,
          iconString,
          gradientString,
          shuffleMode,
          timeCreated,
          timeChanged,
          timeLastPlayed,
        );

  final int id;
  final Filter filter;
  final OrderBy orderBy;

  @override
  List<Object?> get props => [
        name,
        filter,
        orderBy,
        shuffleMode,
        iconString,
        gradientString,
        timeCreated,
        timeChanged,
        timeLastPlayed,
      ];

  @override
  PlayableType get type => PlayableType.smartlist;
}

class Filter extends Equatable {
  const Filter({
    required this.artists,
    required this.excludeArtists,
    this.minPlayCount,
    this.maxPlayCount,
    required this.minLikeCount,
    required this.maxLikeCount,
    this.minSkipCount,
    this.maxSkipCount,
    this.minYear,
    this.maxYear,
    required this.blockLevel,
    this.limit,
  });

  final List<Artist> artists;
  final bool excludeArtists;

  final int? minPlayCount;
  final int? maxPlayCount;

  final int minLikeCount;
  final int maxLikeCount;

  final int? minSkipCount;
  final int? maxSkipCount;

  final int? minYear;
  final int? maxYear;

  final int blockLevel;

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
  skipCount,
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
      case 'OrderCriterion.skipCount':
        return OrderCriterion.skipCount;
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
