import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../defaults.dart';
import '../../state/import_store.dart';
import '../../state/music_data_store.dart';
import '../../state/settings_store.dart';
import '../../theming.dart';
import '../../widgets/settings_section.dart';

class InitLibPage extends StatelessWidget {
  const InitLibPage({Key? key, required this.importStore}) : super(key: key);

  final ImportStore importStore;

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();

    final TextEditingController _textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n.of(context)!.setupLibrary,
          style: TEXT_HEADER,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: Container(
        color: DARK3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Observer(builder: (_) {
              if (musicDataStore.isUpdatingDatabase) {
                return const LinearProgressIndicator();
              }
              return Container();
            }),
            Observer(builder: (_) {
              final int artistCount = musicDataStore.artistStream.value?.length ?? 0;
              final int albumCount = musicDataStore.albumStream.value?.length ?? 0;
              final int songCount = musicDataStore.songStream.value?.length ?? 0;
              return ListTile(
                title: Text(L10n.of(context)!.yourLibrary),
                subtitle: Text(
                  L10n.of(context)!.artistsAlbumsSongs(artistCount, albumCount, songCount),
                ),
                trailing: Observer(
                  builder: (context) {
                    final folders = settingsStore.libraryFoldersStream.value;
                    final isNotActive = folders == null || folders.isEmpty;
                    if (!importStore.scanned)
                      return ElevatedButton(
                        child: Text(L10n.of(context)!.scan),
                        onPressed: isNotActive
                            ? null
                            : () => musicDataStore
                                .updateDatabase()
                                .then((_) => importStore.scanned = true),
                      );
                    return OutlinedButton(
                      child: Text(L10n.of(context)!.scan),
                      onPressed: isNotActive ? null : () => musicDataStore.updateDatabase(),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              SettingsSection(text: L10n.of(context)!.libraryFolders),
              Observer(
                builder: (context) {
                  final appData = importStore.appData;
                  final folders = importStore.libraryFolders;
                  if (appData == null || folders == null || folders.isEmpty) {
                    return Container();
                  }
                  return Column(
                    children: [
                      for (final folder in folders)
                        ListTile(
                          title: Text(folder),
                          trailing: IconButton(
                            icon: importStore.addedLibraryFolders.contains(folder)
                                ? const Icon(Icons.delete_rounded)
                                : const Icon(Icons.add_circle_rounded),
                            onPressed: () {
                              if (importStore.addedLibraryFolders.contains(folder)) {
                                importStore.addedLibraryFolders.remove(folder);
                                settingsStore.removeLibraryFolder(folder);
                              } else {
                                importStore.addedLibraryFolders.add(folder);
                                settingsStore.addLibraryFolder(folder);
                              }
                            },
                          ),
                        )
                    ],
                  );
                },
              ),
              Observer(
                builder: (context) {
                  final folders = settingsStore.libraryFoldersStream.value;
                  if (folders == null || folders.isEmpty) {
                    return Container();
                  }
                  return Column(
                    children: [
                      for (final folder in folders)
                        if (!importStore.addedLibraryFolders.contains(folder))
                          ListTile(
                            title: Text(folder),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_rounded),
                              onPressed: () => settingsStore.removeLibraryFolder(folder),
                            ),
                          )
                    ],
                  );
                },
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
                child: Observer(builder: (context) {
                  final folders = settingsStore.libraryFoldersStream.value;
                  return Row(
                    children: [
                      if (folders == null || folders.isEmpty)
                        Text(L10n.of(context)!.noFoldersSelected),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () => _openFilePicker(settingsStore),
                        child: Text(L10n.of(context)!.addFolder),
                      ),
                    ],
                  );
                }),
              ),
              SettingsSection(text: L10n.of(context)!.allowedFileExtensions),
              Observer(
                builder: (context) {
                  final allowedExtensions = importStore.allowedExtensions;

                  if (allowedExtensions != null) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        title: Text(L10n.of(context)!.availableFromImport),
                        subtitle: Text(allowedExtensions),
                        trailing: ElevatedButton(
                          onPressed: () {
                            _textController.text = allowedExtensions;
                            settingsStore.setFileExtensions(allowedExtensions);
                          },
                          child: Text(L10n.of(context)!.use),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  HORIZONTAL_PADDING,
                  8.0,
                  HORIZONTAL_PADDING,
                  4.0,
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
              ListTile(
                title: Text(
                  L10n.of(context)!.allowedFileExtensionsDescription,
                  style: TEXT_SMALL_SUBTITLE,
                ),
              ),
              Observer(
                builder: (context) {
                  final importBlockedFiles = importStore.blockedFiles;
                  final blockedFiles = settingsStore.blockedFilesStream.value;

                  if (importBlockedFiles == null || blockedFiles == null || importBlockedFiles.isEmpty) return Container();

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingsSection(text: L10n.of(context)!.blockedFiles),
                      ListTile(
                        title: Text(
                          L10n.of(context)!.blockedFilesDescription,
                          style: TEXT_SMALL_SUBTITLE,
                        ),
                      ),
                      for (final path in importBlockedFiles)
                        CheckboxListTile(
                          title: Text(path),
                          value: blockedFiles.contains(path),
                          onChanged: (value) {
                            if (value == null) return;
                            if (value)
                              settingsStore.addBlockedFiles([path], delete: false);
                            else
                              settingsStore.removeBlockedFiles([path]);
                          },
                        )
                    ],
                  );
                },
              ),
              const SizedBox(height: HORIZONTAL_PADDING),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openFilePicker(SettingsStore store) async {
    try {
      store.addLibraryFolder(await FilePicker.platform.getDirectoryPath());
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (ex) {
      print(ex);
    }
  }
}
