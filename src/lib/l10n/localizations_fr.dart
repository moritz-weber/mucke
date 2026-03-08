// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class L10nFr extends L10n {
  L10nFr([String locale = 'fr']) : super(locale);

  @override
  String get home => 'Accueil';

  @override
  String get customizeHomePage => 'Personnaliser la page d\'accueil';

  @override
  String get settings => 'Paramètres';

  @override
  String get noSongsYet =>
      'Il semble que vous n\'ayez aucune chanson dans votre bibliothèque : Allez dans les paramètres, ajoutez vos dossiers musicaux et mettez à jour votre bibliothèque.';

  @override
  String get library => 'Bibliothèque';

  @override
  String get search => 'Recherche';

  @override
  String get updateLibrary => 'Mettre à jour la bibliothèque';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount artistes, $albumCount albums, $songCount chansons';
  }

  @override
  String get manageLibraryFolders => 'Gérer les dossiers de la bibliothèque';

  @override
  String get allowedFileExtensions => 'Extensions de fichiers autorisées';

  @override
  String get allowedFileExtensionsDescription =>
      'Liste d\'extensions de fichier autorisées, séparées par des virgules. La casse (majuscules/minuscules) n\'a pas d\'importance. Si vous n\'êtes pas sûr, utilisez la valeur par défaut.';

  @override
  String get manageBlockedFiles => 'Gérer les fichiers bloqués';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Nombre de fichiers actuellement bloqués : $blockedFiles';
  }

  @override
  String get playback => 'Lecture';

  @override
  String get playAlbumsInOrder => 'Lire les albums dans l\'ordre';

  @override
  String get playAlbumsInOrderDescription =>
      'Lorsque vous cliquez sur une chanson dans un album, les chansons sont lues dans l\'ordre au lieu de conserver le mode de lecture précédent.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Considérer les chansons comme lues après : $percentage%';
  }

  @override
  String get libraryFolders => 'Dossiers de bibliothèque';

  @override
  String get blockedFiles => 'Fichiers bloqués';

  @override
  String get homeCustomization => 'Personnalisation de l\'accueil';

  @override
  String get albumOfTheDay => 'Album du jour';

  @override
  String get artistOfTheDay => 'Artiste du jour';

  @override
  String get shuffleAll => 'Lecture aléatoire';

  @override
  String get history => 'Historique';

  @override
  String get addWidgetToHome => 'Ajouter un widget à votre page d\'accueil';

  @override
  String get noPlaylistsYet =>
      'Aucune liste de lecture pour le moment. Vous pouvez en ajouter dans la bibliothèque.';

  @override
  String get lastPlayed => 'Dernière lecture';

  @override
  String get noHistoryYet =>
      'Il n\'y a rien à voir ici. Écoutez quelque chose.';

  @override
  String get allSongs => 'Toutes les chansons';

  @override
  String get song => 'Chanson';

  @override
  String get songs => 'Chansons';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count chansons',
      one: 'une chanson',
      zero: 'aucune chanson',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Album';

  @override
  String get albums => 'Albums';

  @override
  String get artist => 'Artiste';

  @override
  String get artists => 'Artistes';

  @override
  String get playlist => 'Liste de lecture';

  @override
  String get playlists => 'Listes de lecture';

  @override
  String get smartlist => 'Liste intelligente';

  @override
  String get smartlists => 'Listes intelligentes';

  @override
  String get noShuffle => 'Aucun (conserver le mode aléatoire actuel)';

  @override
  String get normalMode => 'Mode normal';

  @override
  String get shuffleMode => 'Mode aléatoire';

  @override
  String get favShuffleMode => 'Mode aléatoire favori';

  @override
  String get name => 'Nom';

  @override
  String get sortingFilterSettings => 'Paramètres de tri et de filtrage';

  @override
  String get maxNumberEntries => 'Nombre maximum d\'entrées';

  @override
  String get creationDate => 'Date de création';

  @override
  String get changeDate => 'Date de modification';

  @override
  String get lastTimePlayed => 'Date de dernière lecture';

  @override
  String get ascending => 'Croissant';

  @override
  String get descending => 'Décroissant';

  @override
  String get both => 'Les deux';

  @override
  String get playlistsOnly => 'Listes de lecture uniquement';

  @override
  String get smartlistsOnly => 'Listes intelligentes uniquement';

  @override
  String get displaySettings => 'Paramètres d\'affichage';

  @override
  String get addSmartlist => 'Ajouter une liste intelligente';

  @override
  String get addPlaylist => 'Ajouter une liste de lecture';

  @override
  String get createPlaylist => 'Créer une liste de lecture';

  @override
  String get editPlaylist => 'Modifier la liste de lecture';

  @override
  String get customizeCover => 'Personnaliser la pochette';

  @override
  String get playbackMode => 'Mode de lecture';

  @override
  String get excludeAllSongs =>
      'Exclure toutes les chansons marquées pour exclusion.';

  @override
  String get excludeInShuffle =>
      'Exclure les chansons marquées pour exclusion en mode aléatoire.';

  @override
  String get excludeAlways =>
      'Exclure uniquement les chansons marquées comme toujours exclues.';

  @override
  String get dontExclude => 'N\'exclure aucune chanson.';

  @override
  String get filterSettings => 'Paramètres de filtrage';

  @override
  String filterLikes(int min, int max) {
    return '\"J\'aime\" entre $min et $max';
  }

  @override
  String get minPlayCount => 'Nombre minimum de lecture';

  @override
  String get maxPlayCount => 'Nombre maximum de lecture';

  @override
  String get minYear => 'Année minimum';

  @override
  String get maxYear => 'Année maximum';

  @override
  String selectArtistsExclude(int num) {
    return 'Sélectionnez les artistes à exclure : $num sélectionnés.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Sélectionnez les artistes à inclure : $num sélectionnés.';
  }

  @override
  String get includeAllArtists =>
      'Inclure tous les artistes si aucun n\'est sélectionné.';

  @override
  String get excludeArtists => 'Exclure les artistes sélectionnés';

  @override
  String get limitSongs => 'Limitez le nombre de chansons';

  @override
  String get orderSettings => 'Paramètres d\'ordre';

  @override
  String get orderSettingsDescription =>
      'Réorganisez les options pour changer les priorités.';

  @override
  String get createSmartlist => 'Créer une liste intelligente';

  @override
  String get editSmartlist => 'Modifier la liste intelligente';

  @override
  String get play => 'Lire';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count chansons sélectionnées',
      one: 'Une chanson sélectionnée',
      zero: 'Aucune chanson sélectionnée',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Lire ensuite';

  @override
  String get appendToQueued =>
      'Ajouter aux chansons en file d\'attente manuelle';

  @override
  String get addToQueue => 'Ajouter à la file d\'attente';

  @override
  String get disc => 'Disque';

  @override
  String get blockFromLibrary => 'Retirer et bloquer de la bibliothèque';

  @override
  String get highlights => 'En vedette';

  @override
  String get shuffle => 'Aléatoire';

  @override
  String get selectArtists => 'Sélectionner des artistes';

  @override
  String get removeFromQueue => 'Retirer de la file d\'attente';

  @override
  String get currentlyPlaying => 'En cours de lecture';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count chansons',
      one: 'une chanson',
      zero: 'aucune chanson',
    );
    return '$_temp0 en file d\'attente';
  }

  @override
  String moreAvailable(int num) {
    return '$num de plus disponibles';
  }

  @override
  String get nameMustNotBeEmpty => 'Le nom ne doit pas être vide.';

  @override
  String get artistName => 'Nom de l\'artiste';

  @override
  String get likeCount => 'Nombre de \"J\'aime\"';

  @override
  String get playCount => 'Nombre de lectures';

  @override
  String get songTitle => 'Titre de la chanson';

  @override
  String get year => 'Année';

  @override
  String get timeAdded => 'Date d\'ajout';

  @override
  String get addToPlaylist => 'Ajouter à la liste de lecture';

  @override
  String get removeFromPlaylist => 'Retirer de la liste de lecture';

  @override
  String get cancel => 'Annuler';

  @override
  String get nextUp => 'À suivre';

  @override
  String get previousSong => 'précédent';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'jouée $count fois',
      one: 'jouée une fois',
      zero: 'pas encore jouée',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => 'Toujours jouer la chanson précédente avant';

  @override
  String get alwaysPlayNext => 'Toujours jouer la chanson suivante après';

  @override
  String get dontExcludeSong => 'Ne pas exclure cette chanson.';

  @override
  String get excludeShuffleAllSong =>
      'Exclure lors de la lecture aléatoire de toutes les chansons.';

  @override
  String get excludeShuffleSong => 'Exclure lors de la lecture aléatoire.';

  @override
  String get alwaysExcludeSong => 'Toujours exclure cette chanson.';

  @override
  String get welcomeToMucke => 'Bienvenue sur mucke !';

  @override
  String get setupLibrary => 'Configurer la bibliothèque';

  @override
  String get setupLibraryDescription =>
      'Sélectionner des dossiers, les extensions de fichiers incluses, etc.';

  @override
  String get importData => 'Importer des données';

  @override
  String get importDataDescription =>
      'Importer les données d\'une précédente installation de mucke.';

  @override
  String get yourLibrary => 'Votre bibliothèque :';

  @override
  String get scan => 'Scanner';

  @override
  String get noFoldersSelected => 'Aucun dossier sélectionné pour le moment.';

  @override
  String get addFolder => 'Ajouter un dossier';

  @override
  String get availableFromImport =>
      'Disponible à partir des données importées :';

  @override
  String get use => 'Utiliser';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get blockedFilesDescription =>
      'Fichiers bloqués à partir des données importées. Seules les correspondances exactes seront exclues du scan de la bibliothèque. Des fichiers supplémentaires peuvent être bloqués ultérieurement dans l\'application.';

  @override
  String get importLibData => 'Importer les données de la bibliothèque';

  @override
  String get songMetaData => 'Métadonnées de la chanson';

  @override
  String metaDataAvailable(int num) {
    return 'Métadonnées disponibles pour $num chansons';
  }

  @override
  String get metaDataDescription =>
      'Importer les \"J\'aime\", les blocages, etc.';

  @override
  String get imported => 'Importé';

  @override
  String get importVerb => 'Importer';

  @override
  String get miscellaneous => 'Divers';

  @override
  String get exportData => 'Exporter les données';

  @override
  String get exportDescription =>
      'Sélectionnez les données que vous souhaitez exporter. Par défaut, tout est exporté. Lors de l\'exportation, vous pouvez choisir le dossier où stocker le fichier.';

  @override
  String get songsAlbumsArtists => 'Chansons, Albums et Artistes';

  @override
  String get librarySettings => 'Paramètres de la bibliothèque';

  @override
  String dataExportedTo(String path) {
    return 'Données exportées vers :\n$path';
  }

  @override
  String get dataExportFailed => 'Échec de l\'exportation des données !';

  @override
  String get yourPlaylists => 'Vos listes de lecture';

  @override
  String get systemSettings => 'Paramètres système';

  @override
  String get batteryExplanation =>
      'À partir d\'Android 12, l\'optimisation de la batterie provoque une erreur avec la notification après avoir perdu le focus audio, par exemple lors de la réception d\'un appel. Désactiver l\'optimisation pour mucke résout ce problème.';

  @override
  String get openBattery => 'Ouvrir les paramètres de la batterie';

  @override
  String get disableBattery =>
      'Désactivez l\'optimisation pour mucke afin de résoudre les problèmes de notification.';

  @override
  String get disabledBattery =>
      'L\'optimisation de la batterie est désactivée.';

  @override
  String get manageExternalExplanation =>
      'Accorder cette permission peut améliorer considérablement la vitesse des analyses de la bibliothèque. Cela ne modifie pas le comportement de l\'application autrement.';

  @override
  String get grantManagePermission =>
      'Accorder la permission pour gérer tous les fichiers.';

  @override
  String get managePermissionSubtitle =>
      'La révocation de la permission entraînera le redémarrage de l\'application.';

  @override
  String get favorites => 'Favoris';

  @override
  String get favoritesDesc => 'Contient toutes les chansons que vous aimez.';

  @override
  String get newlyAdded => 'Nouvellement ajoutées';

  @override
  String get newlyAddedDesc => 'Contient les 100 chansons ajoutées en dernier.';

  @override
  String get back => 'Retour';

  @override
  String get next => 'Suivant';

  @override
  String get finish => 'Terminer';

  @override
  String get errorReadData => 'Erreur de lecture du fichier de données.';

  @override
  String get createSmartlists => 'Créer des listes intelligentes';

  @override
  String get createSmartlistsDesc =>
      'Créez les listes intelligentes suggérées pour améliorer votre expérience d\'écoute. Vous pouvez personnaliser ces listes ultérieurement.';

  @override
  String get create => 'Créez';

  @override
  String get created => 'Créé';
}
