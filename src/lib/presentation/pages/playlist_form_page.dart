import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/playlist.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../state/playlist_form_store.dart';
import '../theming.dart';
import '../widgets/cover_customization_card.dart';

class PlaylistFormPage extends StatefulWidget {
  const PlaylistFormPage({Key? key, this.playlist}) : super(key: key);

  final Playlist? playlist;

  @override
  _PlaylistFormPageState createState() => _PlaylistFormPageState();
}

class _PlaylistFormPageState extends State<PlaylistFormPage> {
  late PlaylistFormStore store;

  static const CARD_PADDING = 8.0;

  @override
  void initState() {
    store = GetIt.I<PlaylistFormStore>(param1: widget.playlist);
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
    final title =
        widget.playlist == null ? L10n.of(context)!.createPlaylist : L10n.of(context)!.editPlaylist;
    final NavigationStore navStore = GetIt.I<NavigationStore>();
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();

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
          if (widget.playlist != null)
            IconButton(
              icon: const Icon(Icons.delete_rounded),
              onPressed: () async {
                // TODO: this works, but may only pop back to the smartlist page...
                // can I use pop 2x here?
                await musicDataStore.removePlaylist(widget.playlist!);
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
