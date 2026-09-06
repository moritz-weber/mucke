import '../../domain/entities/scan_failure.dart';
import '../../domain/entities/scan_result.dart';
import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/song_model.dart';

/// Internal, fetcher-level result of a library scan.
///
/// Carries the parsed songs/albums/artists that the repository persists, plus
/// any failures encountered during the scan. Callers that only need the
/// user-facing summary can use [toScanResult].
class LibraryScanResult {
  const LibraryScanResult({
    this.songs = const [],
    this.albums = const [],
    this.artists = const [],
    this.failures = const [],
  });

  final List<SongModel> songs;
  final List<AlbumModel> albums;
  final List<ArtistModel> artists;
  final List<ScanFailure> failures;

  /// Converts this to the public, UI-facing result summary.
  ScanResult toScanResult() => ScanResult(
        failures: failures,
        songCount: songs.length,
        albumCount: albums.length,
        artistCount: artists.length,
      );
}