import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

import '../pages/cover_customization_page.dart';
import '../state/cover_customization_store.dart';
import 'playlist_cover.dart';

class CoverCustomizationCard extends StatelessWidget {
  const CoverCustomizationCard({
    Key? key,
    required this.store,
  }) : super(key: key);

  final CoverCustomizationStore store;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => CoverCustomizationPage(
                  store: store,
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
                  gradient: store.gradient,
                  icon: store.icon,
                ),
                const SizedBox(width: 16.0),
                Text(L10n.of(context)!.customizeCover),
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
    );
  }
}
