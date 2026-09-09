import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mucke/l10n/localizations.dart';
import 'package:path/path.dart' as p;

import '../../domain/entities/scan_failure.dart';
import '../state/navigation_store.dart';
import '../theming.dart';

/// A full page listing the failures encountered during the last library scan.
/// Each entry shows the failing file, the stage that failed, and the failure
/// reason when available.
class ScanFailuresPage extends StatelessWidget {
  const ScanFailuresPage({Key? key, required this.failures}) : super(key: key);

  final List<ScanFailure> failures;

  @override
  Widget build(BuildContext context) {
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context)!.scanFailures, style: TEXT_HEADER),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => navStore.pop(context),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: failures.length,
        itemBuilder: (context, index) => _ScanFailureTile(failure: failures[index]),
      ),
    );
  }
}

class _ScanFailureTile extends StatelessWidget {
  const _ScanFailureTile({required this.failure});

  final ScanFailure failure;

  @override
  Widget build(BuildContext context) {
    final String detail = failure.reason?.isNotEmpty == true
        ? failure.reason!
        : _fallbackReason(context, failure.type);

    return ListTile(
      title: Text(_title(context)),
      subtitle: Text(detail, style: TEXT_SMALL_SUBTITLE),
      // isThreeLine: true,
    );
  }

  String _title(BuildContext context) {
    if (failure.path == null || failure.path!.isEmpty) {
      return stageLabel(context, failure.type);
    }

    if (failure.type == ScanFailureType.accentColor) {
      return '${L10n.of(context)!.album}: ${failure.path}';
    }

    return filePathKeeper(failure.path!);
  }

  String _fallbackReason(BuildContext context, ScanFailureType type) {
    final l10n = L10n.of(context)!;
    switch (type) {
      case ScanFailureType.metadataRead:
        return l10n.scanErrorMetadata;
      case ScanFailureType.albumArt:
        return l10n.scanErrorAlbumArt;
      case ScanFailureType.accentColor:
        return l10n.scanErrorAccentColor;
      case ScanFailureType.permission:
        return l10n.scanErrorPermission;
    }
  }
}

String stageLabel(BuildContext context, ScanFailureType type) {
  final l10n = L10n.of(context)!;
  switch (type) {
    case ScanFailureType.metadataRead:
      return l10n.scanStageMetadata;
    case ScanFailureType.albumArt:
      return l10n.scanStageAlbumArt;
    case ScanFailureType.accentColor:
      return l10n.scanStageAccentColor;
    case ScanFailureType.permission:
      return l10n.scanStagePermission;
  }
}

/// Keeps only the last [maxParents] directory segments of [path] plus the file
/// name, truncating the path from the front with a leading ellipsis. This
/// preserves the filename (and the typical `artist/album/song` structure) while
/// hiding long root paths.
String filePathKeeper(String path, {int maxParents = 2, int maxLength = 96}) {
  final segments = p.split(path).where((s) => s.isNotEmpty).toList();
  if (segments.isEmpty) return path;

  final keep = segments.length > maxParents + 1
      ? segments.skip(segments.length - (maxParents + 1)).toList()
      : segments;
  final hook = keep.length < segments.length ? '...' : '';
  final separator = p.separator;

  String result = keep.join(separator);
  if (keep.length > 1) result = '$separator$result';

  if (result.length > maxLength) {
    result = '${result.substring(result.length - maxLength)}';
  }

  return '$hook$result';
}
