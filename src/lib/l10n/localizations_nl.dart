// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class L10nNl extends L10n {
  L10nNl([String locale = 'nl']) : super(locale);

  @override
  String get home => 'Startpagina';

  @override
  String get customizeHomePage => 'Startpagina aanpassen';

  @override
  String get settings => 'Instellingen';

  @override
  String get noSongsYet =>
      'Het lijkt erop dat je geen liedjes in je bibliotheek hebt: Ga naar de instellingen, voeg jouw muziek mappen toe, en werk jouw bibliotheek bij.';

  @override
  String get library => 'Bibliotheek';

  @override
  String get search => 'Zoeken';

  @override
  String get updateLibrary => 'Bibliotheek bijwerken';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount artiesten, $albumCount albums, $songCount liedjes';
  }

  @override
  String get manageLibraryFolders => 'Bibliotheek mappen beheren';

  @override
  String get allowedFileExtensions => 'Toegestane bestandsextensies';

  @override
  String get allowedFileExtensionsDescription =>
      'Een kommagescheiden lijst van toegestane bestandsextensies. Hoofd- en kleine letters maken niet uit. Als je niet zeker ervan bent, gebruik gewoon de standaard instelling.';

  @override
  String get manageBlockedFiles => 'Geblokkeerde bestanden beheren';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Aantal huidige geblokkeerde bestanden: $blockedFiles';
  }

  @override
  String get playback => 'Afspelen';

  @override
  String get playAlbumsInOrder => 'Albums in volgorde afspelen';

  @override
  String get playAlbumsInOrderDescription =>
      'Wanneer je een lied in een album aanklikt, worden de liedjes in volgorde afgespeeld, in plaats van de vorige afspeelmodus te behouden.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Tel liedjes als afgespeeld na: $percentage%';
  }

  @override
  String get libraryFolders => 'Bibliotheek mappen';

  @override
  String get blockedFiles => 'Geblokkeerde Bestanden';

  @override
  String get homeCustomization => 'Startpagina Aanpassingen';

  @override
  String get albumOfTheDay => 'Album van de Dag';

  @override
  String get artistOfTheDay => 'Artiest van de Dag';

  @override
  String get shuffleAll => 'Alles willekeurig afspelen';

  @override
  String get history => 'Geschiedenis';

  @override
  String get addWidgetToHome => 'Voeg een Widget toe aan je Startpagina';

  @override
  String get noPlaylistsYet =>
      'Er zijn nog geen afspeellijsten. Je kunt deze in de bibliotheek toevoegen.';

  @override
  String get lastPlayed => 'Recent afgespeeld';

  @override
  String get noHistoryYet => 'Er is hier nog niets te zien. Speel iets af.';

  @override
  String get allSongs => 'Alle Liedjes';

  @override
  String get song => 'Lied';

  @override
  String get songs => 'Liedjes';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count liedjes',
      one: 'een liedje',
      zero: 'geen liedjes',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Album';

  @override
  String get albums => 'Albums';

  @override
  String get artist => 'Artiest';

  @override
  String get artists => 'Artiesten';

  @override
  String get playlist => 'Afspeellijst';

  @override
  String get playlists => 'Afspeellijsten';

  @override
  String get smartlist => 'Smartlist';

  @override
  String get smartlists => 'Smartlists';

  @override
  String get noShuffle => 'Geen (behoud de huidige willekeurige afspeel modus)';

  @override
  String get normalMode => 'Normale Modus';

  @override
  String get shuffleMode => 'Willekeurige Afspeel Modus';

  @override
  String get favShuffleMode => 'Favoriete Willekeurige Afspeel Modus';

  @override
  String get playlistNormalMode => 'Play from the top';

  @override
  String get playlistShuffleMode => 'Start shuffle playback';

  @override
  String get playlistFavShuffleMode => 'Start favorite shuffle playback';

  @override
  String get name => 'Naam';

  @override
  String get sortingFilterSettings => 'Sorteer en Filter Instellingen';

  @override
  String get maxNumberEntries => 'Maximum aantal vermeldingen';

  @override
  String get creationDate => 'Aanmaak Datum';

  @override
  String get changeDate => 'Wijzigingsdatum';

  @override
  String get lastTimePlayed => 'Laatste Keer Afgespeeld';

  @override
  String get ascending => 'Oplopend';

  @override
  String get descending => 'Aflopend';

  @override
  String get both => 'Beide';

  @override
  String get playlistsOnly => 'Enkel Afspeellijsten';

  @override
  String get smartlistsOnly => 'Enkel Smartlists';

  @override
  String get displaySettings => 'Weergave Instellingen';

  @override
  String get addSmartlist => 'Smartlist toevoegen';

  @override
  String get addPlaylist => 'Afspeellijst toevoegen';

  @override
  String get createPlaylist => 'Afspeellijst aanmaken';

  @override
  String get editPlaylist => 'Afspeellijst bewerken';

  @override
  String get customizeCover => 'Cover aanpassen';

  @override
  String get playbackMode => 'Afspeel Modus';

  @override
  String get excludeAllSongs =>
      'Sluit alle nummers uit, die voor een uitsluiting gemarkeerd zijn.';

  @override
  String get excludeInShuffle =>
      'Sluit liedjes uit, die voor uitsluiting gemarkeerd zijn in de willekeurige modus.';

  @override
  String get excludeAlways =>
      'Sluit liedjes uit, die gemarkeerd zijn om altijd uitgesloten te worden.';

  @override
  String get dontExclude => 'Sluit geen liedjes uit.';

  @override
  String get filterSettings => 'Filter Instellingen';

  @override
  String filterLikes(int min, int max) {
    return 'Likes tussen $min en $max';
  }

  @override
  String get minPlayCount => 'Minimum aantal afgespeeld';

  @override
  String get maxPlayCount => 'Maximum aantal afgespeeld';

  @override
  String get minYear => 'Minimum Jaar';

  @override
  String get maxYear => 'Maximum Jaar';

  @override
  String selectArtistsExclude(int num) {
    return 'Selecteer artiesten om uit te sluiten: $num geselecteerd.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Selecteer artiesten om toe te voegen: $num geselecteerd.';
  }

  @override
  String get includeAllArtists =>
      'Voeg alle artiesten toe, indien er geen zijn geselecteerd.';

  @override
  String get excludeArtists => 'Geselecteerde artiesten uitsluiten';

  @override
  String get limitSongs => 'Aantal liedjes limiteren';

  @override
  String get orderSettings => 'Sorteer Instellingen';

  @override
  String get orderSettingsDescription =>
      'Pas de volgorde van de opties aan, om de prioriteiten te wijzigen.';

  @override
  String get createSmartlist => 'Smartlist aanmaken';

  @override
  String get editSmartlist => 'Smartlist wijzigen';

  @override
  String get play => 'Afspelen';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count liedjes geselecteerd',
      one: '1 liedje geselecteerd',
      zero: 'geen liedjes geselecteerd',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Speel volgende af';

  @override
  String get appendToQueued =>
      'Toevoegen aan handmatig in de wachtrij geplaatste liedjes';

  @override
  String get addToQueue => 'Aan wachtrij toevoegen';

  @override
  String get disc => 'CD';

  @override
  String get blockFromLibrary => 'Uit de bibliotheek verwijderen en blokkeren';

  @override
  String get highlights => 'Hoogtepunten';

  @override
  String get shuffle => 'Willekeurig afspelen';

  @override
  String get selectArtists => 'Selecteer Artiesten';

  @override
  String get removeFromQueue => 'Uit de wachtrij verwijderen';

  @override
  String get currentlyPlaying => 'Op dit moment aan het afspelen';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count liedjes',
      one: 'een liedje',
      zero: 'geen liedjes',
    );
    return '$_temp0 in de wachtrij';
  }

  @override
  String moreAvailable(int num) {
    return '$num meer beschikbaar';
  }

  @override
  String get nameMustNotBeEmpty => 'De naam mag niet leeg zijn.';

  @override
  String get artistName => 'Artiestennaam';

  @override
  String get likeCount => 'Aantal likes';

  @override
  String get playCount => 'Aantal keren afgespeeld';

  @override
  String get songTitle => 'Titel van het liedje';

  @override
  String get year => 'Jaar';

  @override
  String get timeAdded => 'Wanneer toegevoegd';

  @override
  String get addToPlaylist => 'Toevoegen aan afspeellijst';

  @override
  String get removeFromPlaylist => 'Verwijderen van afspeellijst';

  @override
  String get cancel => 'Annuleren';

  @override
  String get nextUp => 'Eerstvolgende';

  @override
  String get previousSong => 'vorig';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count keren afgespeeld',
      one: 'eenmaal afgespeeld',
      zero: 'nog niet afgespeeld',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => 'Vorig liedje altijd vooraf afspelen';

  @override
  String get alwaysPlayNext => 'Speel het volgende nummer altijd erna af';

  @override
  String get dontExcludeSong => 'Dit liedje niet uitsluiten.';

  @override
  String get excludeShuffleAllSong =>
      'Uitsluiten als alle liedjes willekeurig worden afgespeeld.';

  @override
  String get excludeShuffleSong =>
      'Uitsluiten tijdens willekeurig afspelen modus.';

  @override
  String get alwaysExcludeSong => 'Altijd dit liedje uitsluiten.';

  @override
  String get welcomeToMucke => 'Welkom bij mucke!';

  @override
  String get setupLibrary => 'Bibliotheek instellen';

  @override
  String get setupLibraryDescription =>
      'Selecteer mappen, inbegrepen bestandsextensies etc.';

  @override
  String get importData => 'Gegevens importeren';

  @override
  String get importDataDescription =>
      'Importeer jouw gegevens vanuit een vorige installatie van mucke.';

  @override
  String get yourLibrary => 'Jouw Bibliotheek:';

  @override
  String get scan => 'Scannen';

  @override
  String get noFoldersSelected => 'Dusver geen mappen geselecteerd.';

  @override
  String get addFolder => 'Map toevoegen';

  @override
  String get availableFromImport =>
      'Beschikbaar vanuit geïmporteerde gegevens:';

  @override
  String get use => 'Gebruiken';

  @override
  String get reset => 'Opnieuw instellen';

  @override
  String get blockedFilesDescription =>
      'Geblokkeerde bestanden vanuit de geïmporteerde gegevens. Enkel exacte overeenkomsten worden uitgesloten tijdens het scannen van de bibliotheek. Aanvullende bestanden kunnen later in de app geblokkeerd worden.';

  @override
  String get importLibData => 'Bibliotheek gegevens importeren';

  @override
  String get songMetaData => 'Liedjes Metadata';

  @override
  String metaDataAvailable(int num) {
    return 'Metadata voor $num liedjes beschikbaar';
  }

  @override
  String get metaDataDescription => 'Importeer likes, blokkades etc.';

  @override
  String get imported => 'Geïmporteerd';

  @override
  String get importVerb => 'Importeren';

  @override
  String get miscellaneous => 'Diversen';

  @override
  String get exportData => 'Gegevens exporteren';

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
      'Selecteer de gegevens die je wilt exporteren. Standaard wordt alles geëxporteerd. Tijdens het exporteren, kan er een map geselecteerd worden om het bestand in op te slaan.';

  @override
  String get songsAlbumsArtists => 'Liedjes, Albums en Artiesten';

  @override
  String get librarySettings => 'Bibliotheek Instellingen';

  @override
  String dataExportedTo(String path) {
    return 'Gegevens zijn geëxporteerd naar:\n$path';
  }

  @override
  String get dataExportFailed => 'Gegevens exporteren mislukt!';

  @override
  String get yourPlaylists => 'Jouw Afspeellijsten';

  @override
  String get systemSettings => 'Systeem Instellingen';

  @override
  String get batteryExplanation =>
      'Vanaf Android 12 veroorzaakt de batterij optimalisatie een foutmelding met de meldingen, nadat de audio de focus verliest, bijvoorbeeld tijdens een binnenkomende oproep. Het deactiveren van de optimalisaties voor mucke, lost dit probleem op.';

  @override
  String get openBattery => 'Batterij instellingen openen';

  @override
  String get disableBattery =>
      'Optimalisaties voor mucke uitschakelen, om melding problemen op te lossen.';

  @override
  String get disableBatteryDescription =>
      'Disabling battery optimization can solve potential notification issues.';

  @override
  String get disabledBattery => 'Batterij optimalisatie is uitgeschakeld.';

  @override
  String get manageExternalExplanation =>
      'Deze toestemming verlenen, kan de scansnelheid van de bibliotheek behoorlijk verhogen. Het verandert verder niets aan het gedrag van de applicatie.';

  @override
  String get grantManagePermission =>
      'Toestemming verlenen om alle bestanden te beheren.';

  @override
  String get managePermissionSubtitle =>
      'De toestemming intrekken, zal een herstart van de applicatie tot gevolg hebben.';

  @override
  String get favorites => 'Favorieten';

  @override
  String get favoritesDesc => 'Bevat alle liedjes, die je leuk vindt.';

  @override
  String get newlyAdded => 'Recent toegevoegd';

  @override
  String get newlyAddedDesc => 'Bevat de 100 meest recent toegevoegde liedjes.';

  @override
  String get back => 'Terug';

  @override
  String get next => 'Volgende';

  @override
  String get finish => 'Voltooien';

  @override
  String get errorReadData => 'Fout bij het lezen van het gegevensbestand.';

  @override
  String get createSmartlists => 'Smartlisten Aanmaken';

  @override
  String get createSmartlistsDesc =>
      'Voorgestelde smartlists aanmaken om uw luisterervaring te verbeteren. U kunt deze lijsten later aanpassen.';

  @override
  String get create => 'Aanmaken';

  @override
  String get created => 'Aangemaakt';
}
