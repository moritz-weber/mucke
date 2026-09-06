// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class L10nPl extends L10n {
  L10nPl([String locale = 'pl']) : super(locale);

  @override
  String get home => 'Strona główna';

  @override
  String get customizeHomePage => 'Dostosuj stronę główną';

  @override
  String get settings => 'Ustawienia';

  @override
  String get noSongsYet =>
      'Wygląda na to, że nie masz żadnych utworów w bibliotece: Przejdź do Ustawień, dodaj foldery z muzyką i zaktualizuj bibliotekę.';

  @override
  String get library => 'Biblioteka';

  @override
  String get search => 'Szukaj';

  @override
  String get updateLibrary => 'Aktualizuj bibliotekę';

  @override
  String get rescanAll => 'Rescan all files (slow)';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount wykonawców, $albumCount albumów, $songCount utworów';
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
  String get manageLibraryFolders => 'Zarządzaj folderami z muzyką';

  @override
  String get allowedFileExtensions => 'Dozwolone rozszerzenia plików';

  @override
  String get allowedFileExtensionsDescription =>
      'Lista dozwolonych formatów plików rozdzielona przecinkami. Małe i wielkie litery nie mają znaczenia. Jeśli nie jesteś pewien, jak to zmienić, pozostaw domyślną listę.';

  @override
  String get manageBlockedFiles => 'Zarządzaj zablokowanymi plikami';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Liczba zablokowanych plików: $blockedFiles';
  }

  @override
  String get playback => 'Odtwarzanie';

  @override
  String get playAlbumsInOrder => 'Odtwarzaj albumy w kolejności';

  @override
  String get playAlbumsInOrderDescription =>
      'Kiedy wybierzesz utwór w albubie, zostaną one odtworzone w kolejności albumu bez zachowania poprzedniego trybu odtwarzania.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Uznaj utwory za odtworzone po: $percentage%';
  }

  @override
  String get libraryFolders => 'Foldery biblioteki';

  @override
  String get blockedFiles => 'Zablokowane pliki';

  @override
  String get homeCustomization => 'Dostosowywanie strony głównej';

  @override
  String get albumOfTheDay => 'Album dnia';

  @override
  String get artistOfTheDay => 'Wykonawca dnia';

  @override
  String get shuffleAll => 'Losuj wszystko';

  @override
  String get history => 'Historia';

  @override
  String get addWidgetToHome => 'Dodaj widżet do ekranu głównego';

  @override
  String get noPlaylistsYet =>
      'Nie znaleziono playlist. Możesz dodać nową playlistę w bibliotece.';

  @override
  String get lastPlayed => 'Ostatnio odtwarzane';

  @override
  String get noHistoryYet => 'Nic tu nie ma. Zagraj coś.';

  @override
  String get allSongs => 'Wszystkie utwory';

  @override
  String get song => 'Utwór';

  @override
  String get songs => 'Utwory';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count utworów)',
      few: '$count utwory',
      one: 'jeden utwór',
      zero: 'brak utworów',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Album';

  @override
  String get albums => 'Albumy';

  @override
  String get artist => 'Wykonawca';

  @override
  String get artists => 'Wykonawcy';

  @override
  String get playlist => 'Playlista';

  @override
  String get playlists => 'Playlisty';

  @override
  String get smartlist => 'Inteligentna lista';

  @override
  String get smartlists => 'Inteligentne listy';

  @override
  String get noShuffle => 'Brak (zachowaj obecną losowość)';

  @override
  String get normalMode => 'Normalny';

  @override
  String get shuffleMode => 'Tryb losowania';

  @override
  String get favShuffleMode => 'Ulobiony tryb losowania';

  @override
  String get playlistNormalMode => 'Play from the top';

  @override
  String get playlistShuffleMode => 'Start shuffle playback';

  @override
  String get playlistFavShuffleMode => 'Start favorite shuffle playback';

  @override
  String get name => 'Nazwa';

  @override
  String get sortingFilterSettings => 'Ustawienia sortowania i filtrowania';

  @override
  String get maxNumberEntries => 'Maksymalna liczba pozycji';

  @override
  String get creationDate => 'Data utworzenia';

  @override
  String get changeDate => 'Data modyfikacji';

  @override
  String get lastTimePlayed => 'Ostatnio odtwarzane';

  @override
  String get ascending => 'Rosnąco';

  @override
  String get descending => 'Malejąco';

  @override
  String get both => 'Oba';

  @override
  String get playlistsOnly => 'Tylko playlisty';

  @override
  String get smartlistsOnly => 'Tylko inteligentne listy';

  @override
  String get displaySettings => 'Ustawienia wyświetlania';

  @override
  String get addSmartlist => 'Dodaj inteligentną listę';

  @override
  String get addPlaylist => 'Dodaj playlistę';

  @override
  String get createPlaylist => 'Utwórz playlistę';

  @override
  String get editPlaylist => 'Edytuj playlistę';

  @override
  String get customizeCover => 'Dostosuj okładkę';

  @override
  String get playbackMode => 'Tryb odtwarzania';

  @override
  String get excludeAllSongs =>
      'Wyklucz wszystkie utwory oznaczone jako wykluczenia.';

  @override
  String get excludeInShuffle => 'Wyklucz zaznaczone utwory z losowania.';

  @override
  String get excludeAlways =>
      'Wyklucz tylko utwory oznaczone jako zawsze do wykluczenia.';

  @override
  String get dontExclude => 'Nie wykluczaj żadnego utworu.';

  @override
  String get filterSettings => 'Ustawienia filtrowania';

  @override
  String filterLikes(int min, int max) {
    return 'Polubienia między $min i $max';
  }

  @override
  String get minPlayCount => 'Minimalna liczba odtworzeń';

  @override
  String get maxPlayCount => 'Maksymalna liczba odtworzeń';

  @override
  String get minYear => 'Minimalny rok';

  @override
  String get maxYear => 'Maksymalny rok';

  @override
  String selectArtistsExclude(int num) {
    return 'Wybierz wykonawców do wykluczenia: wybrano $num.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Wybierz wykonawców do uwzględnienia: wybrano $num.';
  }

  @override
  String get includeAllArtists =>
      'Uwzględnij wszyskich wykonawców, gdy nie zaznaczono żadnego.';

  @override
  String get excludeArtists => 'Wyklucz wybranych wykonawców';

  @override
  String get limitSongs => 'Ogranicz liczbę utworów';

  @override
  String get orderSettings => 'Ustawienia kolejności';

  @override
  String get orderSettingsDescription =>
      'Opcje zmiany kolejności i priorytetu.';

  @override
  String get createSmartlist => 'Utwórz inteligentną listę';

  @override
  String get editSmartlist => 'Edytuj inteligentną listę';

  @override
  String get play => 'Odtwórz';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'wybrano $count utworów',
      few: 'wybrano $count utwory',
      one: 'wybrano jeden utwór',
      zero: 'nie wybrano utworów',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Odtwórz następny';

  @override
  String get appendToQueued => 'Dołącz do utworów ręcznie dodanych do kolejki';

  @override
  String get addToQueue => 'Dodaj do kolejki';

  @override
  String get disc => 'Płyta';

  @override
  String get blockFromLibrary => 'Usuń z biblioteki i zablokuj';

  @override
  String get highlights => 'Wyróżnione';

  @override
  String get shuffle => 'Losuj';

  @override
  String get selectArtists => 'Wybierz wykonawców';

  @override
  String get removeFromQueue => 'Usuń z kolejki';

  @override
  String get currentlyPlaying => 'Teraz odtwarzane';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count utwory(-ów)',
      one: 'jeden utwór',
      zero: 'brak utworów',
    );
    return '$_temp0 w kolejce';
  }

  @override
  String moreAvailable(int num) {
    return 'Dostępne $num więcej';
  }

  @override
  String get nameMustNotBeEmpty => 'Nazwa nie może być pusta.';

  @override
  String get artistName => 'Nazwa wykonawcy';

  @override
  String get likeCount => 'Liczba polubień';

  @override
  String get playCount => 'Liczba odtworzeń';

  @override
  String get songTitle => 'Tytuł utworu';

  @override
  String get year => 'Rok';

  @override
  String get timeAdded => 'Czas dodania';

  @override
  String get addToPlaylist => 'Dodaj do playlisty';

  @override
  String get removeFromPlaylist => 'Usuń z playlisty';

  @override
  String get cancel => 'Odrzuć';

  @override
  String get nextUp => 'Następne w kolejce';

  @override
  String get previousSong => 'poprzedni';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'grano $count razy',
      one: 'grano raz',
      zero: 'nie grano',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => 'Zawsze najpierw graj poprzedni utwór';

  @override
  String get alwaysPlayNext => 'Zawsze graj potem następny utwór';

  @override
  String get dontExcludeSong => 'Nie wykluczaj tego utworu.';

  @override
  String get excludeShuffleAllSong =>
      'Wyklucz przy losowaniu wszystkich utworów.';

  @override
  String get excludeShuffleSong => 'Wyklucz przy losowaniu.';

  @override
  String get alwaysExcludeSong => 'Zawsze wykluczaj ten utwór.';

  @override
  String get welcomeToMucke => 'Witaj w mucke!';

  @override
  String get setupLibrary => 'Skonfiguruj bibliotekę';

  @override
  String get setupLibraryDescription =>
      'Wybierz foldery, dozwolone typy plików itd.';

  @override
  String get importData => 'Importuj dane';

  @override
  String get importDataDescription =>
      'Zaimportuj swoje dane z poprzedniej instalacji mucke.';

  @override
  String get yourLibrary => 'Twoja biblioteka:';

  @override
  String get scan => 'Skanuj';

  @override
  String get noFoldersSelected => 'Nie wybrano folderów.';

  @override
  String get addFolder => 'Dodaj folder';

  @override
  String get availableFromImport => 'Dostępne z zaimportowanych danych:';

  @override
  String get use => 'Użyj';

  @override
  String get reset => 'Resetuj';

  @override
  String get blockedFilesDescription =>
      'Zablokowane pliki z zaimportowanych danych. Tylko dokładne dopasowania zostaną wykluczone ze skanowania biblioteki. Pozostałe pliki możesz wykluczyć później w aplikacji.';

  @override
  String get importLibData => 'Importuj dane biblioteki';

  @override
  String get songMetaData => 'Metadane utworu';

  @override
  String metaDataAvailable(int num) {
    return 'Dostępne metadane dla $num utworów';
  }

  @override
  String get metaDataDescription => 'Importuj polubienia, wykluczenia itd.';

  @override
  String get imported => 'Zaimportowane';

  @override
  String get importVerb => 'Importuj';

  @override
  String get miscellaneous => 'Inne';

  @override
  String get exportData => 'Eksportuj dane';

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
      'Wybierz dane, które chcesz wyeksportować. Domyślnie wszystko jest wyeksportowane. Eksportując, możesz wybrać folder, w którym zostanie zapisany plik eksportu.';

  @override
  String get songsAlbumsArtists => 'Utwory, albumy i wykonawcy';

  @override
  String get librarySettings => 'Ustawienia biblioteki';

  @override
  String dataExportedTo(String path) {
    return 'Dane wyeksportowano do:\n$path';
  }

  @override
  String get dataExportFailed => 'Eksport danych nie powiódł się!';

  @override
  String get yourPlaylists => 'Twoje playlisty';

  @override
  String get systemSettings => 'Ustawienia systemowe';

  @override
  String get batteryExplanation =>
      'Od Androida 12 optymalizacja baterii powoduje błąd z powiadomieniem po utracie fokusu audio, na przykład podczas odbierania połączenia. Wyłączenie optymalizacji dla mucke rozwiązuje ten problem.';

  @override
  String get openBattery => 'Otwórz ustawienia baterii';

  @override
  String get disableBattery =>
      'Wyłącz optymalizację baterii dla mucke, by rozwiązać problemy z powiadomieniem.';

  @override
  String get disableBatteryDescription =>
      'Disabling battery optimization can solve potential notification issues.';

  @override
  String get disabledBattery => 'Optymalizacja baterii jest wyłączona.';

  @override
  String get manageExternalExplanation =>
      'Przyznanie tego uprawnienia może znacznie poprawić szybkość skanowania biblioteki. Nie zmienia to jednak zachowania aplikacji.';

  @override
  String get grantManagePermission =>
      'Przyznaj uprawnienie do zarządzania wszystkimi plikami.';

  @override
  String get managePermissionSubtitle =>
      'Odmówienie tego uprawnienia spowoduje restart aplikacji.';

  @override
  String get favorites => 'Ulubione';

  @override
  String get favoritesDesc => 'Zawiera wszystkie utwory, które lubisz.';

  @override
  String get newlyAdded => 'Ostatnio dodane';

  @override
  String get newlyAddedDesc => 'Zawiera 100 ostatnio dodanych utworów.';

  @override
  String get back => 'Wróć';

  @override
  String get next => 'Następny';

  @override
  String get finish => 'Zakończ';

  @override
  String get errorReadData => 'Błąd przy odczycie pliku.';

  @override
  String get createSmartlists => 'Utwórz inteligentne listy';

  @override
  String get createSmartlistsDesc =>
      'Utwórz sugerowane inteligentne listy, aby poprawić wrażenia ze słuchania. Możesz dostosować te listy później.';

  @override
  String get create => 'Utwórz';

  @override
  String get created => 'Utworzono';
}
