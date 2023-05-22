import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../state/export_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';
import '../widgets/settings_section.dart';

class ExportPage extends StatefulWidget {
  const ExportPage({Key? key}) : super(key: key);

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  late final ExportStore _exportStore;
  late final NavigationStore _navStore;

  @override
  void initState() {
    _exportStore = GetIt.I<ExportStore>();
    _navStore = GetIt.I<NavigationStore>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Export Data',
          style: TEXT_HEADER,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => _navStore.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt_rounded),
            onPressed: () => _exportData(context),
          ),
        ],
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.fromLTRB(HORIZONTAL_PADDING, 16.0, HORIZONTAL_PADDING, 0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(Icons.info_rounded),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      'Select the data you want to export. By default, everything is exported. When exporting, you can select a folder for the file to be stored.',
                    ),
                  ),
                ],
              ),
            ),
          ),
          SettingsSection(text: 'Library'),
          CheckboxListTile(
            title: Text('Songs, Albums, and Artists'),
            value: true,
            onChanged: (value) => {},
          ),
          const Divider(),
          CheckboxListTile(
            title: Text('Smartlists'),
            value: true,
            onChanged: (value) => {},
          ),
          const Divider(),
          CheckboxListTile(
            title: Text('Playlists'),
            value: true,
            onChanged: (value) => {},
          ),
          const Divider(),
          CheckboxListTile(
            title: Text('History'),
            value: true,
            onChanged: (value) => {},
          ),
          SettingsSection(text: 'Library Settings'),
          CheckboxListTile(
            title: Text('Library folders'),
            value: true,
            onChanged: (value) => {},
          ),
          const Divider(),
          CheckboxListTile(
            title: Text('Allowed extensions'),
            value: true,
            onChanged: (value) => {},
          ),
          const Divider(),
          CheckboxListTile(
            title: Text('Blocked songs'),
            value: true,
            onChanged: (value) => {},
          ),
          SettingsSection(text: 'General Settings'),
          CheckboxListTile(
            title: Text('Home page settings'),
            value: true,
            onChanged: (value) => {},
          ),
          const Divider(),
          Observer(
            builder: (context) {
              return CheckboxListTile(
                title: Text('Other settings'),
                value: _exportStore.generalSettings,
                onChanged: (value) => _exportStore.setGeneralSettings(value ?? false),
              );
            }
          ),
          const SizedBox(height: HORIZONTAL_PADDING),
        ],
      ),
    );
  }

  Future<void> _exportData(BuildContext context) async {
    try {
      final path = await _exportStore.exportData(await FilePicker.platform.getDirectoryPath());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              if (path != null) const Icon(Icons.check_circle_rounded, color: GREEN),
              if (path == null) const Icon(Icons.warning_rounded, color: RED),
              const SizedBox(width: 16.0),
              if (path != null) Expanded(child: Text('Data exported to:\n$path')),
              if (path == null) const Expanded(child: Text('Data export failed!')),
            ],
          ),
          duration: const Duration(seconds: 10),
          showCloseIcon: true,
        ),
      );
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (ex) {
      print(ex);
    }
  }
}
