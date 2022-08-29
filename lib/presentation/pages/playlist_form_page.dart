import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/playlist.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../state/playlist_form_store.dart';
import '../theming.dart';
import '../widgets/playlist_cover.dart';
import 'cover_customization_page.dart';

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
    final title = widget.playlist == null ? 'Create smart list' : 'Edit smart list';
    final NavigationStore navStore = GetIt.I<NavigationStore>();
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();

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
            if (widget.playlist != null)
              IconButton(
                icon: const Icon(Icons.delete_rounded),
                onPressed: () async {
                  // TODO: this works, but may only pop back to the smart list page...
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
