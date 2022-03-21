import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/artist.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../state/smart_list_form_store.dart';
import '../theming.dart';

class SmartListArtistsPage extends StatelessWidget {
  const SmartListArtistsPage({Key? key, required this.formStore}) : super(key: key);

  final SmartListFormStore formStore;

  @override
  Widget build(BuildContext context) {
    final store = formStore;
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();
    final initialSet = Set<Artist>.from(store.selectedArtists);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Select Artists',
            style: TEXT_HEADER,
          ),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              store.selectedArtists.clear();
              store.selectedArtists.addAll(initialSet);
              navStore.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () async {
                navStore.pop(context);
              },
            ),
          ],
          titleSpacing: 0.0,
        ),
        body: Observer(builder: (_) {
          final List<Artist> artists = musicDataStore.artistStream.value ?? [];
          final selectedArtists = store.selectedArtists.toSet();

          return Scrollbar(
            child: ListView.separated(
              itemCount: artists.length,
              itemBuilder: (_, int index) {
                final Artist artist = artists[index];
                return CheckboxListTile(
                  title: Text(artist.name),
                  value: selectedArtists.contains(artist),
                  onChanged: (bool? value) {
                    if (value != null) {
                      if (value) {
                        store.addArtist(artist);
                      } else {
                        store.removeArtist(artist);
                      }
                    }
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) => const SizedBox(
                height: 4.0,
              ),
            ),
          );
        }),
      ),
    );
  }
}
