// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class L10nNb extends L10n {
  L10nNb([String locale = 'nb']) : super(locale);

  @override
  String get home => 'Hjem';

  @override
  String get customizeHomePage => 'Tilpass hjemmesiden';

  @override
  String get settings => 'Innstillinger';

  @override
  String get noSongsYet =>
      'Gå til innsitllingene, legg til musikkmapper for å opprette et musikkbibliotek,';

  @override
  String get library => 'Bibliotek';

  @override
  String get search => 'Søk';

  @override
  String get updateLibrary => 'Oppdater bibliotek';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount artister, $albumCount album, $songCount spor';
  }

  @override
  String get manageLibraryFolders => 'Håndter bibliotekmapper';

  @override
  String get allowedFileExtensions => 'Tillatte filutvidelser';

  @override
  String get allowedFileExtensionsDescription =>
      'Kommainndelt liste. Små eller store bokstaver er det samme.';

  @override
  String get manageBlockedFiles => 'Håndter blokkerte filer';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Antall blokkerte filer nå: $blockedFiles';
  }

  @override
  String get playback => 'Avspilling';

  @override
  String get playAlbumsInOrder => 'Spill album i rekkefølge';

  @override
  String get playAlbumsInOrderDescription =>
      'Når du klikker et spor i et album vil sporene spilles i rekkefølge, istedenfor å beholde forrige avspillingsmodus.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Tell spor som avspilt etter. $percentage%';
  }

  @override
  String get libraryFolders => 'Bibliotekmapper';

  @override
  String get blockedFiles => 'Blokkerte filer';

  @override
  String get homeCustomization => 'Hjemmetilpasning';

  @override
  String get albumOfTheDay => 'Dagens album';

  @override
  String get artistOfTheDay => 'Dagens artist';

  @override
  String get shuffleAll => 'Omstokk alt';

  @override
  String get history => 'Historikk';

  @override
  String get addWidgetToHome => 'Legg til miniprogram på hjemmesiden din';

  @override
  String get noPlaylistsYet =>
      'Ingen spillelister enda. Du kan legge dem til i biblioteket.';

  @override
  String get lastPlayed => 'Sist spilt';

  @override
  String get noHistoryYet => 'Ingenting her enda. Spill noe.';

  @override
  String get allSongs => 'Alle spor';

  @override
  String get song => 'Spor';

  @override
  String get songs => 'Spor';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count spor',
      one: 'ett spor',
      zero: 'ingen spor',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Album';

  @override
  String get albums => 'Album';

  @override
  String get artist => 'Artist';

  @override
  String get artists => 'Artister';

  @override
  String get playlist => 'Spilleliste';

  @override
  String get playlists => 'Spillelister';

  @override
  String get smartlist => 'Smartliste';

  @override
  String get smartlists => 'Smartlister';

  @override
  String get noShuffle => 'Ingen (behold aktivt omstokkingsmodus)';

  @override
  String get normalMode => 'Normal modus';

  @override
  String get shuffleMode => 'Omstokkingsmodus';

  @override
  String get favShuffleMode => 'Favorittomstokkingsmodus';

  @override
  String get name => 'Navn';

  @override
  String get sortingFilterSettings => 'Sortering- og filtreringsinnstillinger';

  @override
  String get maxNumberEntries => 'Maks. antall oppføringer';

  @override
  String get creationDate => 'Opprettelsesdato';

  @override
  String get changeDate => 'Endringsdato';

  @override
  String get lastTimePlayed => 'Siste gang spilt';

  @override
  String get ascending => 'Stigende';

  @override
  String get descending => 'Synkende';

  @override
  String get both => 'Begge';

  @override
  String get playlistsOnly => 'Kun spillelister';

  @override
  String get smartlistsOnly => 'Kun smartlister';

  @override
  String get displaySettings => 'Visningsinnstillinger';

  @override
  String get addSmartlist => 'Legg til smartliste';

  @override
  String get addPlaylist => 'Legg til spilleliste';

  @override
  String get createPlaylist => 'Opprett spilleliste';

  @override
  String get editPlaylist => 'Rediger spilleliste';

  @override
  String get customizeCover => 'Tilpass omslag';

  @override
  String get playbackMode => 'Avspillingsmodus';

  @override
  String get excludeAllSongs => 'Utelat spor markert for utelatelse.';

  @override
  String get excludeInShuffle =>
      'Utelat spor markert for utelatelse i omstokkingsmodus.';

  @override
  String get excludeAlways => 'Utelat kun spor markert som «Alltid utelat».';

  @override
  String get dontExclude => 'Ikke utelat noen spor.';

  @override
  String get filterSettings => 'Filtreringsinnstillinger';

  @override
  String filterLikes(int min, int max) {
    return 'Liker mellom $min og $max';
  }

  @override
  String get minPlayCount => 'Min. avspillingsantall';

  @override
  String get maxPlayCount => 'Max. avspillingsantall';

  @override
  String get minYear => 'Min. år';

  @override
  String get maxYear => 'Maks. år';

  @override
  String selectArtistsExclude(int num) {
    return 'Velg artister å utelate: $num valgt.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Velg artister å inkludere: $num valgt.';
  }

  @override
  String get includeAllArtists => 'Inkluder alle artister hvis ingen er valgt.';

  @override
  String get excludeArtists => 'Utelat valgte artister';

  @override
  String get limitSongs => 'Begrens antallet spor';

  @override
  String get orderSettings => 'Sorteringsinnstillinger';

  @override
  String get orderSettingsDescription =>
      'Rekkefølgealternativer for endring av prioritet.';

  @override
  String get createSmartlist => 'Opprett smartliste';

  @override
  String get editSmartlist => 'Rediger smartliste';

  @override
  String get play => 'Spill av';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count spor valgt',
      one: 'ett spor valgt',
      zero: 'ingen spor valgt',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Spill av neste';

  @override
  String get appendToQueued => 'Legg til for manuelt kølagte spor';

  @override
  String get addToQueue => 'Legg til i kø';

  @override
  String get disc => 'Disk';

  @override
  String get blockFromLibrary => 'Fjern og blokker fra bibliotek';

  @override
  String get highlights => 'Høydepunkter';

  @override
  String get shuffle => 'Omstokking';

  @override
  String get selectArtists => 'Velg artister';

  @override
  String get removeFromQueue => 'Fjern fra kø';

  @override
  String get currentlyPlaying => 'Spilles nå';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count spor',
      one: 'ett spor',
      zero: 'ingen spor',
    );
    return '$_temp0 i kø';
  }

  @override
  String moreAvailable(int num) {
    return '$num flere tilgjengelig';
  }

  @override
  String get nameMustNotBeEmpty => 'Navn må angis.';

  @override
  String get artistName => 'Artistnavn.';

  @override
  String get likeCount => 'Antall ganger likt';

  @override
  String get playCount => 'Avspillinger';

  @override
  String get songTitle => 'Spornavn';

  @override
  String get year => 'År';

  @override
  String get timeAdded => 'Tid tillagt';

  @override
  String get addToPlaylist => 'Legg til i spilleliste';

  @override
  String get removeFromPlaylist => 'Fjern fra spilleliste';

  @override
  String get cancel => 'Av';

  @override
  String get nextUp => 'Spilles etterpå';

  @override
  String get previousSong => 'forrige';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'spilt $count ganger',
      one: 'spilt én gang',
      zero: 'ikke spilt endat',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => 'Alltid spill forrige spor før';

  @override
  String get alwaysPlayNext => 'Alltid spill neste spor etter';

  @override
  String get dontExcludeSong => 'Ikke utelat dette sporet.';

  @override
  String get excludeShuffleAllSong => 'Utelat ved omstokking av alle spor.';

  @override
  String get excludeShuffleSong => 'Utelat ved omstokking.';

  @override
  String get alwaysExcludeSong => 'Alltid utelat dette sporet.';

  @override
  String get welcomeToMucke => 'Velkommen til mucke.';

  @override
  String get setupLibrary => 'Sett opp bibliotek';

  @override
  String get setupLibraryDescription =>
      'Velg mapper, inkluderte filutvidelser, osv.';

  @override
  String get importData => 'Importer data';

  @override
  String get importDataDescription =>
      'Importer dine data fra en tidligere mucke-installasjon.';

  @override
  String get yourLibrary => 'Ditt bibliotek:';

  @override
  String get scan => 'Skann';

  @override
  String get noFoldersSelected => 'Ingen mapper valgt så langt.';

  @override
  String get addFolder => 'Legg til mappe';

  @override
  String get availableFromImport => 'Tilgjengelig fra importert data:';

  @override
  String get use => 'Bruk';

  @override
  String get reset => 'Tilbakestill';

  @override
  String get blockedFilesDescription =>
      'Blokker filer fra importert data. Kun eksakte treff vil bli utelatt fra biblioteksskanning. Ytterligere filer kan blokkeres senere i programmet.';

  @override
  String get importLibData => 'Importer biblioteksdata';

  @override
  String get songMetaData => 'Spor-metadata';

  @override
  String metaDataAvailable(int num) {
    return 'Metadata for $num spor tilgjengelig';
  }

  @override
  String get metaDataDescription => 'Importer hva som er likt, blokkert, osv.';

  @override
  String get imported => 'Importert';

  @override
  String get importVerb => 'Importer';

  @override
  String get miscellaneous => 'Ymse';

  @override
  String get exportData => 'Eksporter data';

  @override
  String get exportDescription =>
      'Velg data å eksportere. Som forvalg eksporteres alt. Når du eksporterer kan du velge en mappe filen lagres i.';

  @override
  String get songsAlbumsArtists => 'Spor, album, og artister';

  @override
  String get librarySettings => 'Biblioteksinnstillinger';

  @override
  String dataExportedTo(String path) {
    return 'Data eksportert til:\n$path';
  }

  @override
  String get dataExportFailed => 'Kunne ikke eksportere data.';

  @override
  String get yourPlaylists => 'Dine spillelister';

  @override
  String get systemSettings => 'System Settings';

  @override
  String get batteryExplanation =>
      'Fra Android 12 forårsaker batterioptimalisering en feil med merknaden etter at den mister lydfokus, for eksempel ved innkommende anrop. Å skru av batterioptimalisering for mucke løser dette problemet.';

  @override
  String get openBattery => 'Åpne batteri-innstillinger';

  @override
  String get disableBattery =>
      'sKRU AV Batterioptimalisering for mucke for å løse merknadsproblemer.';

  @override
  String get disabledBattery => 'Batterioptimalisering er avskrudd.';

  @override
  String get manageExternalExplanation =>
      'Granting this permission can improve the speed of library scans significantly. It does not change the behavior of the app otherwise.';

  @override
  String get grantManagePermission => 'Grant permission to manage all files.';

  @override
  String get managePermissionSubtitle =>
      'Revoking the permission will result in a restart of the app.';

  @override
  String get favorites => 'Favoritter';

  @override
  String get favoritesDesc => 'Contains all the songs that you like.';

  @override
  String get newlyAdded => 'Nylig tillagt';

  @override
  String get newlyAddedDesc => 'Contains the 100 songs that were added last.';

  @override
  String get back => 'Tilbake';

  @override
  String get next => 'Neste';

  @override
  String get finish => 'Fullfør';

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
