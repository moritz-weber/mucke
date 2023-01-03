import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../state/navigation_store.dart';
import '../state/settings_store.dart';
import '../theming.dart';

class BlockedFilesPage extends StatelessWidget {
  const BlockedFilesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Blocked Files',
            style: TEXT_HEADER,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            onPressed: () => navStore.pop(context),
          ),
          titleSpacing: 0.0,
        ),
        body: Observer(
          builder: (context) {
            final paths = settingsStore.blockedFilesStream.value?.toList() ?? [];
            return ListView.separated(
              itemCount: paths.length,
              itemBuilder: (_, int index) {
                final String path = paths[index];
                final split = path.split('/');
                return ListTile(
                  title: Text(split.last),
                  subtitle: Text(
                    split.sublist(0, split.length - 1).join('/'),
                    style: TEXT_SMALL_SUBTITLE,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_rounded),
                    onPressed: () => settingsStore.removeBlockedFiles([path]),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const SizedBox(
                height: 4.0,
              ),
            );
          },
        ),
      ),
    );
  }
}
