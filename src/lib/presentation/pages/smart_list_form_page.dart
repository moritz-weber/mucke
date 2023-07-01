import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:reorderables/reorderables.dart';

import '../../constants.dart';
import '../../domain/entities/enums.dart';
import '../../domain/entities/smart_list.dart';
import '../l10n_utils.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../state/smart_list_form_store.dart';
import '../theming.dart';
import '../widgets/cover_customization_card.dart';
import '../widgets/switch_text_listtile.dart';
import 'smart_lists_artists_page.dart';

class SmartListFormPage extends StatefulWidget {
  const SmartListFormPage({Key? key, this.smartList}) : super(key: key);

  final SmartList? smartList;

  @override
  _SmartListFormPageState createState() => _SmartListFormPageState();
}

class _SmartListFormPageState extends State<SmartListFormPage> {
  late SmartListFormStore store;

  static const CARD_PADDING = 8.0;
  static const CARD_SPACING = 16.0;

  @override
  void initState() {
    store = GetIt.I<SmartListFormStore>(param1: widget.smartList);
    super.initState();
    store.setupValidations();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.smartList == null
        ? L10n.of(context)!.createSmartlist
        : L10n.of(context)!.editSmartlist;
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    final blockLevelTexts = <String>[
      L10n.of(context)!.excludeAllSongs,
      L10n.of(context)!.excludeInShuffle,
      L10n.of(context)!.excludeAlways,
      L10n.of(context)!.dontExclude,
    ];

    final playbackModeTexts = <String>[
      L10n.of(context)!.noShuffle,
      L10n.of(context)!.normalMode,
      L10n.of(context)!.shuffleMode,
      L10n.of(context)!.favShuffleMode,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TEXT_HEADER,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => navStore.pop(context),
        ),
        actions: [
          if (widget.smartList != null)
            IconButton(
              icon: const Icon(Icons.delete_rounded),
              onPressed: () async {
                await musicDataStore.removeSmartList(widget.smartList!);
                navStore.pop(context);
                navStore.pop(context);
              },
            ),
          IconButton(
            icon: const Icon(Icons.check_rounded),
            onPressed: () async {
              store.validateAll();
              if (!store.error.hasErrors) {
                await store.save();
                navStore.pop(context);
              }
            },
          ),
        ],
        titleSpacing: 0.0,
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
                          initialValue: store.name,
                          onChanged: (value) => store.name = value,
                          style: TEXT_HEADER,
                          decoration: InputDecoration(
                            labelText: L10n.of(context)!.name,
                            labelStyle: const TextStyle(color: Colors.white),
                            floatingLabelStyle: TEXT_HEADER_S.copyWith(color: Colors.white),
                            errorText:
                                store.error.name ? L10n.of(context)!.nameMustNotBeEmpty : null,
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
                    const SizedBox(height: 4.0),
                    Observer(
                      builder: (context) => CoverCustomizationCard(store: store.cover),
                    ),
                    const SizedBox(height: 8.0),
                    ListTile(
                      title: Text(L10n.of(context)!.filterSettings, style: TEXT_HEADER),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 2.0,
                          vertical: CARD_PADDING,
                        ),
                        child: Observer(
                          builder: (_) {
                            final RangeValues _currentRangeValues = RangeValues(
                              store.minLikeCount.toDouble(),
                              store.maxLikeCount.toDouble(),
                            );
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10.0,
                                    top: 4.0,
                                  ),
                                  child: Text(
                                    L10n.of(context)!.filterLikes(
                                      store.minLikeCount,
                                      store.maxLikeCount,
                                    ),
                                  ),
                                ),
                                RangeSlider(
                                  values: _currentRangeValues,
                                  min: 0,
                                  max: MAX_LIKE_COUNT.toDouble(),
                                  divisions: MAX_LIKE_COUNT,
                                  labels: RangeLabels(
                                    _currentRangeValues.start.round().toString(),
                                    _currentRangeValues.end.round().toString(),
                                  ),
                                  onChanged: (RangeValues values) {
                                    store.minLikeCount = values.start.toInt();
                                    store.maxLikeCount = values.end.toInt();
                                  },
                                ),
                              ],
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
                        child: Column(
                          children: [
                            Observer(
                              builder: (_) {
                                return SwitchTextListTile(
                                  title: L10n.of(context)!.minPlayCount,
                                  switchValue: store.minPlayCountEnabled,
                                  onSwitchChanged: (bool value) {
                                    store.minPlayCountEnabled = value;
                                  },
                                  textValue: store.minPlayCount,
                                  onTextChanged: (String value) {
                                    store.minPlayCount = value;
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: CARD_SPACING),
                            Observer(
                              builder: (_) {
                                return SwitchTextListTile(
                                  title: L10n.of(context)!.maxPlayCount,
                                  switchValue: store.maxPlayCountEnabled,
                                  onSwitchChanged: (bool value) {
                                    store.maxPlayCountEnabled = value;
                                  },
                                  textValue: store.maxPlayCount,
                                  onTextChanged: (String value) {
                                    store.maxPlayCount = value;
                                  },
                                );
                              },
                            ),
                          ],
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
                                    blockLevelTexts[value],
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  value: value,
                                  groupValue: store.blockLevel,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      if (newValue != null) store.blockLevel = newValue;
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
                        child: Column(
                          children: [
                            Observer(
                              builder: (_) {
                                return SwitchTextListTile(
                                  title: L10n.of(context)!.minYear,
                                  switchValue: store.minYearEnabled,
                                  onSwitchChanged: (bool value) {
                                    store.minYearEnabled = value;
                                  },
                                  textValue: store.minYear,
                                  onTextChanged: (String value) {
                                    store.minYear = value;
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: CARD_SPACING),
                            Observer(
                              builder: (_) {
                                return SwitchTextListTile(
                                  title: L10n.of(context)!.maxYear,
                                  switchValue: store.maxYearEnabled,
                                  onSwitchChanged: (bool value) {
                                    store.maxYearEnabled = value;
                                  },
                                  textValue: store.maxYear,
                                  onTextChanged: (String value) {
                                    store.maxYear = value;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: CARD_PADDING,
                        ),
                        child: Column(
                          children: [
                            Observer(
                              builder: (_) => GestureDetector(
                                onTap: () {
                                  navStore.push(
                                    context,
                                    MaterialPageRoute<Widget>(
                                      builder: (BuildContext context) =>
                                          SmartListArtistsPage(formStore: store),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 6.0,
                                    right: 8.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                store.excludeArtists
                                                    ? L10n.of(context)!.selectArtistsExclude(
                                                        store.selectedArtists.length)
                                                    : L10n.of(context)!.selectArtistsInclude(
                                                        store.selectedArtists.length),
                                              ),
                                              Text(
                                                L10n.of(context)!.includeAllArtists,
                                                style: TEXT_SMALL_SUBTITLE.copyWith(
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 56.0,
                                        child: Icon(Icons.chevron_right_rounded),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: CARD_SPACING),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0 - 4.0,
                                right: 8.0,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 60.0,
                                    child: Observer(
                                      builder: (_) {
                                        return Switch(
                                          value: store.excludeArtists,
                                          onChanged: (bool value) => store.excludeArtists = value,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 6.0),
                                  Text(L10n.of(context)!.excludeArtists),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ],
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
                            return SwitchTextListTile(
                              title: L10n.of(context)!.limitSongs,
                              switchValue: store.limitEnabled,
                              onSwitchChanged: (bool value) {
                                store.limitEnabled = value;
                              },
                              textValue: store.limit,
                              onTextChanged: (String value) {
                                store.limit = value;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ListTile(
                      title: Text(L10n.of(context)!.orderSettings, style: TEXT_HEADER),
                      subtitle: Text(L10n.of(context)!.orderSettingsDescription),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: CARD_PADDING,
                          horizontal: 8.0,
                        ),
                        child: Observer(
                          builder: (_) => ReorderableColumn(
                            children: List<Widget>.generate(
                              store.orderState.length,
                              (i) => Padding(
                                key: ValueKey(i),
                                padding: const EdgeInsets.symmetric(vertical: 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: DARK25,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: HORIZONTAL_PADDING - 8.0,
                                      vertical: 12.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Switch(
                                          value: store.orderState[i].enabled,
                                          onChanged: (bool value) =>
                                              store.setOrderEnabled(i, value),
                                        ),
                                        const SizedBox(width: 6.0),
                                        Text(store.orderState[i].orderCriterion.toText(context)),
                                        const Spacer(),
                                        IconButton(
                                          icon: store.orderState[i].orderDirection ==
                                                  OrderDirection.ascending
                                              ? const Icon(Icons.arrow_upward_rounded)
                                              : const Icon(Icons.arrow_downward_rounded),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6.0,
                                            vertical: 8.0,
                                          ),
                                          visualDensity: VisualDensity.compact,
                                          onPressed: () => store.toggleOrderDirection(i),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onReorder: (oldIndex, newIndex) =>
                                store.reorderOrderState(oldIndex, newIndex),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ListTile(
                      title: Text(L10n.of(context)!.playbackMode, style: TEXT_HEADER),
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
                                    playbackModeTexts[value],
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  value: value,
                                  groupValue: store.shuffleModeIndex,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      if (newValue != null) store.setShuffleModeIndex(newValue);
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
