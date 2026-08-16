// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class L10nEt extends L10n {
  L10nEt([String locale = 'et']) : super(locale);

  @override
  String get home => 'Avaleht';

  @override
  String get customizeHomePage => 'Kohenda avalehte';

  @override
  String get settings => 'Seadistused';

  @override
  String get noSongsYet =>
      'Looks like you don\'t have any songs in your library: Go to settings, add your music folders, and update your library.';

  @override
  String get library => 'Muusikakogu';

  @override
  String get search => 'Otsi';

  @override
  String get updateLibrary => 'Uuenda muusikakogu';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount esitajat, $albumCount albumit, $songCount lugu';
  }

  @override
  String get manageLibraryFolders => 'Halda muusikakogu kaustu';

  @override
  String get allowedFileExtensions => 'Lubatud faililaiendid';

  @override
  String get allowedFileExtensionsDescription =>
      'A comma-separated list of allowed file extensions. Lower- or uppercase does not matter. If you are unsure about this, just use the default.';

  @override
  String get manageBlockedFiles => 'Halda blokeeritud faile';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Number of currently blocked files: $blockedFiles';
  }

  @override
  String get playback => 'Taasesitus';

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
  String get libraryFolders => 'Muusikakogu kaustad';

  @override
  String get blockedFiles => 'Blokeeritud failid';

  @override
  String get homeCustomization => 'Avalehe kohendamine';

  @override
  String get albumOfTheDay => 'Tänase päeva album';

  @override
  String get artistOfTheDay => 'Tänase päeva esitaja';

  @override
  String get shuffleAll => 'Sega kõik lood';

  @override
  String get history => 'Ajalugu';

  @override
  String get addWidgetToHome => 'Lisa vidin avalehele';

  @override
  String get noPlaylistsYet =>
      'Esitusloendeid veel pole. Saad neid lisada muusikakogust.';

  @override
  String get lastPlayed => 'Viimati esitatud';

  @override
  String get noHistoryYet =>
      'Siin pole veel midagi huvitavat. Kuula mõnda lugu.';

  @override
  String get allSongs => 'Kõik lood';

  @override
  String get song => 'Lugu';

  @override
  String get songs => 'Lood';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugu',
      one: 'üks lugu',
      zero: 'lugusid pole',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Album';

  @override
  String get albums => 'Albumid';

  @override
  String get artist => 'Esitaja';

  @override
  String get artists => 'Esitajad';

  @override
  String get playlist => 'Esitusloend';

  @override
  String get playlists => 'Esitusloendid';

  @override
  String get smartlist => 'Nutikas esitusloend';

  @override
  String get smartlists => 'Nutikad esitusloendid';

  @override
  String get noShuffle => 'Puudub (säilita senine segamisviis)';

  @override
  String get normalMode => 'Tavaline viis';

  @override
  String get shuffleMode => 'Segamisviis';

  @override
  String get favShuffleMode => 'Lemmikupõhine segamisviis';

  @override
  String get playlistNormalMode => 'Play from the top';

  @override
  String get playlistShuffleMode => 'Start shuffle playback';

  @override
  String get playlistFavShuffleMode => 'Start favorite shuffle playback';

  @override
  String get name => 'Nimi';

  @override
  String get sortingFilterSettings => 'Järjestuse ja filtrite seadistused';

  @override
  String get maxNumberEntries => 'Maksimaalne kirjete arv';

  @override
  String get creationDate => 'Loomise kuupäev';

  @override
  String get changeDate => 'Muuda kuupäeva';

  @override
  String get lastTimePlayed => 'Viimase esitamise aeg';

  @override
  String get ascending => 'Järjesta kasvavalt';

  @override
  String get descending => 'Järjesta kahanevalt';

  @override
  String get both => 'Mõlemad';

  @override
  String get playlistsOnly => 'Vaid esitusloendid';

  @override
  String get smartlistsOnly => 'Vaid nutikad esitusloendid';

  @override
  String get displaySettings => 'Ekraani seadistused';

  @override
  String get addSmartlist => 'Lisa nutikas esitusloend';

  @override
  String get addPlaylist => 'Lisa esitusloend';

  @override
  String get createPlaylist => 'Loo esitusloend';

  @override
  String get editPlaylist => 'Muuda esitusloendit';

  @override
  String get customizeCover => 'Kohenda kaanepilti';

  @override
  String get playbackMode => 'Taasesituse režiim';

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
  String get filterSettings => 'Filtrite seadistused';

  @override
  String filterLikes(int min, int max) {
    return 'Likes between $min and $max';
  }

  @override
  String get minPlayCount => 'Minimaalne esitamiste arv';

  @override
  String get maxPlayCount => 'Maksimaalne esitamiste arv';

  @override
  String get minYear => 'Väikseim aasta';

  @override
  String get maxYear => 'Suurim aasta';

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
  String get excludeArtists => 'Välista valitud esitajad';

  @override
  String get limitSongs => 'Limit number of songs';

  @override
  String get orderSettings => 'Järjestuse seadistused';

  @override
  String get orderSettingsDescription =>
      'Reorder options to change priorities.';

  @override
  String get createSmartlist => 'Loo nutikas esitusloend';

  @override
  String get editSmartlist => 'Muuda nutikat esitusloendit';

  @override
  String get play => 'Esita';

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
  String get playNext => 'Esita järgmisena';

  @override
  String get appendToQueued => 'Append to manually queued songs';

  @override
  String get addToQueue => 'Lisa esitusjärjekorda';

  @override
  String get disc => 'Plaat';

  @override
  String get blockFromLibrary => 'Remove and block from library';

  @override
  String get highlights => 'Esiletõstetud';

  @override
  String get shuffle => 'Sega lood';

  @override
  String get selectArtists => 'Vali esitajad';

  @override
  String get removeFromQueue => 'Eemalda esitusjärjekorrast';

  @override
  String get currentlyPlaying => 'Hetkel kuulamisel';

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
    return 'veel $num on saadaval';
  }

  @override
  String get nameMustNotBeEmpty => 'Nimi ei tohi jääda tühjaks.';

  @override
  String get artistName => 'Esitaja nimi';

  @override
  String get likeCount => 'Meeldimisi';

  @override
  String get playCount => 'Esituskordi';

  @override
  String get songTitle => 'Loo pealkiri';

  @override
  String get year => 'Aasta';

  @override
  String get timeAdded => 'Lisamise aeg';

  @override
  String get addToPlaylist => 'Lisa esitusloendisse';

  @override
  String get removeFromPlaylist => 'Eemalda esitusloendist';

  @override
  String get cancel => 'Katkesta';

  @override
  String get nextUp => 'Järgmiseks esitamisel';

  @override
  String get previousSong => 'eelmine';

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
  String get dontExcludeSong => 'Ära välista seda lugu.';

  @override
  String get excludeShuffleAllSong => 'Välista lugude segamisel.';

  @override
  String get excludeShuffleSong => 'Välista segamisel.';

  @override
  String get alwaysExcludeSong => 'Välista alati see lugu.';

  @override
  String get welcomeToMucke => 'Tere tulemast, see on mucke!';

  @override
  String get setupLibrary => 'Seadista muusikakogu';

  @override
  String get setupLibraryDescription =>
      'Vali kaustad, lubatud faililaiendid, jne.';

  @override
  String get importData => 'Impordi andmeid';

  @override
  String get importDataDescription =>
      'Impordi oma andmed varasemast mucke paigaldusest.';

  @override
  String get yourLibrary => 'Sinu muusikakogu:';

  @override
  String get scan => 'Skaneeri';

  @override
  String get noFoldersSelected => 'Sa pole veel ühtegi kausta valinud.';

  @override
  String get addFolder => 'Lisa kaust';

  @override
  String get availableFromImport => 'Imporditud andmetest on saadaval:';

  @override
  String get use => 'Kasuta';

  @override
  String get reset => 'Lähtesta';

  @override
  String get blockedFilesDescription =>
      'Blocked files from the imported data. Only exact matches will be excluded from the library scan. Additional files can be blocked later in the app.';

  @override
  String get importLibData => 'Impordi muusikakogu andmed';

  @override
  String get songMetaData => 'Lugude metateave';

  @override
  String metaDataAvailable(int num) {
    return 'Saadaval on $num loo metateave';
  }

  @override
  String get metaDataDescription => 'Impordi meeldimised, blokeerimised, jne.';

  @override
  String get imported => 'Imporditud';

  @override
  String get importVerb => 'Impordi';

  @override
  String get miscellaneous => 'Varia';

  @override
  String get exportData => 'Ekspordi andmed';

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
      'Vali andmed, mida tahad eksportida. Vaikimisi eksporditakse kõik. Lisaks saad valida kausta, kuhu ekspordifail salvestatakse.';

  @override
  String get songsAlbumsArtists => 'Lood, albumid ja esitajad';

  @override
  String get librarySettings => 'Muusikakogu seadistused';

  @override
  String dataExportedTo(String path) {
    return 'Andmed on eksporditud kausta:\n$path';
  }

  @override
  String get dataExportFailed => 'Andmete eksportimine ei õnnestunud!';

  @override
  String get yourPlaylists => 'Sinu esitusloendid';

  @override
  String get systemSettings => 'Süsteemi seadistused';

  @override
  String get batteryExplanation =>
      'Alates Androidi 12-st versioonist akukasutuse optimeerimine tekitab helifookuse kaotamisel (näiteks kõne ajal) teavituste vea. Optimeerimise keelamine lahendab selle vea.';

  @override
  String get openBattery => 'Ava akukasutuse seadistused';

  @override
  String get disableBattery =>
      'Probleemide lahendamiseks lülita ta mucke jaoks välja.';

  @override
  String get disableBatteryDescription =>
      'Disabling battery optimization can solve potential notification issues.';

  @override
  String get disabledBattery => 'Akukasutuse optimeerimine on lülitatud välja.';

  @override
  String get manageExternalExplanation =>
      'Selle õiguse lubamine parandab märgatakselt muusikakogu loomisel skaneerimise kiirust. Muus osas rakenduse toimimine ei muutu.';

  @override
  String get grantManagePermission =>
      'Anna õigused kõikide failide haldamiseks.';

  @override
  String get managePermissionSubtitle =>
      'Õiguste keelamisel see rakendus käivitub uuesti.';

  @override
  String get favorites => 'Lemmikud';

  @override
  String get favoritesDesc => 'Sisaldab lugusid, mis sulle meeldivad.';

  @override
  String get newlyAdded => 'Äsjalisatud';

  @override
  String get newlyAddedDesc => 'Sisaldab 100 viimatilisatud lugu.';

  @override
  String get back => 'Tagasi';

  @override
  String get next => 'Järgmine';

  @override
  String get finish => 'Lõpeta';

  @override
  String get errorReadData => 'Viga andmefaili laadmisel.';

  @override
  String get createSmartlists => 'Loo nutikaid esitusloendeid';

  @override
  String get createSmartlistsDesc =>
      'Create suggested smartlists to enhance your listening experience. You can customize these lists later.';

  @override
  String get create => 'Loo';

  @override
  String get created => 'Loodud';
}
