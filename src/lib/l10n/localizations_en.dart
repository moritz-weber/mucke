// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get customizeHomePage => 'Customize Home Page';

  @override
  String get settings => 'Settings';

  @override
  String get noSongsYet =>
      'Looks like you don\'t have any songs in your library: Go to settings, add your music folders, and update your library.';

  @override
  String get library => 'Library';

  @override
  String get search => 'Search';

  @override
  String get updateLibrary => 'Update library';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount artists, $albumCount albums, $songCount songs';
  }

  @override
  String get manageLibraryFolders => 'Manage library folders';

  @override
  String get allowedFileExtensions => 'Allowed file extensions';

  @override
  String get allowedFileExtensionsDescription =>
      'A comma-separated list of allowed file extensions. Lower- or uppercase does not matter. If you are unsure about this, just use the default.';

  @override
  String get manageBlockedFiles => 'Manage blocked files';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Number of currently blocked files: $blockedFiles';
  }

  @override
  String get playback => 'Playback';

  @override
  String get playAlbumsInOrder => 'Play albums in order';

  @override
  String get playAlbumsInOrderDescription =>
      'When you click a song in an album the songs will be played in order instead of keeping the previous play mode.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Count songs as played after: $percentage%';
  }

  @override
  String get libraryFolders => 'Library Folders';

  @override
  String get blockedFiles => 'Blocked Files';

  @override
  String get homeCustomization => 'Home Customization';

  @override
  String get albumOfTheDay => 'Album of the Day';

  @override
  String get artistOfTheDay => 'Artist of the Day';

  @override
  String get shuffleAll => 'Shuffle All';

  @override
  String get history => 'History';

  @override
  String get addWidgetToHome => 'Add a Widget to Your Home Page';

  @override
  String get noPlaylistsYet =>
      'No playlists yet. You can add them in the library.';

  @override
  String get lastPlayed => 'Last played';

  @override
  String get noHistoryYet => 'Nothing to see here yet. Play something.';

  @override
  String get allSongs => 'All Songs';

  @override
  String get song => 'Song';

  @override
  String get songs => 'Songs';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count songs',
      one: 'one song',
      zero: 'no songs',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Album';

  @override
  String get albums => 'Albums';

  @override
  String get artist => 'Artist';

  @override
  String get artists => 'Artists';

  @override
  String get playlist => 'Playlist';

  @override
  String get playlists => 'Playlists';

  @override
  String get smartlist => 'Smartlist';

  @override
  String get smartlists => 'Smartlists';

  @override
  String get noShuffle => 'None (keep the current shuffle mode)';

  @override
  String get normalMode => 'Normal Mode';

  @override
  String get shuffleMode => 'Shuffle Mode';

  @override
  String get favShuffleMode => 'Favorite Shuffle Mode';

  @override
  String get name => 'Name';

  @override
  String get sortingFilterSettings => 'Sorting and Filter Settings';

  @override
  String get maxNumberEntries => 'Maximum number of entries';

  @override
  String get creationDate => 'Creation Date';

  @override
  String get changeDate => 'Change Date';

  @override
  String get lastTimePlayed => 'Last Time Played';

  @override
  String get ascending => 'Ascending';

  @override
  String get descending => 'Descending';

  @override
  String get both => 'Both';

  @override
  String get playlistsOnly => 'Playlists Only';

  @override
  String get smartlistsOnly => 'Smartlists Only';

  @override
  String get displaySettings => 'Display Settings';

  @override
  String get addSmartlist => 'Add Smartlist';

  @override
  String get addPlaylist => 'Add Playlist';

  @override
  String get createPlaylist => 'Create Playlist';

  @override
  String get editPlaylist => 'Edit Playlist';

  @override
  String get customizeCover => 'Customize Cover';

  @override
  String get playbackMode => 'Playback Mode';

  @override
  String get excludeAllSongs => 'Exclude all songs marked for exclusion.';

  @override
  String get excludeInShuffle =>
      'Exclude songs marked for exclusion in shuffle mode.';

  @override
  String get excludeAlways => 'Exclude only songs marked as always exclude.';

  @override
  String get dontExclude => 'Don\'t exclude any songs.';

  @override
  String get filterSettings => 'Filter Settings';

  @override
  String filterLikes(int min, int max) {
    return 'Likes between $min and $max';
  }

  @override
  String get minPlayCount => 'Minimum play count';

  @override
  String get maxPlayCount => 'Maximum play count';

  @override
  String get minYear => 'Minimum Year';

  @override
  String get maxYear => 'Maximum Year';

  @override
  String selectArtistsExclude(int num) {
    return 'Select artists to exclude: $num selected.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Select artists to include: $num selected.';
  }

  @override
  String get includeAllArtists => 'Include all artists if none are selected.';

  @override
  String get excludeArtists => 'Exclude selected artists';

  @override
  String get limitSongs => 'Limit number of songs';

  @override
  String get orderSettings => 'Order Settings';

  @override
  String get orderSettingsDescription =>
      'Reorder options to change priorities.';

  @override
  String get createSmartlist => 'Create Smartlist';

  @override
  String get editSmartlist => 'Edit Smartlist';

  @override
  String get play => 'Play';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count songs selected',
      one: 'one song selected',
      zero: 'no songs selected',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Play next';

  @override
  String get appendToQueued => 'Append to manually queued songs';

  @override
  String get addToQueue => 'Add to queue';

  @override
  String get disc => 'Disc';

  @override
  String get blockFromLibrary => 'Remove and block from library';

  @override
  String get highlights => 'Highlights';

  @override
  String get shuffle => 'Shuffle';

  @override
  String get selectArtists => 'Select Artists';

  @override
  String get removeFromQueue => 'Remove from queue';

  @override
  String get currentlyPlaying => 'Currently playing';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count songs',
      one: 'one song',
      zero: 'no songs',
    );
    return '$_temp0 in queue';
  }

  @override
  String moreAvailable(int num) {
    return '$num more available';
  }

  @override
  String get nameMustNotBeEmpty => 'The name must not be empty.';

  @override
  String get artistName => 'Artist name';

  @override
  String get likeCount => 'Like count';

  @override
  String get playCount => 'Play count';

  @override
  String get songTitle => 'Song title';

  @override
  String get year => 'Year';

  @override
  String get timeAdded => 'Time added';

  @override
  String get addToPlaylist => 'Add to playlist';

  @override
  String get removeFromPlaylist => 'Remove from playlist';

  @override
  String get cancel => 'Cancel';

  @override
  String get nextUp => 'Next up';

  @override
  String get previousSong => 'previous';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'played $count times',
      one: 'played once',
      zero: 'not played yet',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => 'Always play previous song before';

  @override
  String get alwaysPlayNext => 'Always play next song after';

  @override
  String get dontExcludeSong => 'Don\'t exclude this song.';

  @override
  String get excludeShuffleAllSong => 'Exclude when shuffling all songs.';

  @override
  String get excludeShuffleSong => 'Exclude when shuffling.';

  @override
  String get alwaysExcludeSong => 'Always exclude this song.';

  @override
  String get welcomeToMucke => 'Welcome to mucke!';

  @override
  String get setupLibrary => 'Set up Library';

  @override
  String get setupLibraryDescription =>
      'Select folders, included file extensions, etc.';

  @override
  String get importData => 'Import data';

  @override
  String get importDataDescription =>
      'Import your data from a previous mucke installation.';

  @override
  String get yourLibrary => 'Your Library:';

  @override
  String get scan => 'Scan';

  @override
  String get noFoldersSelected => 'No folders selected so far.';

  @override
  String get addFolder => 'Add folder';

  @override
  String get availableFromImport => 'Available from imported data:';

  @override
  String get use => 'Use';

  @override
  String get reset => 'Reset';

  @override
  String get blockedFilesDescription =>
      'Blocked files from the imported data. Only exact matches will be excluded from the library scan. Additional files can be blocked later in the app.';

  @override
  String get importLibData => 'Import Library Data';

  @override
  String get songMetaData => 'Song Metadata';

  @override
  String metaDataAvailable(int num) {
    return 'Metadata for $num songs available';
  }

  @override
  String get metaDataDescription => 'Import likes, blocks etc.';

  @override
  String get imported => 'Imported';

  @override
  String get importVerb => 'Import';

  @override
  String get miscellaneous => 'Miscellaneous';

  @override
  String get exportData => 'Export data';

  @override
  String get exportDescription =>
      'Select the data you want to export. By default, everything is exported. When exporting, you can select a folder for the file to be stored.';

  @override
  String get songsAlbumsArtists => 'Songs, Albums, and Artists';

  @override
  String get librarySettings => 'Library Settings';

  @override
  String dataExportedTo(String path) {
    return 'Data exported to:\n$path';
  }

  @override
  String get dataExportFailed => 'Data export failed!';

  @override
  String get yourPlaylists => 'Your Playlists';

  @override
  String get systemSettings => 'System Settings';

  @override
  String get batteryExplanation =>
      'Starting with Android 12, the battery optimization causes an error with the notification after losing the audio focus, for example when receiving a call. Disabling the optimization for mucke solves this issue.';

  @override
  String get openBattery => 'Open battery settings';

  @override
  String get disableBattery =>
      'Disable optimization for mucke to solve notification issues.';

  @override
  String get disabledBattery => 'Battery optimization is disabled.';

  @override
  String get manageExternalExplanation =>
      'Granting this permission can improve the speed of library scans significantly. It does not change the behavior of the app otherwise.';

  @override
  String get grantManagePermission => 'Grant permission to manage all files.';

  @override
  String get managePermissionSubtitle =>
      'Revoking the permission will result in a restart of the app.';

  @override
  String get favorites => 'Favorites';

  @override
  String get favoritesDesc => 'Contains all the songs that you like.';

  @override
  String get newlyAdded => 'Newly added';

  @override
  String get newlyAddedDesc => 'Contains the 100 songs that were added last.';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get finish => 'Finish';

  @override
  String get errorReadData => 'Error reading data file.';

  @override
  String get createSmartlists => 'Create Smartlists';

  @override
  String get createSmartlistsDesc =>
      'Create suggested smartlists to enhance your listening experience. You can customize these lists later.';

  @override
  String get create => 'Create';

  @override
  String get created => 'Created';
}
