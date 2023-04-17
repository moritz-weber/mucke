import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/enums.dart';
import '../../../domain/entities/home_widgets/playlists.dart';
import '../../state/home_widget_forms/playlists_form_store.dart';
import '../../state/navigation_store.dart';
import '../../theming.dart';
import '../../widgets/switch_text_listtile.dart';

class PlaylistsFormPage extends StatefulWidget {
  const PlaylistsFormPage({Key? key, required this.playlists}) : super(key: key);

  final HomePlaylists playlists;

  @override
  _PlaylistsFormPageState createState() => _PlaylistsFormPageState();
}

class _PlaylistsFormPageState extends State<PlaylistsFormPage> {
  late PlaylistsFormStore store;

  static const CARD_PADDING = 8.0;

  @override
  void initState() {
    store = GetIt.I<PlaylistsFormStore>(param1: widget.playlists);
    super.initState();
    // store.setupValidations();
  }

  @override
  void dispose() {
    // store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    final orderCriterionTexts = <String>[
      L10n.of(context)!.name,
      L10n.of(context)!.creationDate,
      L10n.of(context)!.changeDate,
      L10n.of(context)!.lastTimePlayed,
    ];

    final orderDirectionTexts = <String>[
      L10n.of(context)!.ascending,
      L10n.of(context)!.descending,
    ];

    final filterTexts = <String>[
      L10n.of(context)!.both,
      L10n.of(context)!.playlistsOnly,
      L10n.of(context)!.smartlistsOnly,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n.of(context)!.playlists,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Observer(
                        builder: (_) => TextFormField(
                          initialValue: store.title,
                          onChanged: (value) => store.title = value,
                          style: TEXT_HEADER,
                          decoration: InputDecoration(
                            labelText: L10n.of(context)!.name,
                            labelStyle: const TextStyle(color: Colors.white),
                            floatingLabelStyle: TEXT_HEADER_S.copyWith(color: Colors.white),
                            // errorText: store.error.name,
                            errorStyle: const TextStyle(color: RED),
                            filled: true,
                            fillColor: DARK35,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ListTile(
                      title: Text(L10n.of(context)!.sortingFilterSettings, style: TEXT_HEADER),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: CARD_PADDING,
                        ),
                        child: Observer(
                          builder: (_) {
                            return SwitchTextListTile(
                              title: L10n.of(context)!.maxNumberEntries,
                              switchValue: store.maxEntriesEnabled,
                              onSwitchChanged: (bool value) {
                                store.maxEntriesEnabled = value;
                              },
                              textValue: store.maxEntries,
                              onTextChanged: (String value) {
                                store.maxEntries = value;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: CARD_PADDING,
                        ),
                        child: Observer(
                          builder: (_) {
                            return Column(
                              children: <int>[0, 1, 2, 3].map<RadioListTile<int>>((int value) {
                                return RadioListTile<int>(
                                  title: Text(
                                    orderCriterionTexts[value],
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  value: value,
                                  groupValue: store.orderCriterion.index,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      if (newValue != null)
                                        store.orderCriterion =
                                            HomePlaylistsOrder.values[newValue];
                                    });
                                  },
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: CARD_PADDING,
                        ),
                        child: Observer(
                          builder: (_) {
                            return Column(
                              children: <int>[0, 1].map<RadioListTile<int>>((int value) {
                                return RadioListTile<int>(
                                  title: Text(
                                    orderDirectionTexts[value],
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  value: value,
                                  groupValue: store.orderDirection.index,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      if (newValue != null)
                                        store.orderDirection = OrderDirection.values[newValue];
                                    });
                                  },
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: CARD_PADDING,
                        ),
                        child: Observer(
                          builder: (_) {
                            return Column(
                              children: <int>[0, 1, 2].map<RadioListTile<int>>((int value) {
                                return RadioListTile<int>(
                                  title: Text(
                                    filterTexts[value],
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  value: value,
                                  groupValue: store.filter.index,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      if (newValue != null)
                                        store.filter = HomePlaylistsFilter.values[newValue];
                                    });
                                  },
                                );
                              }).toList(),
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
