// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class L10nEs extends L10n {
  L10nEs([String locale = 'es']) : super(locale);

  @override
  String get home => 'Inicio';

  @override
  String get customizeHomePage => 'Personalizar Página de Inicio';

  @override
  String get settings => 'Ajustes';

  @override
  String get noSongsYet =>
      'Parece que no tienes canciones en tu biblioteca: Ve a ajustes, añade carpetas de música y actualiza tu biblioteca.';

  @override
  String get library => 'Biblioteca';

  @override
  String get search => 'Buscar';

  @override
  String get updateLibrary => 'Actualizar biblioteca';

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
      'Una lista separada por comas de extensiones de archivo permitidas. Mayúsculas o minúsculas no importan. Si no sabes qué poner, deja los valores por defecto.';

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
  String get libraryFolders => 'Carpetas de la Biblioteca';

  @override
  String get blockedFiles => 'Archivos Bloqueados';

  @override
  String get homeCustomization => 'Personalización de Inicio';

  @override
  String get albumOfTheDay => 'Álbum del Día';

  @override
  String get artistOfTheDay => 'Artista del Día';

  @override
  String get shuffleAll => 'Todo Aleatorio';

  @override
  String get history => 'Historial';

  @override
  String get addWidgetToHome => 'Añadir Widget a la Pantalla de Inicio';

  @override
  String get noPlaylistsYet =>
      'No hay listas de reproducción aún. Puedes añadirlas en la biblioteca.';

  @override
  String get lastPlayed => 'Reproducido por última vez';

  @override
  String get noHistoryYet => 'Nada que ver aún. Reproduce algo.';

  @override
  String get allSongs => 'Todas las Canciones';

  @override
  String get song => 'Canción';

  @override
  String get songs => 'Canciones';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count canciones',
      one: 'una canción',
      zero: 'sin canciones',
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
  String get playlist => 'Lista de reproducción';

  @override
  String get playlists => 'Listas de reproducción';

  @override
  String get smartlist => 'Lista inteligente';

  @override
  String get smartlists => 'Listas inteligentes';

  @override
  String get noShuffle => 'Ninguno (mantener el modo aleatorio actual)';

  @override
  String get normalMode => 'Modo Normal';

  @override
  String get shuffleMode => 'Modo Aleatorio';

  @override
  String get favShuffleMode => 'Modo Aleatorio de Favoritas';

  @override
  String get playlistNormalMode => 'Play from the top';

  @override
  String get playlistShuffleMode => 'Start shuffle playback';

  @override
  String get playlistFavShuffleMode => 'Start favorite shuffle playback';

  @override
  String get name => 'Nombre';

  @override
  String get sortingFilterSettings => 'Ajustes de Orden y Filtro';

  @override
  String get maxNumberEntries => 'Número máximo de entradas';

  @override
  String get creationDate => 'Fecha de Creación';

  @override
  String get changeDate => 'Fecha de Modificación';

  @override
  String get lastTimePlayed => 'Última por Última Vez';

  @override
  String get ascending => 'Ascendente';

  @override
  String get descending => 'Descendiente';

  @override
  String get both => 'Ambos';

  @override
  String get playlistsOnly => 'Sólo Listas de Reproducción';

  @override
  String get smartlistsOnly => 'Sólo Listas de Reproducción Inteligentes';

  @override
  String get displaySettings => 'Ajustes de Visualización';

  @override
  String get addSmartlist => 'Añadir Lista Inteligente';

  @override
  String get addPlaylist => 'Añadir Lista de Reproducción';

  @override
  String get createPlaylist => 'Crear Lista de Reproducción';

  @override
  String get editPlaylist => 'Editar Lista de Reproducción';

  @override
  String get customizeCover => 'Personalizar Portada';

  @override
  String get playbackMode => 'Modo de Reproducción';

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
  String get filterSettings => 'Ajustes de Filtro';

  @override
  String filterLikes(int min, int max) {
    return 'Favoritos entre $min y $max';
  }

  @override
  String get minPlayCount => 'Número de reproducciones mínimas';

  @override
  String get maxPlayCount => 'Número de reproducciones máximo';

  @override
  String get minYear => 'Año Mínimo';

  @override
  String get maxYear => 'Año Máximo';

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
  String get orderSettings => 'Ajustes de Orden';

  @override
  String get orderSettingsDescription =>
      'Reordenar opciones para cambiar prioridades.';

  @override
  String get createSmartlist => 'Crear Lista Inteligente';

  @override
  String get editSmartlist => 'Editar Lista Inteligente';

  @override
  String get play => 'Reproducir';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count canciones seleccionadas',
      one: 'una canción seleccionada',
      zero: 'ninguna canción seleccionada',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Reproducir siguiente';

  @override
  String get appendToQueued =>
      'Añadir al final de las canciones manualmente encoladas';

  @override
  String get addToQueue => 'Añadir a la cola';

  @override
  String get disc => 'Disco';

  @override
  String get blockFromLibrary => 'Eliminar y bloquear de la biblioteca';

  @override
  String get highlights => 'Destacados';

  @override
  String get shuffle => 'Aleatorio';

  @override
  String get selectArtists => 'Seleccionar Artistas';

  @override
  String get removeFromQueue => 'Eliminar de la cola';

  @override
  String get currentlyPlaying => 'Reproduciendo actualmente';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count canciones',
      one: 'una canción',
      zero: 'ninguna canción',
    );
    return '$_temp0 en cola';
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
  String get likeCount => 'Número de favoritos';

  @override
  String get playCount => 'Número de reproducciones';

  @override
  String get songTitle => 'Título de canción';

  @override
  String get year => 'Año';

  @override
  String get timeAdded => 'Fecha añadida';

  @override
  String get addToPlaylist => 'Añadir a la lista de reproducción';

  @override
  String get removeFromPlaylist => 'Eliminar de la lista de reproducción';

  @override
  String get cancel => 'Cancelar';

  @override
  String get nextUp => 'A continuación';

  @override
  String get previousSong => 'anterior';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'reproducida $count veces',
      one: 'reproducida una vez',
      zero: 'ninguna reproducción',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious =>
      'Siempre reproducir previamente la canción anterior';

  @override
  String get alwaysPlayNext =>
      'Siempre reproducir a continuación la siguiente canción';

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
  String get setupLibrary => 'Configurar Biblioteca';

  @override
  String get setupLibraryDescription =>
      'Seleccionar carpetas, extensiones de archivos incluidas, etc.';

  @override
  String get importData => 'Importar datos';

  @override
  String get importDataDescription =>
      'Importar datos de una instalación previa de mucke.';

  @override
  String get yourLibrary => 'Tu Biblioteca:';

  @override
  String get scan => 'Escanear';

  @override
  String get noFoldersSelected => 'Ninguna carpeta seleccionada.';

  @override
  String get addFolder => 'Añadir una carpeta';

  @override
  String get availableFromImport => 'Disponible de los datos importados:';

  @override
  String get use => 'Usar';

  @override
  String get reset => 'Reiniciar';

  @override
  String get blockedFilesDescription =>
      'Archivos bloqueados de los datos importados. Sólo las coincidencias exactas serán excluidas del escaneo de la biblioteca. Se pueden bloquear archivos adicionales más adelante en la aplicación.';

  @override
  String get importLibData => 'Importar Datos de la Biblioteca';

  @override
  String get songMetaData => 'Metadatos de Canciones';

  @override
  String metaDataAvailable(int num) {
    return 'Hay metadatos disponibles para $num canciones';
  }

  @override
  String get metaDataDescription => 'Importar favoritos, bloqueos, etc.';

  @override
  String get imported => 'Importado';

  @override
  String get importVerb => 'Importar';

  @override
  String get miscellaneous => 'Misceláneo';

  @override
  String get exportData => 'Exportar datos';

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
      'Selecciona los datos que deseas exportar. Por defecto, todo se exporta. Al exportar, puedes seleccionar una carpeta para almacenar el archivo.';

  @override
  String get songsAlbumsArtists => 'Canciones, Álbumes, y Artistas';

  @override
  String get librarySettings => 'Ajustes de la Biblioteca';

  @override
  String dataExportedTo(String path) {
    return 'Datos exportados a:\n$path';
  }

  @override
  String get dataExportFailed => '¡Exportación de datos fallida!';

  @override
  String get yourPlaylists => 'Tus Listas de Reproducción';

  @override
  String get systemSettings => 'Ajustes del Sistema';

  @override
  String get batteryExplanation =>
      'A partir de Android 12, la optimización de la batería provoca un error en la notificación tras perder el foco del audio, por ejemplo al recibir una llamada. Deshabilitar la optimización para mucke resuelve este problema.';

  @override
  String get openBattery => 'Abrir ajustes de batería';

  @override
  String get disableBattery =>
      'Desactiva la optimización de batería para mucke.';

  @override
  String get disableBatteryDescription =>
      'La optimización de la batería puede resolver posibles incidencias de notificación.';

  @override
  String get disabledBattery =>
      'La optimización de la batería está deshabilitada.';

  @override
  String get manageExternalExplanation =>
      'Conceder este permiso puede mejorar significativamente la velocidad de los análisis de la biblioteca. Más alla de eso, no cambia el comportamiento de la aplicación.';

  @override
  String get grantManagePermission =>
      'Conceder permiso para gestionar todos los archivos.';

  @override
  String get managePermissionSubtitle =>
      'Revocar el permiso resultará en un reinicio de la aplicación.';

  @override
  String get favorites => 'Favoritas';

  @override
  String get favoritesDesc =>
      'Contiene todas las canciones que te han gustado.';

  @override
  String get newlyAdded => 'Añadidas recientemente';

  @override
  String get newlyAddedDesc => 'Contiene las última 100 canciones añadidas.';

  @override
  String get back => 'Anterior';

  @override
  String get next => 'Siguiente';

  @override
  String get finish => 'Finalizar';

  @override
  String get errorReadData => 'Error al leer datos del fichero.';

  @override
  String get createSmartlists => 'Crear Listas Inteligentes';

  @override
  String get createSmartlistsDesc =>
      'Crea listas inteligentes sugeridas para mejorar tu experiencia de reproducción. Puedes personalizar estas listas más adelante.';

  @override
  String get create => 'Crear';

  @override
  String get created => 'Creada';
}
