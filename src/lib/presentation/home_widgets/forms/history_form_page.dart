import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/home_widgets/history.dart';
import '../../state/home_widget_forms/history_form_store.dart';
import '../../state/navigation_store.dart';
import '../../theming.dart';

class HistoryFormPage extends StatefulWidget {
  const HistoryFormPage({Key? key, required this.history}) : super(key: key);

  final HomeHistory history;

  @override
  _HistoryFormPageState createState() => _HistoryFormPageState();
}

class _HistoryFormPageState extends State<HistoryFormPage> {
  late HistoryFormStore store;

  static const CARD_PADDING = 8.0;

  @override
  void initState() {
    store = GetIt.I<HistoryFormStore>(param1: widget.history);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            L10n.of(context)!.history,
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
                // store.validateAll();
                // if (!store.error.hasErrors) {
                await store.save();
                navStore.pop(context);
                // }
              },
            ),
          ],
        ),
        body: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
          child: Scrollbar(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: 16.0),
                      ListTile(
                        title: Text(L10n.of(context)!.displaySettings, style: TEXT_HEADER),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: CARD_PADDING,
                          ),
                          child: Observer(
                            builder: (_) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Colors.transparent,
                                        height: 48.0,
                                        child: Text(L10n.of(context)!.maxNumberEntries),
                                        alignment: Alignment.centerLeft,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 56.0,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        initialValue: widget.history.maxEntries.toString(),
                                        onChanged: (value) {
                                          store.maxEntries = value;
                                        },
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(color: Colors.white),
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
                                            left: 4.0,
                                            right: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
      ),
    );
  }
}
