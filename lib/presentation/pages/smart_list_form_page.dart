import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:reorderables/reorderables.dart';

import '../../constants.dart';
import '../../domain/entities/enums.dart';
import '../../domain/entities/smart_list.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../state/smart_list_form_store.dart';
import '../theming.dart';
import '../widgets/playlist_cover.dart';
import '../widgets/switch_text_listtile.dart';
import 'cover_customization_page.dart';
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
    final title = widget.smartList == null ? 'Create smart list' : 'Edit smart list';
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    const blockLevelTexts = <String>[
      'Exclude all songs marked for exclusion.',
      'Exclude songs marked for exclusion in shuffle mode.',
      'Exclude only songs marked as always exclude.',
      "Don't exclude any songs.",
    ];

    const playbackModeTexts = <String>[
      'None (keep currently active shuffle mode)',
      'Normal mode',
      'Shuffle mode',
      'Favorite shuffle mode',
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TEXT_HEADER,
          ),
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => navStore.pop(context),
          ),
          actions: [
            if (widget.smartList != null)
              IconButton(
                icon: const Icon(Icons.delete_rounded),
                onPressed: () async {
                  // TODO: this works, but may only pop back to the smart list page...
                  // can I use pop 2x here?
                  await musicDataStore.removeSmartList(widget.smartList!);
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
                              labelText: 'Name',
                              labelStyle: const TextStyle(color: Colors.white),
                              floatingLabelStyle: TEXT_HEADER_S.copyWith(color: Colors.white),
                              errorText: store.error.name,
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
                        builder: (context) => Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: CARD_PADDING,
                              horizontal: 10.0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => CoverCustomizationPage(
                                      store: store.cover,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    PlaylistCover(
                                      size: 64.0,
                                      gradient: store.cover.gradient,
                                      icon: store.cover.icon,
                                    ),
                                    const SizedBox(width: 16.0),
                                    const Text('Customize cover image'),
                                    const Spacer(),
                                    const SizedBox(
                                      width: 56.0,
                                      child: Icon(Icons.chevron_right_rounded),
                                    ),
                                    const SizedBox(width: 6.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const ListTile(
                        title: Text('Filter Settings', style: TEXT_HEADER),
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
                                      'Likes between ${store.minLikeCount} and ${store.maxLikeCount}',
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
                                    title: 'Minimum play count',
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
                                    title: 'Maximum play count',
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
                          child: Column(
                            children: [
                              Observer(
                                builder: (_) {
                                  return SwitchTextListTile(
                                    title: 'Minimum skip count',
                                    switchValue: store.minSkipCountEnabled,
                                    onSwitchChanged: (bool value) {
                                      store.minSkipCountEnabled = value;
                                    },
                                    textValue: store.minSkipCount,
                                    onTextChanged: (String value) {
                                      store.minSkipCount = value;
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: CARD_SPACING),
                              Observer(
                                builder: (_) {
                                  return SwitchTextListTile(
                                    title: 'Maximum skip count',
                                    switchValue: store.maxSkipCountEnabled,
                                    onSwitchChanged: (bool value) {
                                      store.maxSkipCountEnabled = value;
                                    },
                                    textValue: store.maxSkipCount,
                                    onTextChanged: (String value) {
                                      store.maxSkipCount = value;
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
                                    title: 'Minimum year',
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
                                    title: 'Maximum year',
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
                                      right: HORIZONTAL_PADDING,
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 60.0 + 6.0, height: 48.0),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Select artists to ${store.excludeArtists ? "exclude" : "include"}: ${store.selectedArtists.length} selected.',
                                            ),
                                            Text(
                                              'Include all artists if none are selected.',
                                              style: TEXT_SMALL_SUBTITLE.copyWith(
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
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
                                  left: 6.0,
                                  right: HORIZONTAL_PADDING,
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
                                    const Text('Exclude selected artists'),
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
                                title: 'Limit number of songs',
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
                      const ListTile(
                        title: Text('Order Settings', style: TEXT_HEADER),
                        subtitle: Text('Reorder options to change priorities.'),
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
                                          Text(store.orderState[i].text),
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
                      const ListTile(
                        title: Text('Default Playback Settings', style: TEXT_HEADER),
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
      ),
    );
  }
}
