/// The kind of change a release note entry describes.
enum ReleaseNoteCategory {
  added,
  changed,
  fixed,
}

/// A group of entries of the same [ReleaseNoteCategory] within a release.
class ReleaseNoteSection {
  const ReleaseNoteSection(this.category, this.entries);

  final ReleaseNoteCategory category;
  final List<String> entries;
}

/// The release notes of one app version.
class ReleaseNote {
  const ReleaseNote({
    required this.version,
    required this.date,
    required this.sections,
  });

  final String version;

  /// Release date in `YYYY-MM-DD` format.
  final String date;

  final List<ReleaseNoteSection> sections;
}

/// All release notes, newest first.
///
/// The entry whose [ReleaseNote.version] matches the installed app version 
/// triggers the home widget on upgrade.
///
/// The texts are intentionally not localized.
const List<ReleaseNote> RELEASE_NOTES = [
  ReleaseNote(
    version: 'Unreleased',
    date: '2026-10-XX',
    sections: [
      ReleaseNoteSection(ReleaseNoteCategory.added, [
        'View lyrics from metadata and .lrc files, including synced lyrics. Perform a library re-scan to add them to the library. Note: SYLT frames are currently not supported.',
        'A "What\'s new" widget and page that lists the changes of every release.',
        'Monochrome and themed app icon.',
        'Estonian translation.',
      ]),
      ReleaseNoteSection(ReleaseNoteCategory.fixed, [
        'Queue length did not update in certain scenarios.',
        'Library scanning on older Android versions.',
      ]),
    ],
  ),
  ReleaseNote(
    version: '1.6.0',
    date: '2026-08-16',
    sections: [
      ReleaseNoteSection(ReleaseNoteCategory.added, [
        'Android Auto support: play smartlists, playlists, and all songs.',
        'Image files are scanned as part of the library.',
        'Turkish, Dutch, Indonesian, Polish, Portuguese, and Tamil translations.',
      ]),
      ReleaseNoteSection(ReleaseNoteCategory.fixed, [
        'Issues on Android 14 and newer.',
      ]),
    ],
  ),
  ReleaseNote(
    version: '1.5.1',
    date: '2023-09-10',
    sections: [
      ReleaseNoteSection(ReleaseNoteCategory.changed, [
        'Security updates.',
        'Translation updates.',
      ]),
      ReleaseNoteSection(ReleaseNoteCategory.fixed, [
        'Queue generation.',
      ]),
    ],
  ),
  ReleaseNote(
    version: '1.5.0',
    date: '2023-09-06',
    sections: [
      ReleaseNoteSection(ReleaseNoteCategory.added, [
        'Loop mode to stop after every song.',
        'Share button for songs.',
        'French, Chinese, Finnish, and Italian translations.',
      ]),
      ReleaseNoteSection(ReleaseNoteCategory.changed, [
        'Refined the setup workflow.',
      ]),
      ReleaseNoteSection(ReleaseNoteCategory.fixed, [
        'Library scanning speed and reliability.',
        'Queueing bug.',
      ]),
    ],
  ),
  ReleaseNote(
    version: '1.4.0',
    date: '2023-07-09',
    sections: [
      ReleaseNoteSection(ReleaseNoteCategory.added, [
        'Guided onboarding workflow.',
        'Export and import of your data.',
        'Two smartlists are created on first start.',
      ]),
      ReleaseNoteSection(ReleaseNoteCategory.fixed, [
        'Broken notification after calls.',
        'Unresponsive media buttons.',
        'Playlists widget localization.',
      ]),
    ],
  ),
];

/// Returns the release note for [version], or `null` if there is none.
ReleaseNote? releaseNoteForVersion(String version) {
  for (final releaseNote in RELEASE_NOTES) {
    if (releaseNote.version == version) return releaseNote;
  }
  return null;
}

/// Whether there are release notes for [version].
bool hasReleaseNoteForVersion(String version) =>
    releaseNoteForVersion(version) != null;
