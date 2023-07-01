// THIS PAGE IS CURRENTLY NOT USED!


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../state/import_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';
import '../widgets/settings_section.dart';

class ImportPage extends StatefulWidget {
  const ImportPage({Key? key, required this.importPath}) : super(key: key);

  final String importPath;

  @override
  State<ImportPage> createState() => _ImportPageState();
}

class _ImportPageState extends State<ImportPage> {
  late final ImportStore _importStore;
  late final NavigationStore _navStore;

  @override
  void initState() {
    _importStore = GetIt.I<ImportStore>(param1: widget.importPath);
    _navStore = GetIt.I<NavigationStore>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Import Data',
          style: TEXT_HEADER,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => _navStore.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file_rounded),
            onPressed: () => {}, //_importData(context),
          ),
        ],
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Observer(builder: (context) {
          //   final dataInfo = _importStore.appData;
          //   if (dataInfo == null) {
          //     return Container();
          //   }
          //   return Card(
          //     margin: const EdgeInsets.fromLTRB(HORIZONTAL_PADDING, 16.0, HORIZONTAL_PADDING, 0),
          //     child: Padding(
          //       padding: const EdgeInsets.all(12.0),
          //       child: Row(
          //         children: [
          //           const Icon(Icons.info_rounded),
          //           const SizedBox(width: 12.0),
          //           Expanded(
          //             child: Text(
          //               '${dataInfo.appVersion}, ${dataInfo.buildNumber}, ${dataInfo.dbVersion}',
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   );
          // }),
          // SettingsSection(text: 'Library'),
          // CheckboxListTile(
          //   title: Text('Songs, Albums, and Artists'),
          //   value: true,
          //   onChanged: (value) => {},
          // ),
          // const Divider(),
          // CheckboxListTile(
          //   title: Text('Smartlists'),
          //   value: true,
          //   onChanged: (value) => {},
          // ),
          // const Divider(),
          // CheckboxListTile(
          //   title: Text('Playlists'),
          //   value: true,
          //   onChanged: (value) => {},
          // ),
          // const Divider(),
          // CheckboxListTile(
          //   title: Text('History'),
          //   value: true,
          //   onChanged: (value) => {},
          // ),
          // SettingsSection(text: 'Library Settings'),
          // CheckboxListTile(
          //   title: Text('Library folders'),
          //   value: true,
          //   onChanged: (value) => {},
          // ),
          // const Divider(),
          // CheckboxListTile(
          //   title: Text('Allowed extensions'),
          //   value: true,
          //   onChanged: (value) => {},
          // ),
          // const Divider(),
          // CheckboxListTile(
          //   title: Text('Blocked songs'),
          //   value: true,
          //   onChanged: (value) => {},
          // ),
          // SettingsSection(text: 'General Settings'),
          // CheckboxListTile(
          //   title: Text('Home page settings'),
          //   value: false,
          //   enabled: false,
          //   onChanged: (value) => {},
          // ),
          // const Divider(),
          // Observer(
          //   builder: (context) {
          //     return CheckboxListTile(
          //       title: Text('Other settings'),
          //       value: _importStore.generalSettings,
          //       enabled: _importStore.appData?.generalSettings != null,
          //       onChanged: (value) {
          //         if (value != null) _importStore.setGeneralSettings(value);
          //       },
          //     );
          //   }
          // ),
          // const SizedBox(height: HORIZONTAL_PADDING),
        ],
      ),
    );
  }

  // Future<void> _importData(BuildContext context) async {
  //   try {
  //     final success = await _importStore.importData();
  //     // TODO: loading animation
  //     _navStore.pop(context);
  //     if (success != null)
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Row(
  //             children: [
  //               if (success) const Icon(Icons.check_circle_rounded, color: GREEN),
  //               if (!success) const Icon(Icons.warning_rounded, color: RED),
  //               const SizedBox(width: 16.0),
  //               if (success) const Expanded(child: Text('Successfully imported data.')),
  //               if (!success) const Expanded(child: Text('Data import failed!')),
  //             ],
  //           ),
  //           duration: const Duration(seconds: 5),
  //           showCloseIcon: true,
  //         ),
  //       );
  //   } on PlatformException catch (e) {
  //     print('Unsupported operation' + e.toString());
  //   } catch (ex) {
  //     print(ex);
  //   }
  // }
}
