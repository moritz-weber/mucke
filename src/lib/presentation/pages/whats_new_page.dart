import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mucke/l10n/localizations.dart';

import '../release_notes/release_notes.dart';
import '../state/navigation_store.dart';
import '../theming.dart';

/// Height of the version header row. The timeline dot is centered in a box of
/// this height so that it lines up with the version number.
const double _HEADER_HEIGHT = 32.0;

class WhatsNewPage extends StatelessWidget {
  const WhatsNewPage({Key? key, required this.version}) : super(key: key);

  /// The version that is marked as current in the timeline.
  final String version;

  @override
  Widget build(BuildContext context) {
    final NavigationStore navStore = GetIt.I<NavigationStore>();
    final L10n l10n = L10n.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.whatsNew,
          style: TEXT_HEADER,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => navStore.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8.0, bottom: 24.0, left: 12.0),
        itemCount: RELEASE_NOTES.length,
        itemBuilder: (context, index) {
          final releaseNote = RELEASE_NOTES[index];
          return _ReleaseNoteEntry(
            releaseNote: releaseNote,
            isLast: index == RELEASE_NOTES.length - 1,
          );
        },
      ),
    );
  }
}

class _ReleaseNoteEntry extends StatelessWidget {
  const _ReleaseNoteEntry({
    required this.releaseNote,
    required this.isLast,
  });

  final ReleaseNote releaseNote;
  final bool isLast;

  @override
  Widget build(BuildContext context) {

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 32.0,
            child: Column(
              children: [
                // The dot is centered in a box of the same height as the
                // version header so that both line up.
                SizedBox(
                  height: _HEADER_HEIGHT,
                  child: Center(
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: DARK4,
                      ),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2.0,
                      color: DARK4,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: HORIZONTAL_PADDING),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: _HEADER_HEIGHT,
                    child: Text(
                      releaseNote.version,
                      style: TEXT_BIG,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    releaseNote.date,
                    style: TEXT_SMALL_SUBTITLE,
                  ),
                  const SizedBox(height: 12.0),
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final section in releaseNote.sections)
                            _ReleaseNoteSectionView(section: section),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReleaseNoteSectionView extends StatelessWidget {
  const _ReleaseNoteSectionView({required this.section});

  final ReleaseNoteSection section;

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context)!;

    final (String label, Color color) = switch (section.category) {
      ReleaseNoteCategory.added => (l10n.releaseNoteAdded, LIGHT2),
      ReleaseNoteCategory.changed => (l10n.releaseNoteChanged, Colors.white),
      ReleaseNoteCategory.fixed => (l10n.releaseNoteFixed, Colors.white38),
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Badge(text: label, color: color),
              const SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  height: 1.0,
                  color: DARK4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          for (final entry in section.entries)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0, right: 8.0),
                    child: Text(
                      '•',
                      style: TextStyle(color: color),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      entry,
                      style: const TextStyle(fontSize: 14.0, height: 1.35),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
