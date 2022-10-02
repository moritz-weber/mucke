import 'package:drift/drift.dart';

import '../../domain/entities/artist.dart';
import '../datasources/moor_database.dart';

class ArtistModel extends Artist {
  const ArtistModel({
    required super.id,
    required super.name,
  });

  factory ArtistModel.fromMoor(MoorArtist moorArtist) => ArtistModel(
        name: moorArtist.name,
        id: moorArtist.id,
      );

  @override
  String toString() {
    return name;
  }

  ArtistsCompanion toArtistsCompanion() => ArtistsCompanion(
        id: Value(id),
        name: Value(name),
      );
}

class ArtistOfDay {
  ArtistOfDay(this.artistModel, this.date);

  final ArtistModel artistModel;
  final DateTime date;

  String toJSON() {
    return '{"id": ${artistModel.id}, "date": ${date.millisecondsSinceEpoch}}';
  }
}
