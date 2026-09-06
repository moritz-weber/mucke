import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mucke/l10n/localizations.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../defaults.dart';
import '../../domain/entities/scan_failure.dart';
import '../../domain/entities/scan_result.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../state/settings_store.dart';
import '../theming.dart';
import '../utils.dart';
import '../widgets/battery_optimization_tile.dart';
import '../widgets/settings_section.dart';
import 'blocked_files_page.dart';
import 'export_page.dart';
import 'library_folders_page.dart';
import 'scan_failures_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    final TextEditingController _textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n.of(context)!.settings,
          style: TEXT_HEADER,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => navStore.pop(context),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SettingsSection(text: L10n.of(context)!.library),
          ListTile(
            title: Text(L10n.of(context)!.updateLibrary),
            subtitle: Observer(builder: (_) {
              if (musicDataStore.isUpdatingDatabase) {
                return LinearProgressIndicator(
                  value: getProgressOrNull(
                    musicDataStore.progressStream.value,
                    musicDataStore.numFileStream.value,
                  ),
                );
              }
              final int artistCount = musicDataStore.artistStream.value?.length ?? 0;
              final int albumCount = musicDataStore.albumStream.value?.length ?? 0;
              final int songCount = musicDataStore.songStream.value?.length ?? 0;
              return Text(
                L10n.of(context)!.artistsAlbumsSongs(artistCount, albumCount, songCount),
              );
            }),
            onTap: () => musicDataStore.updateDatabase().then((result) {
              if (context.mounted) _showScanResult(context, result);
            }),
          ),
          const Divider(),
          ListTile(
            title: Text(L10n.of(context)!.manageLibraryFolders),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => navStore.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const LibraryFoldersPage(),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(L10n.of(context)!.allowedFileExtensions),
            subtitle: Text(
              L10n.of(context)!.allowedFileExtensionsDescription,
              style: TEXT_SMALL_SUBTITLE,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: HORIZONTAL_PADDING,
              right: HORIZONTAL_PADDING,
              bottom: 16.0,
            ),
            child: Observer(
              builder: (context) {
                final text = settingsStore.fileExtensionsStream.value;
                if (text == null) return Container();
                if (_textController.text == '') _textController.text = text;

                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _textController,
                        onChanged: (value) => settingsStore.setFileExtensions(value),
                        textAlign: TextAlign.start,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: DARK35,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                          errorStyle: TextStyle(height: 0, fontSize: 0),
                          contentPadding: EdgeInsets.only(
                            top: 0.0,
                            bottom: 0.0,
                            left: 6.0,
                            right: 6.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    IconButton(
                      icon: const Icon(Icons.settings_backup_restore_rounded),
                      onPressed: () {
                        _textController.text = ALLOWED_FILE_EXTENSIONS;
                        settingsStore.setFileExtensions(ALLOWED_FILE_EXTENSIONS);
                      },
                      tooltip: L10n.of(context)!.reset,
                    ),
                  ],
                );
              },
            ),
          ),
          const Divider(),
          Observer(
            builder: (_) {
              final blockedFiles = settingsStore.numBlockedFiles;

              return ListTile(
                title: Text(L10n.of(context)!.manageBlockedFiles),
                subtitle: Text(L10n.of(context)!.numberOfBlockedFiles(blockedFiles)),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => navStore.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const BlockedFilesPage(),
                  ),
                ),
              );
            },
          ),
          SettingsSection(text: L10n.of(context)!.playback),
          Observer(
            builder: (context) => SwitchListTile(
              value: settingsStore.playAlbumsInOrderStream.value ?? false,
              onChanged: settingsStore.setPlayAlbumsInOrder,
              title: Text(L10n.of(context)!.playAlbumsInOrder),
              subtitle: Text(
                L10n.of(context)!.playAlbumsInOrderDescription,
                style: TEXT_SMALL_SUBTITLE,
              ),
              isThreeLine: true,
            ),
          ),
          const Divider(),
          PercentageSlider(settingsStore),
          SettingsSection(text: L10n.of(context)!.miscellaneous),
          ListTile(
            title: Text(L10n.of(context)!.exportData),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => navStore.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const ExportPage(),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(L10n.of(context)!.saveLogFiles),
            subtitle: Text(
              L10n.of(context)!.saveLogFilesDescription,
              style: TEXT_SMALL_SUBTITLE,
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => _copyLogFilesToFolder(context),
          ),
          const Divider(),
          const BatteryOptimizationTile(),
          const Divider(
            height: 4.0,
          ),
          Observer(
            builder: (context) => SwitchListTile(
              value: settingsStore.manageExternalStorageGranted.value ?? false,
              onChanged: settingsStore.setManageExternalStorageGranted,
              title: Text(L10n.of(context)!.grantManagePermission),
              subtitle: Text(
                L10n.of(context)!.managePermissionSubtitle,
                style: TEXT_SMALL_SUBTITLE,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  void _showScanResult(BuildContext context, ScanResult result) {
    final l10n = L10n.of(context)!;

    if (result.permissionDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.warning_rounded, color: RED),
              const SizedBox(width: 16.0),
              Expanded(child: Text(l10n.scanPermissionDenied)),
            ],
          ),
          duration: const Duration(seconds: 10),
          showCloseIcon: true,
        ),
      );
      return;
    }

    final bool success = !result.hasFailures;
    final List<ScanFailure> failures = result.failures;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (success) const Icon(Icons.check_circle_rounded, color: GREEN),
            if (!success) const Icon(Icons.warning_rounded, color: Colors.amber),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                success ? l10n.scanSuccessful : l10n.scanFailed(result.failureCount),
              ),
            ),
          ],
        ),
        action: success
            ? null
            : SnackBarAction(
                label: l10n.scanErrorDetails,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => ScanFailuresPage(failures: failures),
                  ),
                ),
              ),
        duration: const Duration(seconds: 10),
        showCloseIcon: true,
      ),
    );
  }

  Future<void> _copyLogFilesToFolder(BuildContext context) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final logDir = Directory(p.join(appDir.path, 'logs'));
      final selectedPath = await FilePicker.getDirectoryPath();

      if (selectedPath == null || !await logDir.exists()) {
        return;
      }

      var folderName = 'mucke_logs';
      var targetDir = Directory(p.join(selectedPath, folderName));
      var counter = 0;
      while (await targetDir.exists()) {
        counter++;
        folderName = 'mucke_logs-$counter';
        targetDir = Directory(p.join(selectedPath, folderName));
      }
      await targetDir.create();

      await for (final entity in logDir.list()) {
        if (entity is File) {
          await entity.copy(p.join(targetDir.path, p.basename(entity.path)));
        }
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle_rounded, color: GREEN),
                const SizedBox(width: 16.0),
                Expanded(child: Text(L10n.of(context)!.logFilesSavedTo(targetDir.path))),
              ],
            ),
            duration: const Duration(seconds: 10),
            showCloseIcon: true,
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.warning_rounded, color: RED),
                const SizedBox(width: 16.0),
                Expanded(child: Text(L10n.of(context)!.logFilesSaveFailed)),
              ],
            ),
            duration: const Duration(seconds: 10),
            showCloseIcon: true,
          ),
        );
      }
    }
  }
}

class PercentageSlider extends StatefulWidget {
  const PercentageSlider(this.settingsStore, {super.key});

  final SettingsStore settingsStore;

  @override
  State<PercentageSlider> createState() => _PercentageSliderState();
}

class _PercentageSliderState extends State<PercentageSlider> {
  late double _value;
  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    _value = (widget.settingsStore.listenedPercentageStream.value ?? 50).toDouble();
    _streamSubscription = widget.settingsStore.listenedPercentageStream.listen(
      (value) => setState(() => _value = value.toDouble()),
    );
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: HORIZONTAL_PADDING,
            right: HORIZONTAL_PADDING,
            top: 16.0,
          ),
          child: Text(
            L10n.of(context)!.countSongsPlayed(_value.round()),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: HORIZONTAL_PADDING),
          child: Row(
            children: [
              const Text('1%'),
              Expanded(
                child: Slider(
                  value: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                  onChangeEnd: (value) {
                    widget.settingsStore.setListenedPercentage(value.round());
                  },
                  min: 1,
                  max: 99,
                ),
              ),
              const Text('99%'),
            ],
          ),
        ),
      ],
    );
  }
}
