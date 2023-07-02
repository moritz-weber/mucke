class AppData {
  AppData({
    required this.appVersion,
    required this.buildNumber,
    required this.dbVersion,
    this.allowedExtensions,
    this.blockedFiles,
    this.generalSettings,
    this.libraryFolders,
    this.playlists,
    this.smartlists,
    this.songs,
    this.albums,
    this.artists,
  });

  final String appVersion;
  final int buildNumber;
  final int dbVersion;

  final String? allowedExtensions;
  final List<String>? blockedFiles;
  final Map<String, dynamic>? generalSettings;
  final List<String>? libraryFolders;
  final List<Map<String, dynamic>>? playlists;
  final List<Map<String, dynamic>>? smartlists;
  final Map<String, Map>? songs;
  final Map<String, Map>? albums;
  final Map<String, Map>? artists;
}

class DataSelection {
  DataSelection({
    required bool songsAlbumsArtists,
    required bool smartlists,
    required bool playlists,
    required bool libraryFolders,
    required this.allowedExtensions,
    required this.blockedFiles,
    required this.homePageSettings,
    required this.generalSettings,
  }) {
    _libraryFolders = libraryFolders;
    _songsAlbumsArtists = songsAlbumsArtists;
    _smartlists = smartlists;
    _playlists = playlists;
  }

  factory DataSelection.all() => DataSelection(
        generalSettings: true,
        allowedExtensions: true,
        blockedFiles: true,
        homePageSettings: true,
        libraryFolders: true,
        playlists: true,
        smartlists: true,
        songsAlbumsArtists: true,
      );

  DataSelection copy() => DataSelection(
        songsAlbumsArtists: songsAlbumsArtists,
        smartlists: smartlists,
        playlists: playlists,
        libraryFolders: libraryFolders,
        allowedExtensions: allowedExtensions,
        blockedFiles: blockedFiles,
        homePageSettings: homePageSettings,
        generalSettings: generalSettings,
      );

  late bool _libraryFolders;
  bool get libraryFolders => _libraryFolders;
  set libraryFolders(bool value) {
    if (value != _libraryFolders) {
      _libraryFolders = value;
      // required by
      songsAlbumsArtists = songsAlbumsArtists && value;
      smartlists = smartlists && value;
      playlists = playlists && value;
    }
  }

  late bool _songsAlbumsArtists;
  bool get songsAlbumsArtists => _songsAlbumsArtists;
  set songsAlbumsArtists(bool value) {
    if (value != _songsAlbumsArtists) {
      _songsAlbumsArtists = value;
      // requires
      libraryFolders = libraryFolders || value;
      // required by
      smartlists = smartlists && value;
      playlists = playlists && value;
    }
  }

  late bool _smartlists;
  bool get smartlists => _smartlists;
  set smartlists(bool value) {
    if (value != _smartlists) {
      _smartlists = value;
      // requires
      songsAlbumsArtists = songsAlbumsArtists || value;
    }
  }

  late bool _playlists;
  bool get playlists => _playlists;
  set playlists(bool value) {
    if (value != _playlists) {
      _playlists = value;
      // requires
      songsAlbumsArtists = songsAlbumsArtists || value;
    }
  }

  final bool allowedExtensions;
  final bool blockedFiles;

  final bool homePageSettings;
  bool generalSettings;
}
