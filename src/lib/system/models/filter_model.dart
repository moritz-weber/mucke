import '../../domain/entities/smart_list.dart';

class FilterModel extends Filter {
  const FilterModel({
    required super.excludeArtists,
    required super.minLikeCount,
    required super.maxLikeCount,
    required super.blockLevel,
    super.artists,
    super.limit,
    super.maxPlayCount,
    super.maxYear,
    super.minPlayCount,
    super.minYear,
  });

  Map<String, dynamic> toExportMap() => {
        'artists': artists?.map((e) => e.id).toList(),
        'excludeArtists': excludeArtists,
        'minPlayCount': minPlayCount,
        'maxPlayCount': maxPlayCount,
        'minLikeCount': minLikeCount,
        'maxLikeCount': maxLikeCount,
        'minYear': minYear,
        'maxYear': maxYear,
        'blockLevel': blockLevel,
        'limit': limit,
      };
}
