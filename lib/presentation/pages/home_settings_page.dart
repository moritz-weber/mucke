import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../state/navigation_store.dart';
import '../theming.dart';

class HomeSettingsPage extends StatelessWidget {
  const HomeSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home Settings',
            style: TEXT_HEADER,
          ),
          leading: IconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            onPressed: () => navStore.pop(context),
          ),
          actions: [
            IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () => navStore.pop(context),
          ),
          ],
        ),
      ),
    );
  }
}
