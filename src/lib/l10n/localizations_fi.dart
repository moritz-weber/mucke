// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class L10nFi extends L10n {
  L10nFi([String locale = 'fi']) : super(locale);

  @override
  String get home => 'Koti';

  @override
  String get customizeHomePage => 'Mukauta kotisivua';

  @override
  String get settings => 'Asetukset';

  @override
  String get noSongsYet =>
      'Vaikuttaa siltä, ettei kirjastossasi ole yhtäkään kappaletta. Mene asetuksiin, lisää musiikkikansioita ja päivitä kirjasto.';

  @override
  String get library => 'Kirjasto';

  @override
  String get search => 'Haku';

  @override
  String get updateLibrary => 'Päivitä kirjasto';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount esittäjää, $albumCount albumia, $songCount kappaletta';
  }

  @override
  String get manageLibraryFolders => 'Hallitse kirjastokansioita';

  @override
  String get allowedFileExtensions => 'Sallitut tiedostopäätteet';

  @override
  String get allowedFileExtensionsDescription =>
      'Pilkuin eroteltu lista sallituista tiedostopäätteistä. Pienillä ja isoilla kirjaimilla ei ole merkitystä. Jos olet epävarma tästä asetuksesta, käytä oletusta.';

  @override
  String get manageBlockedFiles => 'Hallitse estettyjä tiedostoja';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Estettyjen tiedostojen määrä: $blockedFiles';
  }

  @override
  String get playback => 'Toisto';

  @override
  String get playAlbumsInOrder => 'Toista albumit järjestyksessä';

  @override
  String get playAlbumsInOrderDescription =>
      'When you click a song in an album the songs will be played in order instead of keeping the previous play mode.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Laske kappale, kun siitä on toistettu: $percentage %';
  }

  @override
  String get libraryFolders => 'Kirjastokansiot';

  @override
  String get blockedFiles => 'Estetyt tiedostot';

  @override
  String get homeCustomization => 'Kotisivun mukautus';

  @override
  String get albumOfTheDay => 'Päivän albumi';

  @override
  String get artistOfTheDay => 'Päivän esittäjä';

  @override
  String get shuffleAll => 'Sekoita kaikki';

  @override
  String get history => 'Historia';

  @override
  String get addWidgetToHome => 'Lisää widget kotinäytöllesi';

  @override
  String get noPlaylistsYet =>
      'Ei soittolistoja vielä. Voit lisätä niitä kirjastossa.';

  @override
  String get lastPlayed => 'Viimeksi toistettu';

  @override
  String get noHistoryYet => 'Ei mitään nähtävää vielä. Toista jotakin.';

  @override
  String get allSongs => 'Kaikki kappaleet';

  @override
  String get song => 'Kappale';

  @override
  String get songs => 'Kappaleet';

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
  String get album => 'Albumi';

  @override
  String get albums => 'Albumit';

  @override
  String get artist => 'Esittäjä';

  @override
  String get artists => 'Esittäjät';

  @override
  String get playlist => 'Soittolista';

  @override
  String get playlists => 'Soittolistat';

  @override
  String get smartlist => 'Älylista';

  @override
  String get smartlists => 'Älylistat';

  @override
  String get noShuffle => 'None (keep the current shuffle mode)';

  @override
  String get normalMode => 'Normaali tila';

  @override
  String get shuffleMode => 'Sekoitustila';

  @override
  String get favShuffleMode => 'Favorite Shuffle Mode';

  @override
  String get name => 'Nimi';

  @override
  String get sortingFilterSettings => 'Järjestyksen ja suodatuksen asetukset';

  @override
  String get maxNumberEntries => 'Tietueiden enimmäismäärä';

  @override
  String get creationDate => 'Luontipäivä';

  @override
  String get changeDate => 'Change Date';

  @override
  String get lastTimePlayed => 'Last Time Played';

  @override
  String get ascending => 'Nouseva';

  @override
  String get descending => 'Laskeva';

  @override
  String get both => 'Molemmat';

  @override
  String get playlistsOnly => 'Vain soittolistat';

  @override
  String get smartlistsOnly => 'Vain älylistat';

  @override
  String get displaySettings => 'Näyttöasetukset';

  @override
  String get addSmartlist => 'Lisää älylista';

  @override
  String get addPlaylist => 'Lisää soittolista';

  @override
  String get createPlaylist => 'Luo soittolista';

  @override
  String get editPlaylist => 'Muokkaa soittolistaa';

  @override
  String get customizeCover => 'Mukauta kantta';

  @override
  String get playbackMode => 'Toistotila';

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
  String get filterSettings => 'Suodatusasetukset';

  @override
  String filterLikes(int min, int max) {
    return 'Tykkäykset välillä $min ja $max';
  }

  @override
  String get minPlayCount => 'Toistojen määrä vähintään';

  @override
  String get maxPlayCount => 'Toistojen määrä enintään';

  @override
  String get minYear => 'Vuosi vähintään';

  @override
  String get maxYear => 'Vuosi enintään';

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
  String get orderSettings => 'Järjestyksen asetukset';

  @override
  String get orderSettingsDescription =>
      'Reorder options to change priorities.';

  @override
  String get createSmartlist => 'Luo älylista';

  @override
  String get editSmartlist => 'Muokkaa älylistaa';

  @override
  String get play => 'Toista';

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
  String get playNext => 'Toista seuraava';

  @override
  String get appendToQueued => 'Append to manually queued songs';

  @override
  String get addToQueue => 'Lisää jonoon';

  @override
  String get disc => 'Levy';

  @override
  String get blockFromLibrary => 'Poista ja estä kirjastosta';

  @override
  String get highlights => 'Korostukset';

  @override
  String get shuffle => 'Sekoita';

  @override
  String get selectArtists => 'Valitse esittäjät';

  @override
  String get removeFromQueue => 'Poista jonosta';

  @override
  String get currentlyPlaying => 'Nyt toistetaan';

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
    return '$num lisää saatavilla';
  }

  @override
  String get nameMustNotBeEmpty => 'Nimi ei voi olla tyhjä.';

  @override
  String get artistName => 'Esittäjän nimi';

  @override
  String get likeCount => 'Like count';

  @override
  String get playCount => 'Play count';

  @override
  String get songTitle => 'Kappaleen nimi';

  @override
  String get year => 'Vuosi';

  @override
  String get timeAdded => 'Time added';

  @override
  String get addToPlaylist => 'Lisää soittolistaan';

  @override
  String get removeFromPlaylist => 'Poista soittolistasta';

  @override
  String get cancel => 'Peruuta';

  @override
  String get nextUp => 'Next up';

  @override
  String get previousSong => 'edellinen';

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
  String get welcomeToMucke => 'Tervetuloa käyttämään muckea!';

  @override
  String get setupLibrary => 'Määritä kirjasto';

  @override
  String get setupLibraryDescription =>
      'Valitse kansiot, sallitut tiedostopäätteet jne.';

  @override
  String get importData => 'Tuo tiedot';

  @override
  String get importDataDescription =>
      'Tuo tietosi aiemmasta mucke-asennuksesta.';

  @override
  String get yourLibrary => 'Kirjastosi:';

  @override
  String get scan => 'Skannaa';

  @override
  String get noFoldersSelected => 'Kansioita ei ole vielä valittu.';

  @override
  String get addFolder => 'Lisää kansio';

  @override
  String get availableFromImport => 'Saatavilla tuoduista tiedoista:';

  @override
  String get use => 'Käytä';

  @override
  String get reset => 'Nollaa';

  @override
  String get blockedFilesDescription =>
      'Blocked files from the imported data. Only exact matches will be excluded from the library scan. Additional files can be blocked later in the app.';

  @override
  String get importLibData => 'Tuo kirjastotiedot';

  @override
  String get songMetaData => 'Kappaleen metatieto';

  @override
  String metaDataAvailable(int num) {
    return 'Metadata for $num songs available';
  }

  @override
  String get metaDataDescription => 'Tuo tykkäykset, estot jne.';

  @override
  String get imported => 'Tuotu';

  @override
  String get importVerb => 'Tuo';

  @override
  String get miscellaneous => 'Sekalaiset';

  @override
  String get exportData => 'Vie tiedot';

  @override
  String get exportDescription =>
      'Select the data you want to export. By default, everything is exported. When exporting, you can select a folder for the file to be stored.';

  @override
  String get songsAlbumsArtists => 'Kappaleet, albumit ja esittäjät';

  @override
  String get librarySettings => 'Kirjastoasetukset';

  @override
  String dataExportedTo(String path) {
    return 'Tiedot viety polkuun:\n$path';
  }

  @override
  String get dataExportFailed => 'Tietojen vienti epäonnistui!';

  @override
  String get yourPlaylists => 'Soittolistasi';

  @override
  String get systemSettings => 'System Settings';

  @override
  String get batteryExplanation =>
      'Starting with Android 12, the battery optimization causes an error with the notification after losing the audio focus, for example when receiving a call. Disabling the optimization for mucke solves this issue.';

  @override
  String get openBattery => 'Avaa akkuasetukset';

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
  String get favorites => 'Suosikit';

  @override
  String get favoritesDesc => 'Contains all the songs that you like.';

  @override
  String get newlyAdded => 'Äskettäin lisätty';

  @override
  String get newlyAddedDesc => 'Contains the 100 songs that were added last.';

  @override
  String get back => 'Takaisin';

  @override
  String get next => 'Seuraava';

  @override
  String get finish => 'Valmis';

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
