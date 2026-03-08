// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class L10nIt extends L10n {
  L10nIt([String locale = 'it']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get customizeHomePage => 'Personalizza Pagina Home';

  @override
  String get settings => 'Impostazioni';

  @override
  String get noSongsYet =>
      'Sembra che tu non abbia alcuna canzone nella tua libreria: Vai nelle impostazioni, aggiungi le tue cartelle della musica, e aggiorna la tua libreria.';

  @override
  String get library => 'Libreria';

  @override
  String get search => 'Ricerca';

  @override
  String get updateLibrary => 'Aggiorna libreria';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount artisti, $albumCount album, $songCount canzoni';
  }

  @override
  String get manageLibraryFolders => 'Gestisci cartelle libreria';

  @override
  String get allowedFileExtensions => 'Estensioni file permesse';

  @override
  String get allowedFileExtensionsDescription =>
      'Una lista separata da virgola di estensioni file permesse. Maiuscolo o minuscolo non importa. Se non sei certo di quello che stai facendo, limitati a usare quelle predefinite.';

  @override
  String get manageBlockedFiles => 'Gestisci file bloccati';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Numero di file bloccati al momento: $blockedFiles';
  }

  @override
  String get playback => 'Riproduzione';

  @override
  String get playAlbumsInOrder => 'Riproduci album in ordine';

  @override
  String get playAlbumsInOrderDescription =>
      'Quando clicchi una canzone in un album, le canzoni saranno riprodotte in ordine invece di mantenere la modalità di riproduzione precedente.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Considera le canzoni riprodotte dopo il: $percentage%';
  }

  @override
  String get libraryFolders => 'Cartelle Libreria';

  @override
  String get blockedFiles => 'File Bloccati';

  @override
  String get homeCustomization => 'Personalizzazione Home';

  @override
  String get albumOfTheDay => 'Album del Giorno';

  @override
  String get artistOfTheDay => 'Artista del Giorno';

  @override
  String get shuffleAll => 'Mischia Tutto';

  @override
  String get history => 'Cronologia';

  @override
  String get addWidgetToHome => 'Aggiungi un Widget alla Tua Schermata Home';

  @override
  String get noPlaylistsYet =>
      'Ancora nessuna playlist. Puoi aggiungerle nella libreria.';

  @override
  String get lastPlayed => 'Ultime riproduzioni';

  @override
  String get noHistoryYet => 'Ancora niente da vedere qui. Riproduci qualcosa.';

  @override
  String get allSongs => 'Tutte le Canzoni';

  @override
  String get song => 'Canzone';

  @override
  String get songs => 'Canzoni';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count canzoni',
      one: 'una canzone',
      zero: 'nessuna canzone',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Album';

  @override
  String get albums => 'Album';

  @override
  String get artist => 'Artista';

  @override
  String get artists => 'Artisti';

  @override
  String get playlist => 'Playlist';

  @override
  String get playlists => 'Playlist';

  @override
  String get smartlist => 'Smartlist';

  @override
  String get smartlists => 'Smartlist';

  @override
  String get noShuffle => 'Nessuna (mantieni la modalità casuale corrente)';

  @override
  String get normalMode => 'Modalità Normale';

  @override
  String get shuffleMode => 'Modalità Casuale';

  @override
  String get favShuffleMode => 'Modalità Casuale Preferita';

  @override
  String get name => 'Nome';

  @override
  String get sortingFilterSettings => 'Impostazioni Ordinamento e Filtri';

  @override
  String get maxNumberEntries => 'Numero massimo di elementi';

  @override
  String get creationDate => 'Data Creazione';

  @override
  String get changeDate => 'Data Modifica';

  @override
  String get lastTimePlayed => 'Riprodotto per l\'Ultima Volta';

  @override
  String get ascending => 'Crescente';

  @override
  String get descending => 'Decrescente';

  @override
  String get both => 'Entrambe';

  @override
  String get playlistsOnly => 'Solo Playlist';

  @override
  String get smartlistsOnly => 'Solo Smartlist';

  @override
  String get displaySettings => 'Impostazioni Visualizzazione';

  @override
  String get addSmartlist => 'Aggiungi Smartlist';

  @override
  String get addPlaylist => 'Aggiungi Playlist';

  @override
  String get createPlaylist => 'Crea Playlist';

  @override
  String get editPlaylist => 'Modifica Playlist';

  @override
  String get customizeCover => 'Personalizza Copertina';

  @override
  String get playbackMode => 'Modalità Riproduzione';

  @override
  String get excludeAllSongs =>
      'Escudi tutte le canzoni contrassegnate per l\'esclusione.';

  @override
  String get excludeInShuffle =>
      'Escludi tutte le canzoni contrassegnate per l\'esclusione in modalità casuale.';

  @override
  String get excludeAlways =>
      'Escludi solo le canzoni contrassegnate con \"escludi sempre\".';

  @override
  String get dontExclude => 'Non escludere alcuna canzone.';

  @override
  String get filterSettings => 'Impostazioni Filtro';

  @override
  String filterLikes(int min, int max) {
    return '\"Mi piace\" tra $min e $max';
  }

  @override
  String get minPlayCount => 'Numero riproduzioni minimo';

  @override
  String get maxPlayCount => 'Numero riproduzioni massimo';

  @override
  String get minYear => 'Anno Minimo';

  @override
  String get maxYear => 'Anno Massimo';

  @override
  String selectArtistsExclude(int num) {
    return 'Seleziona artisti da escludere: $num selezionati.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Seleziona artisti da includere: $num selezionati.';
  }

  @override
  String get includeAllArtists =>
      'Includi tutti gli artisti se nessuno è selezionato.';

  @override
  String get excludeArtists => 'Escludi artisti selezionati';

  @override
  String get limitSongs => 'Limita numero di canzoni';

  @override
  String get orderSettings => 'Impostazioni Ordinamento';

  @override
  String get orderSettingsDescription =>
      'Riordina le opzioni per cambiare le priorità.';

  @override
  String get createSmartlist => 'Crea Smartlist';

  @override
  String get editSmartlist => 'Modifica Smartlist';

  @override
  String get play => 'Riproduci';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count canzoni selezionate',
      one: 'una canzone selezionata',
      zero: 'nessuna canzone selezionata',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Riproduci successiva';

  @override
  String get appendToQueued =>
      'Aggiungi alle canzoni messe in coda manualmente';

  @override
  String get addToQueue => 'Aggiungi alla coda';

  @override
  String get disc => 'Disco';

  @override
  String get blockFromLibrary => 'Rimuovi e blocca dalla libreria';

  @override
  String get highlights => 'In evidenza';

  @override
  String get shuffle => 'Casuale';

  @override
  String get selectArtists => 'Seleziona Artisti';

  @override
  String get removeFromQueue => 'Rimuovi dalla coda';

  @override
  String get currentlyPlaying => 'In riproduzione';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count canzoni',
      one: 'una canzone',
      zero: 'nessuna canzone',
    );
    return '$_temp0 in coda';
  }

  @override
  String moreAvailable(int num) {
    return 'altre $num disponibili';
  }

  @override
  String get nameMustNotBeEmpty => 'Il nome non può essere vuoto.';

  @override
  String get artistName => 'Nome artista';

  @override
  String get likeCount => 'Numero \"mi piace\"';

  @override
  String get playCount => 'Numero riproduzioni';

  @override
  String get songTitle => 'Titolo canzone';

  @override
  String get year => 'Anno';

  @override
  String get timeAdded => 'Data di aggiunta';

  @override
  String get addToPlaylist => 'Aggiungi a playlist';

  @override
  String get removeFromPlaylist => 'Rimuovi da playlist';

  @override
  String get cancel => 'Annulla';

  @override
  String get nextUp => 'Avanti';

  @override
  String get previousSong => 'precendente';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'riprodotta $count volte',
      one: 'riprodotta una volta',
      zero: 'non ancora riprodotta',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious =>
      'Riproduci sempre prima la canzone precedente';

  @override
  String get alwaysPlayNext => 'Riproduci sempre la canzone successiva dopo';

  @override
  String get dontExcludeSong => 'Non escludere questa canzone.';

  @override
  String get excludeShuffleAllSong =>
      'Escludi quando si mischiano tutte le canzoni.';

  @override
  String get excludeShuffleSong => 'Escludi quando in modalità casuale.';

  @override
  String get alwaysExcludeSong => 'Escludi sempre questa canzone.';

  @override
  String get welcomeToMucke => 'Benvenuti a mucke!';

  @override
  String get setupLibrary => 'Configura Libreria';

  @override
  String get setupLibraryDescription =>
      'Seleziona cartelle, estensioni file incluse, ecc.';

  @override
  String get importData => 'Importa dati';

  @override
  String get importDataDescription =>
      'Importa i tuoi dati da un\'installazione mucke precedente.';

  @override
  String get yourLibrary => 'La Tua Libreria:';

  @override
  String get scan => 'Scansiona';

  @override
  String get noFoldersSelected => 'Ancora nessuna cartella selezionata.';

  @override
  String get addFolder => 'Aggiungi cartella';

  @override
  String get availableFromImport => 'Disponibile da dati importati:';

  @override
  String get use => 'Usa';

  @override
  String get reset => 'Reset';

  @override
  String get blockedFilesDescription =>
      'File bloccati dai dati importati. Solo i riscontri esatti saranno esclusi dalla scansione della libreria. Altri file possono essere bloccati più tardi nell\'app.';

  @override
  String get importLibData => 'Importa Dati Libreria';

  @override
  String get songMetaData => 'Metadati Canzone';

  @override
  String metaDataAvailable(int num) {
    return 'Metadati per $num canzoni disponibili';
  }

  @override
  String get metaDataDescription => 'Importa \"mi piace\", blocchi ecc.';

  @override
  String get imported => 'Importato';

  @override
  String get importVerb => 'Importa';

  @override
  String get miscellaneous => 'Miscellanea';

  @override
  String get exportData => 'Esporta dati';

  @override
  String get exportDescription =>
      'Seleziona i dati che vuoi esportare. Di base, tutto è esportato. Quando esporti, puoi selezionare una cartella in cui il file è salvato.';

  @override
  String get songsAlbumsArtists => 'Canzoni, Album, e Artisti';

  @override
  String get librarySettings => 'Impostazioni Libreria';

  @override
  String dataExportedTo(String path) {
    return 'Dati esportati a:\n$path';
  }

  @override
  String get dataExportFailed => 'Esportazione dati fallita!';

  @override
  String get yourPlaylists => 'Le Tue Playlist';

  @override
  String get systemSettings => 'Impostazioni di Sistema';

  @override
  String get batteryExplanation =>
      'Da Android 12 in poi, l\'ottimizzazione batteria causa un errore con la notifica dopo aver perso il focus dell\'audio, per esempio quando si riceve una chiamata. Disabilitare l\'ottimizzazione per mucke risolve il problema.';

  @override
  String get openBattery => 'Apri impostazioni batteria';

  @override
  String get disableBattery =>
      'Disabilita l\'ottimizzazione per mucke per risolvere problemi di notifiche.';

  @override
  String get disabledBattery => 'L\'ottimizzazione batteria è disabilitata.';

  @override
  String get manageExternalExplanation =>
      'Garantire questo permesso può migliorare significativamente la velocità della libreria. Non cambia il comportamento dell\'app in altri modi.';

  @override
  String get grantManagePermission => 'Dai permesso di gestire tutti i file.';

  @override
  String get managePermissionSubtitle =>
      'Revocare il permesso risulterà in un riavvio dell\'app.';

  @override
  String get favorites => 'Preferiti';

  @override
  String get favoritesDesc => 'Contiene tutte le canzoni che ti piacciono.';

  @override
  String get newlyAdded => 'Aggiunte di recente';

  @override
  String get newlyAddedDesc =>
      'Contiene le 100 canzoni che sono state aggiunte per ultime.';

  @override
  String get back => 'Indietro';

  @override
  String get next => 'Prossima';

  @override
  String get finish => 'Fine';

  @override
  String get errorReadData => 'Errore nella lettura del file di dati.';

  @override
  String get createSmartlists => 'Crea Smartilist';

  @override
  String get createSmartlistsDesc =>
      'Crea smartlist consigliate per migliorare la tua esperienza di ascolto. Puoi personalizzare queste liste più tardi.';

  @override
  String get create => 'Crea';

  @override
  String get created => 'Creato';
}
