import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mucke/l10n/localizations.dart';

import '../../../domain/entities/home_widgets/whats_new.dart';
import '../../state/home_widget_forms/whats_new_form_store.dart';
import '../../state/navigation_store.dart';
import '../../theming.dart';

class WhatsNewFormPage extends StatefulWidget {
  const WhatsNewFormPage({Key? key, required this.whatsNew}) : super(key: key);

  final HomeWhatsNew whatsNew;

  @override
  _WhatsNewFormPageState createState() => _WhatsNewFormPageState();
}

class _WhatsNewFormPageState extends State<WhatsNewFormPage> {
  late WhatsNewFormStore store;

  static const CARD_PADDING = 8.0;

  @override
  void initState() {
    store = GetIt.I<WhatsNewFormStore>(param1: widget.whatsNew);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n.of(context)!.whatsNew,
          style: TEXT_HEADER,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => navStore.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_rounded),
            onPressed: () async {
              await store.save();
              navStore.pop(context);
            },
          ),
        ],
      ),
      body: ListTileTheme(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
        child: Scrollbar(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 16.0),
                    ListTile(
                      title: Text(L10n.of(context)!.displaySettings,
                          style: TEXT_HEADER),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: CARD_PADDING,
                        ),
                        child: Observer(
                          builder: (_) {
                            return SwitchListTile(
                              value: store.autoDismiss,
                              onChanged: (bool value) =>
                                  store.autoDismiss = value,
                              title:
                                  Text(L10n.of(context)!.autoDismissWhatsNew),
                              subtitle: Text(
                                L10n.of(context)!
                                    .autoDismissWhatsNewDescription,
                                style: TEXT_SMALL_SUBTITLE,
                              ),
                              isThreeLine: true,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
