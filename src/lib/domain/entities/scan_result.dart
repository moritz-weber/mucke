import 'scan_failure.dart';

/// The result of a full library scan, including any failures that occurred.
class ScanResult {
  const ScanResult({
    this.failures = const [],
    this.songCount = 0,
    this.albumCount = 0,
    this.artistCount = 0,
  });

  /// The failures encountered during this scan, if any.
  final List<ScanFailure> failures;

  /// Number of songs found during the scan.
  final int songCount;

  /// Number of albums found during the scan.
  final int albumCount;

  /// Number of artists found during the scan.
  final int artistCount;

  bool get hasFailures => failures.isNotEmpty;

  /// Whether the scan never ran because audio permission was denied.
  bool get permissionDenied =>
      failures.any((f) => f.type == ScanFailureType.permission);

  int get failureCount => failures.length;
}