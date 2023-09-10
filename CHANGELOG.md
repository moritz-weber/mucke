## 1.5.1
- Security updates.
- Fix in queue generation.
- Translation updates.

## 1.5

- Implemented loop mode to stop after every song (#102).
- Implemented share button for songs.
- Refined init workflow.
- Speed-up and fixes for library scanning (#124).
- Fix bug in queueing (#128).
- Added translations (French, Chinese, Finnish, Italian).

## 1.4

- Implemented an onboarding workflow.
- Implemented data export and import (#89).
- Moved database to separate isolate for non-blocking operation.
- Fixed bug with broken notification after calls (#68). Note: Existing users need to disable battery optimization for mucke.
- Added localization for playlists widget on home page (#90). Note: Existing users can rename the title in the home page settings.
- Fixed issue with unresponsive media buttons (#75).
- Added animations to currently playing page and queue page.
- Added initialization of two smartlists.
- Added translations.

## 1.3.1

- Fixed bug with translation priorities (#79)

## 1.3.0

- Fixed bug in "Append to manually queued songs"
- Fixed bug in queue when moving a song directly before the currently playing song
- Migration to Material 3 widgets including extensive UI changes
- New Icons for linked songs
- Added German translation (#51)
- Fixed track number parsing for three digits (#76)
- Fixed library loading for Android 13 (#77)

## 1.2.0

- Upgrade to Flutter 3.7 & dependency updates
- Fix album cover bug on currently playing page (#57)
- Calculate album colors during library update and store them for better performance
- Fix bug with smart lists in history entries
- Added logging to files
- Implement natural sorting for album songs (#59)
- Add option for counting songs as played (#38)
