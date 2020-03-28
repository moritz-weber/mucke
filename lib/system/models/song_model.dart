import 'package:mosh/domain/entities/song.dart';
import 'package:meta/meta.dart';

class SongModel extends Song {
  SongModel({
    this.id,
    @required String title,
    @required String album,
    @required String artist,
    @required String path,
    int trackNumber,
    String albumArtPath,
  }) : super(
          title: title,
          album: album,
          artist: artist,
          path: path,
          trackNumber: trackNumber,
          albumArtPath: albumArtPath,
        );

  final int id;
}
