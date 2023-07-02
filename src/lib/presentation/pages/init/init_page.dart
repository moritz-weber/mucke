import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:get_it/get_it.dart';

import '../../state/navigation_store.dart';
import '../../theming.dart';
import 'init_workflow.dart';

class InitPage extends StatelessWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('InitPage.build');
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    return Scaffold(
      body: Container(
        color: DARK1,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: HORIZONTAL_PADDING, bottom: 2 * HORIZONTAL_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(HORIZONTAL_PADDING),
                  child: Text(
                    L10n.of(context)!.welcomeToMucke,
                    style: const TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.4,
                      height: 1.05,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 128,
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                  ),
                ),
                const Spacer(),
                const Divider(),
                ListTile(
                  title: Text(L10n.of(context)!.setupLibrary),
                  subtitle: Text(
                    L10n.of(context)!.setupLibraryDescription,
                    style: TEXT_SMALL_SUBTITLE,
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const InitWorkflow(),
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: Text(L10n.of(context)!.importData),
                  subtitle: Text(
                    L10n.of(context)!.importDataDescription,
                    style: TEXT_SMALL_SUBTITLE,
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => _importData(context, navStore),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _importData(BuildContext context, NavigationStore navStore) async {
    try {
      final pickResult = await FilePicker.platform.pickFiles(
        allowedExtensions: ['json'],
        type: FileType.custom,
      );
      if (pickResult != null) {
        final importPath = pickResult.paths.first!;

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => InitWorkflow(importPath: importPath),
          ),
        );
      }
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (ex) {
      print(ex);
    }
  }
}
