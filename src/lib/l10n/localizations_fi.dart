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
  String get rescanAll => 'Rescan all files (slow)';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount esittäjää, $albumCount albumia, $songCount kappaletta';
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
      'Kun napsautat albumissa olevaa kappaletta, kappaleet toistetaan järjestyksessä edellisen toistotilan sijaan.';

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
  String get noShuffle => 'Ei mitään (säilytä nykyinen sekoitustila)';

  @override
  String get normalMode => 'Normaali tila';

  @override
  String get shuffleMode => 'Sekoitustila';

  @override
  String get favShuffleMode => 'Suosikki sekoitustila';

  @override
  String get playlistNormalMode => 'Play from the top';

  @override
  String get playlistShuffleMode => 'Start shuffle playback';

  @override
  String get playlistFavShuffleMode => 'Start favorite shuffle playback';

  @override
  String get name => 'Nimi';

  @override
  String get sortingFilterSettings => 'Järjestyksen ja suodatuksen asetukset';

  @override
  String get maxNumberEntries => 'Tietueiden enimmäismäärä';

  @override
  String get creationDate => 'Luontipäivä';

  @override
  String get changeDate => 'Muuta päivämäärää';

  @override
  String get lastTimePlayed => 'Viimeksi toistettu';

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
  String get excludeAllSongs =>
      'Sulje pois kaikki poissuljettavaksi merkityt kappaleet.';

  @override
  String get excludeInShuffle =>
      'Sulje pois poissuljettavaksi merkityt kappaleet sekoitustilassa.';

  @override
  String get excludeAlways =>
      'Sulje pois vain kappaleet, jotka on merkitty aina poissulkeviksi.';

  @override
  String get dontExclude => 'Älä sulje pois mitään kappaleita.';

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
    return 'Valitse poissuljettavat artistit: $num valittu.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Valitse sisällytettävät artistit: $num valittu.';
  }

  @override
  String get includeAllArtists =>
      'Sisällytä kaikki artistit, jos ketään ei ole valittu.';

  @override
  String get excludeArtists => 'Sulje pois valitut artistit';

  @override
  String get limitSongs => 'Rajoita kappaleiden määrää';

  @override
  String get orderSettings => 'Järjestyksen asetukset';

  @override
  String get orderSettingsDescription =>
      'Järjestä vaihtoehdot uudelleen prioriteettien muuttaamiseksi.';

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
  String get appendToQueued =>
      'Liitä manuaalisesti jonoon asetettuihin kappaleisiin';

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
    return '$_temp0 jonossa';
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
  String get likeCount => 'Tykkäysmäärä';

  @override
  String get playCount => 'Toistomäärä';

  @override
  String get songTitle => 'Kappaleen nimi';

  @override
  String get year => 'Vuosi';

  @override
  String get timeAdded => 'Lisäysaika';

  @override
  String get addToPlaylist => 'Lisää soittolistaan';

  @override
  String get removeFromPlaylist => 'Poista soittolistasta';

  @override
  String get cancel => 'Peruuta';

  @override
  String get nextUp => 'Seuraavaksi';

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
  String get alwaysPlayPrevious => 'Soita aina edellinen kappale ennen';

  @override
  String get alwaysPlayNext => 'Soita aina seuraava kappale sen jälkeen';

  @override
  String get dontExcludeSong => 'Älä sulje pois tätä kappaletta.';

  @override
  String get excludeShuffleAllSong =>
      'Sulje pois, kun kaikki kappaleet sekoitetaan.';

  @override
  String get excludeShuffleSong => 'Sulje pois, kun sekoitetaan.';

  @override
  String get alwaysExcludeSong => 'Jätä tämä kappale aina pois.';

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
      'Estetyt tiedostot tuoduista tiedoista. Vain tarkat vastaavuudet jätetään pois kirjaston skannauksesta. Lisää tiedostoja voidaan estää myöhemmin sovelluksessa.';

  @override
  String get importLibData => 'Tuo kirjastotiedot';

  @override
  String get songMetaData => 'Kappaleen metatieto';

  @override
  String metaDataAvailable(int num) {
    return '$num:n kappaleen metatiedot saatavilla';
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
      'Valitse tiedot, jotka haluat vietäviksi. Oletuksena kaikki viedään. Viedessäsi voit valita kansion tallennettavalle tiedostolle.';

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
  String get systemSettings => 'Järjestelmän asetukset';

  @override
  String get batteryExplanation =>
      'Android v. 12:sta alkaen akun optimointi aiheuttaa ilmoituksen virheen äänen tarkennuksen menettämisen jälkeen, esimerkiksi puhelun saapuessa. Mucken optimoinnin poistaminen käytöstä ratkaisee tämän ongelman.';

  @override
  String get openBattery => 'Avaa akkuasetukset';

  @override
  String get disableBattery =>
      'Poista muckin optimointi käytöstä ilmoitusongelmien ratkaisemiseksi.';

  @override
  String get disableBatteryDescription =>
      'Disabling battery optimization can solve potential notification issues.';

  @override
  String get disabledBattery => 'Akun optimointi on poistettu käytöstä.';

  @override
  String get manageExternalExplanation =>
      'Tämän luvan myöntäminen voi parantaa kirjaston tarkistuksia merkittävästi. Se ei muuta sovelluksen toimintaa muuten.';

  @override
  String get grantManagePermission => 'Myönnä lupa hallita kaikkia tiedostoja.';

  @override
  String get managePermissionSubtitle =>
      'Luvan peruuttaminen johtaa sovelluksen uudelleenkäynnistykseen.';

  @override
  String get favorites => 'Suosikit';

  @override
  String get favoritesDesc => 'Sisältää kaikki kappaleet, joista pidät.';

  @override
  String get newlyAdded => 'Äskettäin lisätty';

  @override
  String get newlyAddedDesc => 'Sisältää 100 viimeksi lisättyä kappaletta.';

  @override
  String get back => 'Takaisin';

  @override
  String get next => 'Seuraava';

  @override
  String get finish => 'Valmis';

  @override
  String get errorReadData => 'Virhe tiedostojen lukemisessa.';

  @override
  String get createSmartlists => 'Luo älykkäitä listoja';

  @override
  String get createSmartlistsDesc =>
      'Luo ehdotettuja älykkäitä listoja, jotka parantavat kuuntelukokemusta. Voit muokata näitä luetteloita myöhemmin.';

  @override
  String get create => 'Luo';

  @override
  String get created => 'Luotu';
}
