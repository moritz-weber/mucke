import 'package:drift/drift.dart';

import '../../domain/entities/artist.dart';
import '../datasources/moor_database.dart';

class ArtistModel extends Artist {
  const ArtistModel({
    required String name,
    required this.id,
  }) : super(
          name: name,
        );

  factory ArtistModel.fromMoor(MoorArtist moorArtist) => ArtistModel(
        name: moorArtist.name,
        id: moorArtist.id,
      );

  final int id;

  @override
  String toString() {
    return name;
  }

  ArtistsCompanion toArtistsCompanion() => ArtistsCompanion(
        name: Value(name),
      );
}

class ArtistOfDay {
  ArtistOfDay(this.artistModel, this.date);

  final ArtistModel artistModel;
  final DateTime date;

  @override
  String toString() {
    return '{"name": "${artistModel.name}", "date": ${date.millisecondsSinceEpoch}}';
  }
}