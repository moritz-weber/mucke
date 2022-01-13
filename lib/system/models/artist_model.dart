import 'package:drift/drift.dart';

import '../../domain/entities/artist.dart';
import '../datasources/moor_database.dart';

class ArtistModel extends Artist {
  const ArtistModel({
    required String name,
  }) : super(
          name: name,
        );

  factory ArtistModel.fromMoor(MoorArtist moorArtist) => ArtistModel(
        name: moorArtist.name,
      );

  @override
  String toString() {
    return name;
  }

  ArtistsCompanion toArtistsCompanion() => ArtistsCompanion(
        name: Value(name),
      );
}
