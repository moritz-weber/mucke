import 'package:equatable/equatable.dart';

/// The stage of the library scan that produced a failure.
enum ScanFailureType {
  /// Reading the audio file's metadata (tags) failed.
  metadataRead,

  /// Reading an embedded or folder album art image failed.
  albumArt,

  /// Deriving the album accent/background color from the album art failed.
  accentColor,

  /// The scan did not even start because audio permission was denied.
  permission,
}

/// Represents a single file/stage that failed during a library scan.
class ScanFailure extends Equatable {
  const ScanFailure({
    this.path,
    required this.type,
    this.reason,
  });

  /// The file that failed, when known (e.g. the audio file, album-art image).
  final String? path;

  final ScanFailureType type;

  /// A human readable description of the failure, when available.
  final String? reason;

  ScanFailure copyWith({
    String? path,
    ScanFailureType? type,
    String? reason,
  }) {
    return ScanFailure(
      path: path ?? this.path,
      type: type ?? this.type,
      reason: reason ?? this.reason,
    );
  }

  @override
  List<Object?> get props => [path, type, reason];

  @override
  String toString() => 'ScanFailure(type: $type, path: $path, reason: $reason)';
}