// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class L10nCa extends L10n {
  L10nCa([String locale = 'ca']) : super(locale);

  @override
  String get home => 'Inici';

  @override
  String get customizeHomePage => 'Personalitza la pàgina d\'inici';

  @override
  String get settings => 'Configuració';

  @override
  String get noSongsYet =>
      'Sembla que no hi ha cançons a vostra llibreria: Aneu a configuració, afegiu carpetes amb música i actualitzeu la llibreria.';

  @override
  String get library => 'Llibreria';

  @override
  String get search => 'Cerca';

  @override
  String get updateLibrary => 'Actualitza la llibreria';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount artistes, $albumCount àlbums, $songCount cançons';
  }

  @override
  String get manageLibraryFolders => 'Gestiona les llibreries de carpetes';

  @override
  String get allowedFileExtensions => 'Extensions d\'arxius vàlides';

  @override
  String get allowedFileExtensionsDescription =>
      'Llista separada per comes. Sense importar si és majúscula o minúscula.';

  @override
  String get manageBlockedFiles => 'Gestiona els fitxers bloquejats';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Nombre d\'arxius bloquejats: $blockedFiles';
  }

  @override
  String get playback => 'Playback';

  @override
  String get playAlbumsInOrder => 'Reprodueix els àlbums en ordre';

  @override
  String get playAlbumsInOrderDescription =>
      'Quan seleccioneu una cançó d\'un àlbum, les cançons es reproduiran en ordre en lloc de l\'ordre de reproducció anterior.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Conta les cançons com a reproduïdes després de: $percentage%';
  }

  @override
  String get libraryFolders => 'Llibreria de carpetes';

  @override
  String get blockedFiles => 'Arxius bloquejats';

  @override
  String get homeCustomization => 'Personalització de l\'inici';

  @override
  String get albumOfTheDay => 'Àlbum del dia';

  @override
  String get artistOfTheDay => 'Artista del dia';

  @override
  String get shuffleAll => 'Barreja-ho tot';

  @override
  String get history => 'Historial';

  @override
  String get addWidgetToHome => 'Afegiu un giny a la vostra pàgina d\'inici';

  @override
  String get noPlaylistsYet =>
      'No hi ha cap llista de reproducció. Podeu crear-ne en la llibreria.';

  @override
  String get lastPlayed => 'Últims reproduïts';

  @override
  String get noHistoryYet => 'No hi ha res aquí. Reproduïu alguna cosa.';

  @override
  String get allSongs => 'Totes les cançons';

  @override
  String get song => 'Cançó';

  @override
  String get songs => 'Cançons';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cançons',
      one: 'una cançó',
      zero: 'cap cançó',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Àlbum';

  @override
  String get albums => 'Àlbums';

  @override
  String get artist => 'Artista';

  @override
  String get artists => 'Artistes';

  @override
  String get playlist => 'Llista de reproducció';

  @override
  String get playlists => 'Llistes de reproducció';

  @override
  String get smartlist => 'Llista intel·ligent';

  @override
  String get smartlists => 'Llistes intel·ligents';

  @override
  String get noShuffle => 'Cap (mantenir el mode aleatori actiu)';

  @override
  String get normalMode => 'Mode normal';

  @override
  String get shuffleMode => 'Mode aleatori';

  @override
  String get favShuffleMode => 'Mode aleatori preferit';

  @override
  String get name => 'Nom';

  @override
  String get sortingFilterSettings => 'Ordenació i filtres';

  @override
  String get maxNumberEntries => 'Nombre màxim d\'entrades';

  @override
  String get creationDate => 'Data de creació';

  @override
  String get changeDate => 'Data de canvi';

  @override
  String get lastTimePlayed => 'Última volta que es va reproduir';

  @override
  String get ascending => 'Ascendent';

  @override
  String get descending => 'Descendent';

  @override
  String get both => 'Ambdós';

  @override
  String get playlistsOnly => 'Només llistes de reproducció';

  @override
  String get smartlistsOnly => 'Només llistes intel·ligents';

  @override
  String get displaySettings => 'Mostra la configuració';

  @override
  String get addSmartlist => 'Afegiu llista intel·ligent';

  @override
  String get addPlaylist => 'Afig llista de reproducció';

  @override
  String get createPlaylist => 'Crea una llista de reproducció';

  @override
  String get editPlaylist => 'Edita la llista de reproducció';

  @override
  String get customizeCover => 'Personalitza la caràtula';

  @override
  String get playbackMode => 'Mode playback';

  @override
  String get excludeAllSongs =>
      'Exclou totes les cançons marcades per excloure.';

  @override
  String get excludeInShuffle =>
      'Exclou les cançons marcades per excloure del mode aleatori.';

  @override
  String get excludeAlways =>
      'Exclou només les cançons marcades com \"excloure sempre\".';

  @override
  String get dontExclude => 'No excloguis cap cançó.';

  @override
  String get filterSettings => 'Filtra';

  @override
  String filterLikes(int min, int max) {
    return 'Nombre de m\'agrada entre $min i $max';
  }

  @override
  String get minPlayCount => 'Minimum play count';

  @override
  String get maxPlayCount => 'Maximum play count';

  @override
  String get minYear => 'Any mínim';

  @override
  String get maxYear => 'Any màxim';

  @override
  String selectArtistsExclude(int num) {
    return 'Selecciona artistes per excloure: $num seleccionats.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Selecciona artistes per incloure: $num seleccionats.';
  }

  @override
  String get includeAllArtists =>
      'Inclou tots els artistes si no se n\'ha seleccionat cap.';

  @override
  String get excludeArtists => 'Exclou els artistes seleccionats';

  @override
  String get limitSongs => 'Limita el nombre de cançons';

  @override
  String get orderSettings => 'Configuració d\'ordre';

  @override
  String get orderSettingsDescription =>
      'Reorder options to change priorities.';

  @override
  String get createSmartlist => 'Crea una llista intel·ligent';

  @override
  String get editSmartlist => 'Edita la llista intel·ligent';

  @override
  String get play => 'Reprodueix';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cançons seleccionades',
      one: 'una cançó seleccionada',
      zero: 'cap cançó seleccionada',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Reprodueix a continuació';

  @override
  String get appendToQueued => 'Adjunta a les cançons en cua';

  @override
  String get addToQueue => 'Afig a la cua';

  @override
  String get disc => 'Disc';

  @override
  String get blockFromLibrary => 'Elimina i bloqueja de la llibreria';

  @override
  String get highlights => 'Destacats';

  @override
  String get shuffle => 'Aleatori';

  @override
  String get selectArtists => 'Artistes seleccionats';

  @override
  String get removeFromQueue => 'Elimina de la cua';

  @override
  String get currentlyPlaying => 'Reproduint';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cançons',
      one: 'una cançó',
      zero: 'cap cançó',
    );
    return '$_temp0 en cua';
  }

  @override
  String moreAvailable(int num) {
    return '$num més disponibles';
  }

  @override
  String get nameMustNotBeEmpty => 'El nom no pot estar buit.';

  @override
  String get artistName => 'Nom de l\'artista';

  @override
  String get likeCount => 'Número de m\'agrada';

  @override
  String get playCount => 'Número de reproduccions';

  @override
  String get songTitle => 'Títol de la cançó';

  @override
  String get year => 'Any';

  @override
  String get timeAdded => 'Time added';

  @override
  String get addToPlaylist => 'Afig a la llista de reproducció';

  @override
  String get removeFromPlaylist => 'Elimina de la llista de reproducció';

  @override
  String get cancel => 'Cancel·la';

  @override
  String get nextUp => 'A continuació';

  @override
  String get previousSong => 'anterior';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'reproduït $count voltes',
      one: 'reproduït una volta',
      zero: 'no reproduït',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => 'Reprodueix sempre la cançó anterior primer';

  @override
  String get alwaysPlayNext => 'Reprodueix sempre la cançó següent primer';

  @override
  String get dontExcludeSong => 'No exclogues esta cançó.';

  @override
  String get excludeShuffleAllSong =>
      'Exclou quan es barregen totes les cançons.';

  @override
  String get excludeShuffleSong => 'Exclude when shuffling.';

  @override
  String get alwaysExcludeSong => 'Exclou sempre aquesta cançó.';

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
