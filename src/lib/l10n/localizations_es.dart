// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class L10nEs extends L10n {
  L10nEs([String locale = 'es']) : super(locale);

  @override
  String get home => 'Página de inicio';

  @override
  String get customizeHomePage => 'Customizar la página de inicio';

  @override
  String get settings => 'Ajustes';

  @override
  String get noSongsYet =>
      'Parece que no tienes canciones en tu biblioteca: ve a ajustes, añade carpetas de música y actualiza tu biblioteca.';

  @override
  String get library => 'Biblioteca';

  @override
  String get search => 'Buscar';

  @override
  String get updateLibrary => 'Actualiza biblioteca';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '${artistCount}artistas, $albumCount álbumes, $songCount canciones';
  }

  @override
  String get manageLibraryFolders => 'Administra carpetas de la biblioteca';

  @override
  String get allowedFileExtensions => 'Extensiones de archivo permitidas';

  @override
  String get allowedFileExtensionsDescription =>
      'Lista separada por comas. Mayúsculas o minúsculas no importan.';

  @override
  String get manageBlockedFiles => 'Administrar archivos bloqueados';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Número actual de archivos bloqueados: $blockedFiles';
  }

  @override
  String get playback => 'Reproducción';

  @override
  String get playAlbumsInOrder => 'Reproducir álbumes en orden';

  @override
  String get playAlbumsInOrderDescription =>
      'Cuando reproduzca una canción en un álbum, las canciones serán reproducidas en orden en lugar de mantener el modo de reproducción anterior.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Contar canciones como reproducidas después de: $percentage%';
  }

  @override
  String get libraryFolders => 'Biblioteca de carpetas';

  @override
  String get blockedFiles => 'Archivos bloqueados';

  @override
  String get homeCustomization => 'Personalizar inicio';

  @override
  String get albumOfTheDay => 'Álbum del día';

  @override
  String get artistOfTheDay => 'Artista del día';

  @override
  String get shuffleAll => 'Todo en aleatorio';

  @override
  String get history => 'Historial';

  @override
  String get addWidgetToHome => 'Añadir widget a la pantalla de inicio';

  @override
  String get noPlaylistsYet =>
      'No hay listas de reproducción aún. Puedes añadirlas en la biblioteca.';

  @override
  String get lastPlayed => 'Reproducido por última vez';

  @override
  String get noHistoryYet => 'Nada que ver aún. Reproduce algo.';

  @override
  String get allSongs => 'Todas las canciones';

  @override
  String get song => 'Canción';

  @override
  String get songs => 'Canciones';

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
  String get album => 'Álbum';

  @override
  String get albums => 'Álbumes';

  @override
  String get artist => 'Artista';

  @override
  String get artists => 'Artistas';

  @override
  String get playlist => 'LIsta de reproducción';

  @override
  String get playlists => 'Listas de reproducción';

  @override
  String get smartlist => 'Lista inteligente';

  @override
  String get smartlists => 'Listas inteligentes';

  @override
  String get noShuffle => 'Ninguno (mantener el modo aleatorio actual)';

  @override
  String get normalMode => 'Modo normal';

  @override
  String get shuffleMode => 'Modo aleatorio';

  @override
  String get favShuffleMode => 'Modo aleatorio favorito';

  @override
  String get name => 'Nombre';

  @override
  String get sortingFilterSettings => 'Ajustes de orden y filtro';

  @override
  String get maxNumberEntries => 'Número máximo de entradas';

  @override
  String get creationDate => 'Fecha de creación';

  @override
  String get changeDate => 'Cambiar la fecha';

  @override
  String get lastTimePlayed => 'Última vez reproducido';

  @override
  String get ascending => 'Ascendente';

  @override
  String get descending => 'Descendiendo';

  @override
  String get both => 'Ambos';

  @override
  String get playlistsOnly => 'Sólo listas de reproducción';

  @override
  String get smartlistsOnly => 'Sólo listas de reproducción inteligentes';

  @override
  String get displaySettings => 'Ajustes de visualización';

  @override
  String get addSmartlist => 'Añadir lista inteligente';

  @override
  String get addPlaylist => 'Añadir lista de reproducción';

  @override
  String get createPlaylist => 'Crear lista de reproducción';

  @override
  String get editPlaylist => 'Editar lista de reproducción';

  @override
  String get customizeCover => 'Personalizar portada';

  @override
  String get playbackMode => 'Modo de reproducción';

  @override
  String get excludeAllSongs =>
      'Excluir todas las canciones marcadas para exclusión.';

  @override
  String get excludeInShuffle =>
      'Excluir canciones marcadas para exclusión en modo aleatorio.';

  @override
  String get excludeAlways =>
      'Excluir sólo canciones marcadas como siempre excluir.';

  @override
  String get dontExclude => 'No excluir ninguna canción.';

  @override
  String get filterSettings => 'Ajustes de filtro';

  @override
  String filterLikes(int min, int max) {
    return 'Me gusta entre $min y $max';
  }

  @override
  String get minPlayCount => 'Conteo de reproducción mínimo';

  @override
  String get maxPlayCount => 'Conteo de reproducción máximo';

  @override
  String get minYear => 'Año mínimo';

  @override
  String get maxYear => 'Año máximo';

  @override
  String selectArtistsExclude(int num) {
    return 'Seleccione artistas para excluir: $num seleccionados.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Seleccione artistas para incluir: $num seleccionados.';
  }

  @override
  String get includeAllArtists =>
      'Incluir todos los artistas si ninguno fue seleccionado.';

  @override
  String get excludeArtists => 'Excluir todos los artistas seleccionados';

  @override
  String get limitSongs => 'Limitar número de canciones';

  @override
  String get orderSettings => 'Ajustes de orden';

  @override
  String get orderSettingsDescription =>
      'Reordenar opciones para cambiar prioridades.';

  @override
  String get createSmartlist => 'Crear lista inteligente';

  @override
  String get editSmartlist => 'Editar lista inteligente';

  @override
  String get play => 'Reproducir';

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
  String get playNext => 'Reproducir siguiente';

  @override
  String get appendToQueued =>
      'Añadir al final las canciones puestas en fila manualmente';

  @override
  String get addToQueue => 'Añadir a la fila';

  @override
  String get disc => 'Disco';

  @override
  String get blockFromLibrary => 'Remover y bloquear de la biblioteca';

  @override
  String get highlights => 'Destacados';

  @override
  String get shuffle => 'Aleatorio';

  @override
  String get selectArtists => 'Seleccione artistas';

  @override
  String get removeFromQueue => 'Remover de la fila';

  @override
  String get currentlyPlaying => 'Reproduciendo actualmente';

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
    return '$num más disponibles';
  }

  @override
  String get nameMustNotBeEmpty => 'El nombre no debe estar vacío.';

  @override
  String get artistName => 'Nombre del artista';

  @override
  String get likeCount => 'Conteo de me gusta';

  @override
  String get playCount => 'Conteo de reproducción';

  @override
  String get songTitle => 'Título de canción';

  @override
  String get year => 'Año';

  @override
  String get timeAdded => 'Tiempo añadido';

  @override
  String get addToPlaylist => 'Añadir a la lista de reproducción';

  @override
  String get removeFromPlaylist => 'Remover de la lista de reproducción';

  @override
  String get cancel => 'Cancelar';

  @override
  String get nextUp => 'A continuación';

  @override
  String get previousSong => 'Anterior';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'played $count times',
      one: 'played one time',
      zero: 'not played yet',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious =>
      'Siempre reproducir la canción anterior antes';

  @override
  String get alwaysPlayNext =>
      'Siempre reproducir la siguiente canción después';

  @override
  String get dontExcludeSong => 'No excluir esta canción.';

  @override
  String get excludeShuffleAllSong =>
      'Excluir al reproducir todas las canciones en aleatorio.';

  @override
  String get excludeShuffleSong => 'Excluir cuando esté en aleatorio.';

  @override
  String get alwaysExcludeSong => 'Siempre excluir esta canción.';

  @override
  String get welcomeToMucke => '¡Bienvenido a Mucke!';

  @override
  String get setupLibrary => 'Organizar tu Colección';

  @override
  String get setupLibraryDescription =>
      'Select folders, included file extensions, etc.';

  @override
  String get importData => 'Importar tu datos';

  @override
  String get importDataDescription =>
      'Import your data from a previous mucke installation.';

  @override
  String get yourLibrary => 'Tu Colección:';

  @override
  String get scan => 'Escanear';

  @override
  String get noFoldersSelected => 'No folders selected so far.';

  @override
  String get addFolder => 'Añadir una carpeta';

  @override
  String get availableFromImport => 'Available from imported data:';

  @override
  String get use => 'Usar';

  @override
  String get reset => 'Reiniciar';

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
