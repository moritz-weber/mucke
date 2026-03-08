// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class L10nDe extends L10n {
  L10nDe([String locale = 'de']) : super(locale);

  @override
  String get home => 'Startseite';

  @override
  String get customizeHomePage => 'Startseite anpassen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get noSongsYet =>
      'Du hast noch keine Lieder in deiner Bibliothek. Gehe in die Einstellungen, füge deine Musikordner hinzu und aktualisiere deine Bibliothek.';

  @override
  String get library => 'Bibliothek';

  @override
  String get search => 'Suche';

  @override
  String get updateLibrary => 'Bibliothek aktualisieren';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount Künstler, $albumCount Alben, $songCount Lieder';
  }

  @override
  String get manageLibraryFolders => 'Ordner der Bibliothek verwalten';

  @override
  String get allowedFileExtensions => 'Erlaubte Dateiendungen';

  @override
  String get allowedFileExtensionsDescription =>
      'Eine kommasepartierte Liste erlaubter Dateiendungen. Groß- und Kleinschreibung wird ignoriert. Falls du dir nicht sicher bist, verwende einfach die Standardeinstellung.';

  @override
  String get manageBlockedFiles => 'Geblockte Dateien verwalten';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Anzahl aktuell geblockter Dateien: $blockedFiles';
  }

  @override
  String get playback => 'Wiedergabe';

  @override
  String get playAlbumsInOrder => 'Alben geordnet abspielen';

  @override
  String get playAlbumsInOrderDescription =>
      'Wenn ein Lied in einem Album angeklickt wird, ignoriere den Wiedergabemodus und spiele die Lieder in der Reihenfolge des Albums ab.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Lieder als abgespielt zählen nach: $percentage%';
  }

  @override
  String get libraryFolders => 'Bibliotheksordner';

  @override
  String get blockedFiles => 'Geblockte Dateien';

  @override
  String get homeCustomization => 'Startseite anpassen';

  @override
  String get albumOfTheDay => 'Album des Tages';

  @override
  String get artistOfTheDay => 'Künstler des Tages';

  @override
  String get shuffleAll => 'Alles zufällig abspielen';

  @override
  String get history => 'Verlauf';

  @override
  String get addWidgetToHome => 'Füge deiner Startseite ein Widget hinzu';

  @override
  String get noPlaylistsYet =>
      'Du hast noch keine Playlists. Füge welche in der Bibliothek hinzu.';

  @override
  String get lastPlayed => 'Zuletzt gespielt';

  @override
  String get noHistoryYet =>
      'Hier gibt\'s noch nichts zu sehen. Spiele etwas ab.';

  @override
  String get allSongs => 'Alle Lieder';

  @override
  String get song => 'Lied';

  @override
  String get songs => 'Lieder';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Lieder',
      one: 'ein Lied',
      zero: 'keine Lieder',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Album';

  @override
  String get albums => 'Alben';

  @override
  String get artist => 'Künstler';

  @override
  String get artists => 'Künstler';

  @override
  String get playlist => 'Playlist';

  @override
  String get playlists => 'Playlists';

  @override
  String get smartlist => 'Smartlist';

  @override
  String get smartlists => 'Smartlists';

  @override
  String get noShuffle => 'Aktuellen Modus beibehalten';

  @override
  String get normalMode => 'Normale Wiedergabe';

  @override
  String get shuffleMode => 'Zufallswiedergabe';

  @override
  String get favShuffleMode => 'Favoriten-Zufallswiedergabe';

  @override
  String get name => 'Name';

  @override
  String get sortingFilterSettings => 'Sortierung und Filterung';

  @override
  String get maxNumberEntries => 'Maximale Anzahl an Einträgen';

  @override
  String get creationDate => 'Erstellungsdatum';

  @override
  String get changeDate => 'Änderungsdatum';

  @override
  String get lastTimePlayed => 'Zuletzt gespielt';

  @override
  String get ascending => 'Aufsteigend';

  @override
  String get descending => 'Absteigend';

  @override
  String get both => 'Beides';

  @override
  String get playlistsOnly => 'Nur Playlists';

  @override
  String get smartlistsOnly => 'Nur Smartlists';

  @override
  String get displaySettings => 'Anzeigeeinstellungen';

  @override
  String get addSmartlist => 'Smartlist hinzufügen';

  @override
  String get addPlaylist => 'Playlist hinzufügen';

  @override
  String get createPlaylist => 'Playlist erstellen';

  @override
  String get editPlaylist => 'Playlist bearbeiten';

  @override
  String get customizeCover => 'Coverbild anpassen';

  @override
  String get playbackMode => 'Wiedergabemodus';

  @override
  String get excludeAllSongs =>
      'Schließe alle Lieder aus, die für einen Ausschluss markiert sind.';

  @override
  String get excludeInShuffle =>
      'Schließe Lieder aus, die im Zufallsmodus ausgeschlossen werden sollen.';

  @override
  String get excludeAlways =>
      'Schließe nur Lieder aus, die immer ausgeschlossen werden sollen.';

  @override
  String get dontExclude => 'Schließe keine Lieder aus.';

  @override
  String get filterSettings => 'Filter';

  @override
  String filterLikes(int min, int max) {
    return 'Zwischen $min und $max Likes';
  }

  @override
  String get minPlayCount => 'Minimale Anzahl an Wiedergaben';

  @override
  String get maxPlayCount => 'Maximale Anzahl an Wiedergaben';

  @override
  String get minYear => 'Minimales Jahr';

  @override
  String get maxYear => 'Maximales Jahr';

  @override
  String selectArtistsExclude(int num) {
    return 'Wähle die auszuschließenden Künstler: $num ausgewählt.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Wähle die einzuschließenden Künstler: $num ausgewählt.';
  }

  @override
  String get includeAllArtists =>
      'Wenn keine Künstler ausgewählt sind, werden alle eingeschlossen.';

  @override
  String get excludeArtists => 'Künstler ausschließen';

  @override
  String get limitSongs => 'Anzahl der Lieder begrenzen';

  @override
  String get orderSettings => 'Sortierung';

  @override
  String get orderSettingsDescription =>
      'Sortiere die Optionen, um die Prioritäten zu ändern.';

  @override
  String get createSmartlist => 'Smartlist erstellen';

  @override
  String get editSmartlist => 'Smartlist bearbeiten';

  @override
  String get play => 'Abspielen';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Lieder ausgewählt',
      one: 'ein Lied ausgewählt',
      zero: 'keine Lieder ausgewählt',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Als nächstes abspielen';

  @override
  String get appendToQueued => 'An manuell hinzugefügte Lieder anhängen';

  @override
  String get addToQueue => 'Zur Warteschlange hinzufügen';

  @override
  String get disc => 'CD';

  @override
  String get blockFromLibrary => 'Aus Bibliothek entfernen und blockieren';

  @override
  String get highlights => 'Highlights';

  @override
  String get shuffle => 'Zufallswiedergabe';

  @override
  String get selectArtists => 'Künstler auswählen';

  @override
  String get removeFromQueue => 'Aus Warteschlange entfernen';

  @override
  String get currentlyPlaying => 'Aktuelle Wiedergabe';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Lieder',
      one: 'ein Lied',
      zero: 'keine Lieder',
    );
    return '$_temp0 in der Warteschlange';
  }

  @override
  String moreAvailable(int num) {
    return '$num mehr verfügbar';
  }

  @override
  String get nameMustNotBeEmpty => 'Der Name darf nicht leer bleiben.';

  @override
  String get artistName => 'Künstlername';

  @override
  String get likeCount => 'Anzahl der Likes';

  @override
  String get playCount => 'Anzahl der Wiedergaben';

  @override
  String get songTitle => 'Liedtitel';

  @override
  String get year => 'Jahr';

  @override
  String get timeAdded => 'Seit wann in der Bibliothek';

  @override
  String get addToPlaylist => 'Zu Playlist hinzufügen';

  @override
  String get removeFromPlaylist => 'Von Playlist entfernen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get nextUp => 'Als nächstes';

  @override
  String get previousSong => 'Vorheriges Lied';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mal gespiel',
      one: 'einmal gespielt',
      zero: 'noch nicht gespielt',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => 'Vorheriges Lied immer davor spielen';

  @override
  String get alwaysPlayNext => 'Nachfolgendes Lied immer danach spielen';

  @override
  String get dontExcludeSong => 'Diese Lied nicht ausschließen.';

  @override
  String get excludeShuffleAllSong =>
      'Ausschließen, wenn alle Lieder zufällig gespielt werden.';

  @override
  String get excludeShuffleSong => 'Im Zufallsmodus ausschließen.';

  @override
  String get alwaysExcludeSong => 'Immer ausschließen.';

  @override
  String get welcomeToMucke => 'Willkommen bei mucke!';

  @override
  String get setupLibrary => 'Bibliothek einrichten';

  @override
  String get setupLibraryDescription =>
      'Ordner, berücksichtigte Dateiendungen usw. auswählen';

  @override
  String get importData => 'Daten importieren';

  @override
  String get importDataDescription =>
      'Importiere Daten einer vorherigen Installation von mucke.';

  @override
  String get yourLibrary => 'Deine Bibliothek:';

  @override
  String get scan => 'Scannen';

  @override
  String get noFoldersSelected => 'Bisher keine Ordner ausgewählt.';

  @override
  String get addFolder => 'Ordner hinzufügen';

  @override
  String get availableFromImport => 'Verfügbar von importierten Daten:';

  @override
  String get use => 'Benutzen';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get blockedFilesDescription =>
      'Blockierte Dateien aus importierten Daten. Nur exakte Übereinstimmungen werden vom Scan ausgeschlossen. Zusätzliche Dateien können später in der App blockiert werden.';

  @override
  String get importLibData => 'Bibliotheksdaten importieren';

  @override
  String get songMetaData => 'Lieder-Metadaten';

  @override
  String metaDataAvailable(int num) {
    return 'Metadaten für $num Lieder verfügbar';
  }

  @override
  String get metaDataDescription => 'Importiere Likes, Blockierungen usw.';

  @override
  String get imported => 'Importiert';

  @override
  String get importVerb => 'Importieren';

  @override
  String get miscellaneous => 'Verschiedenes';

  @override
  String get exportData => 'Daten exportieren';

  @override
  String get exportDescription =>
      'Wähle die Daten, die du exportieren möchtest. Standardmäßig wird alles exportiert. Beim Exportieren kannst du einen Zielordner zum Speichern auswählen.';

  @override
  String get songsAlbumsArtists => 'Lieder, Alben und Künstler';

  @override
  String get librarySettings => 'Bibliothekseinstellungen';

  @override
  String dataExportedTo(String path) {
    return 'Daten exportiert nach:\n$path';
  }

  @override
  String get dataExportFailed => 'Datenexport fehlgeschlagen!';

  @override
  String get yourPlaylists => 'Deine Playlists';

  @override
  String get systemSettings => 'Systemeinstellungen';

  @override
  String get batteryExplanation =>
      'Ab Android 12 verursacht die Akku-Optimierung Probleme mit der Benachrichtigung, nachdem der Audiofokus verloren wurde, bspw. bei einem Anruf. Das Deaktivieren der Optimierung für mucke behebt dieses Problem.';

  @override
  String get openBattery => 'Akku-Einstellungen öffnen';

  @override
  String get disableBattery =>
      'Deaktiviere die Optimierung für mucke, um die Probleme mit der Benachrichtigung zu beheben.';

  @override
  String get disabledBattery => 'Die Akku-Optimierung ist deaktiviert.';

  @override
  String get manageExternalExplanation =>
      'Das Erteilen dieser Berechtigung kann das Scannen der Bibliothek deutlich beschleunigen. Ansonsten ändert sich nichts am Verhalten der App.';

  @override
  String get grantManagePermission =>
      'Berechtigung zum Verwalten aller Dateien erteilen.';

  @override
  String get managePermissionSubtitle =>
      'Die Rücknahme der Berechtigung führt zu einem Neustart der App.';

  @override
  String get favorites => 'Favoriten';

  @override
  String get favoritesDesc => 'Enthält alle Lieder, die du magst.';

  @override
  String get newlyAdded => 'Neu hinzugefügt';

  @override
  String get newlyAddedDesc =>
      'Enthält die 100 Lieder, die zuletzt hinzugefügt wurden.';

  @override
  String get back => 'Zurück';

  @override
  String get next => 'Weiter';

  @override
  String get finish => 'Fertig';

  @override
  String get errorReadData => 'Fehler beim Lesen der Datei.';

  @override
  String get createSmartlists => 'Smartlists erstellen';

  @override
  String get createSmartlistsDesc =>
      'Erstelle die empfohlenen Smartlists, um dein Hörerlebnis zu verbessern. Du kannst die Listen später anpassen.';

  @override
  String get create => 'Erzeugen';

  @override
  String get created => 'Erzeugt';
}
