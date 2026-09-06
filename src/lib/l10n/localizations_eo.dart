// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Esperanto (`eo`).
class L10nEo extends L10n {
  L10nEo([String locale = 'eo']) : super(locale);

  @override
  String get home => 'Hejmo';

  @override
  String get customizeHomePage => 'Agordi Hejmpaĝon';

  @override
  String get settings => 'Muntumoj';

  @override
  String get noSongsYet =>
      'Similn vi ne havas kantojn en via biblioteko: Ir al fiksaĵoj, aldon via muziko tekoj, kaj ĝisdatigo via biblioteko.';

  @override
  String get library => 'Biblioteko';

  @override
  String get search => 'Serĉi';

  @override
  String get updateLibrary => 'Ĝisdatigo biblioteko';

  @override
  String get rescanAll => 'Rescan all files (slow)';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount artistoj, $albumCount albumoj, $songCount kantoj';
  }

  @override
  String get scanSuccessful => 'Library scan completed.';

  @override
  String scanFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count scan failures',
      one: '1 scan failure',
    );
    return '$_temp0';
  }

  @override
  String get scanPermissionDenied =>
      'Audio permission required to scan the library.';

  @override
  String get scanErrorDetails => 'Details';

  @override
  String get scanFailures => 'Scan failures';

  @override
  String get scanFailureStage => 'Stage';

  @override
  String get scanStageMetadata => 'Metadata';

  @override
  String get scanStageAlbumArt => 'Album art';

  @override
  String get scanStageAccentColor => 'Accent color';

  @override
  String get scanStagePermission => 'Permission';

  @override
  String get scanErrorMetadata => 'Metadata could not be read.';

  @override
  String get scanErrorAlbumArt => 'Album art could not be read.';

  @override
  String get scanErrorAccentColor => 'Accent color could not be generated.';

  @override
  String get scanErrorPermission => 'Audio permission was denied.';

  @override
  String get manageLibraryFolders => 'Administri bibliotekon tekojn';

  @override
  String get allowedFileExtensions => 'Ebligita ke dosiero etendaĵoj';

  @override
  String get allowedFileExtensionsDescription =>
      'Komoapartig liston de ebligita ke dosiero etendaĵoj. Pli malalta - aŭ majuskla ne gravas. Se vi estas necerta pri ĉi tiu, juste uzi la nerepagon.';

  @override
  String get manageBlockedFiles => 'Administri blokitajn dosierojn';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Nombro de aktuale blokitajn dosierojn: $blockedFiles';
  }

  @override
  String get playback => 'Reludigo';

  @override
  String get playAlbumsInOrder => 'Lud albumoj laŭvice';

  @override
  String get playAlbumsInOrderDescription =>
      'Kiam vi klak kanto en albumo la kantoj estos ludita laŭvice anstataŭ ten la antaŭa lud maniero.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Kalkulas kantojn dum ludita post: $percentage%';
  }

  @override
  String get libraryFolders => 'Biblioteko Dosierujoj';

  @override
  String get blockedFiles => 'Blokitajn Dosierojn';

  @override
  String get homeCustomization => 'Hejmo Personecigo';

  @override
  String get albumOfTheDay => 'Albumo de la Tago';

  @override
  String get artistOfTheDay => 'Artisto de la Tago';

  @override
  String get shuffleAll => 'Rearanĝ Ĉiuj';

  @override
  String get history => 'Historio';

  @override
  String get addWidgetToHome => 'Almeti Uzaĵon Vian Hejmpaĝon';

  @override
  String get noPlaylistsYet =>
      'Neniuj ludlistoj ankoraŭ. Vi povas almeti ilin en la biblioteko.';

  @override
  String get lastPlayed => 'Fina ludita';

  @override
  String get noHistoryYet => 'Nenio vidi tie ĉi ankoraŭ. Lud aĵo.';

  @override
  String get allSongs => 'Ĉiuj Kantoj';

  @override
  String get song => 'Kanto';

  @override
  String get songs => 'Kantoj';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kantoj',
      one: 'unu kanto',
      zero: 'neniuk kantoj',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Albumo';

  @override
  String get albums => 'Albumoj';

  @override
  String get artist => 'Artisto';

  @override
  String get artists => 'Artistoj';

  @override
  String get playlist => 'Ludlisto';

  @override
  String get playlists => 'Ludlistoj';

  @override
  String get smartlist => 'Inteligentanlisto';

  @override
  String get smartlists => 'Inteligentanlistoj';

  @override
  String get noShuffle => 'Neniu (ten la nuna rearanĝ maniero)';

  @override
  String get normalMode => 'Normala Maniero';

  @override
  String get shuffleMode => 'Rearanĝ Maniero';

  @override
  String get favShuffleMode => 'Favorata Rearanĝ Maniero';

  @override
  String get playlistNormalMode => 'Play from the top';

  @override
  String get playlistShuffleMode => 'Start shuffle playback';

  @override
  String get playlistFavShuffleMode => 'Start favorite shuffle playback';

  @override
  String get name => 'Nomo';

  @override
  String get sortingFilterSettings => 'Ordiganta kaj Filtrilo Fiksaĵoj';

  @override
  String get maxNumberEntries => 'Maksimuma nombro de eroj';

  @override
  String get creationDate => 'Kreo Dato';

  @override
  String get changeDate => 'Ŝanĝ Dato';

  @override
  String get lastTimePlayed => 'La antaŭan okazon Ludis';

  @override
  String get ascending => 'Supreniranta';

  @override
  String get descending => 'Malsupreniranta';

  @override
  String get both => 'Ambaŭ';

  @override
  String get playlistsOnly => 'Ludlistoj Sole';

  @override
  String get smartlistsOnly => 'Inteligentanlistoj Sole';

  @override
  String get displaySettings => 'Montriĝo Fiksaĵoj';

  @override
  String get addSmartlist => 'Almeti Inteligentanlistoj';

  @override
  String get addPlaylist => 'Almeti Ludlistoj';

  @override
  String get createPlaylist => 'Krei Ludlistoj';

  @override
  String get editPlaylist => 'Redakti Ludlistoj';

  @override
  String get customizeCover => 'Personecig Kovrilon';

  @override
  String get playbackMode => 'Reludigo Maniero';

  @override
  String get excludeAllSongs => 'Ekskludi ĉiuj kantoj markis por ekskludo.';

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
  String get saveLogFiles => 'Save log files';

  @override
  String get saveLogFilesDescription =>
      'This creates a subfolder with the log files in it.';

  @override
  String logFilesSavedTo(String path) {
    return 'Log files saved to:\n$path';
  }

  @override
  String get logFilesSaveFailed => 'Saving log files failed!';

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
  String get disableBattery => 'Disable battery optimization for mucke.';

  @override
  String get disableBatteryDescription =>
      'Disabling battery optimization can solve potential notification issues.';

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
