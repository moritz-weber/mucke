import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/smart_list.dart';
import '../state/settings_store.dart';
import '../theming.dart';
import 'smart_lists_form_page.dart';

class SmartListsPage extends StatelessWidget {
  const SmartListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Smart lists',
            style: TEXT_HEADER,
          ),
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const SmartListFormPage(),
                ),
              ),
            ),
          ],
          titleSpacing: 0.0,
        ),
        body: Observer(
          builder: (context) {
            final smartLists = settingsStore.smartListsStream.value ?? [];
            return ListView.separated(
              itemCount: smartLists.length,
              itemBuilder: (_, int index) {
                final SmartList smartList = smartLists[index];
                return ListTile(
                  title: Text(smartList.name),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => SmartListFormPage(smartList: smartList),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => settingsStore.removeSmartList(smartList),
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
