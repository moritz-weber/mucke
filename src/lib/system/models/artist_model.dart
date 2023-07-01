import 'package:drift/drift.dart';

import '../../domain/entities/artist.dart';
import '../datasources/drift_database.dart';

class ArtistModel extends Artist {
  const ArtistModel({
    required super.id,
    required super.name,
  });

  factory ArtistModel.fromDrift(DriftArtist driftArtist) => ArtistModel(
        name: driftArtist.name,
        id: driftArtist.id,
      );

  @override
  String toString() {
    return name;
  }

  ArtistsCompanion toArtistsCompanion() => ArtistsCompanion(
        id: Value(id),
        name: Value(name),
      );

  Map<String, dynamic> toExportMap() => {
        'name': name,
      };
}

class ArtistOfDay {
  ArtistOfDay(this.artistModel, this.date);

  final ArtistModel artistModel;
  final DateTime date;

  String toJSON() {
    return '{"id": ${artistModel.id}, "date": ${date.millisecondsSinceEpoch}}';
  }
}
