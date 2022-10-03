import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/home_widgets/shuffle_all.dart';
import '../../../domain/entities/shuffle_mode.dart';
import '../../state/home_widget_forms/shuffleall_form_store.dart';
import '../../state/navigation_store.dart';
import '../../theming.dart';

class ShuffleAllFormPage extends StatefulWidget {
  const ShuffleAllFormPage({Key? key, required this.shuffleAll}) : super(key: key);

  final HomeShuffleAll shuffleAll;

  @override
  _ShuffleAllFormPageState createState() => _ShuffleAllFormPageState();
}

class _ShuffleAllFormPageState extends State<ShuffleAllFormPage> {
  late ShuffleAllFormStore store;

  static const CARD_PADDING = 8.0;

  @override
  void initState() {
    store = GetIt.I<ShuffleAllFormStore>(param1: widget.shuffleAll);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    const playbackModeTexts = <String>[
      'Normal Mode',
      'Shuffle Mode',
      'Favorite Shuffle Mode',
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Shuffle All Widget',
            style: TEXT_HEADER,
          ),
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
                      const ListTile(
                        title: Text('Playback Settings', style: TEXT_HEADER),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: CARD_PADDING,
                          ),
                          child: Observer(
                            builder: (_) {
                              return Column(
                                children: <int>[1, 2].map<RadioListTile<int>>(
                                  (int value) {
                                    return RadioListTile<int>(
                                      title: Text(
                                        playbackModeTexts[value],
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      value: value,
                                      groupValue: store.shuffleMode.index,
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          if (newValue != null) store.shuffleMode = ShuffleMode.values[newValue];
                                        });
                                      },
                                    );
                                  },
                                ).toList(),
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
