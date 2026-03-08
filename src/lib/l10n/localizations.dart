import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations_ca.dart';
import 'localizations_de.dart';
import 'localizations_en.dart';
import 'localizations_es.dart';
import 'localizations_fi.dart';
import 'localizations_fr.dart';
import 'localizations_it.dart';
import 'localizations_ms.dart';
import 'localizations_nb.dart';
import 'localizations_pt.dart';
import 'localizations_ru.dart';
import 'localizations_uk.dart';
import 'localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n? of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ca'),
    Locale('de'),
    Locale('es'),
    Locale('fi'),
    Locale('fr'),
    Locale('it'),
    Locale('ms'),
    Locale('nb'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ru'),
    Locale('uk'),
    Locale('zh')
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @customizeHomePage.
  ///
  /// In en, this message translates to:
  /// **'Customize Home Page'**
  String get customizeHomePage;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @noSongsYet.
  ///
  /// In en, this message translates to:
  /// **'Looks like you don\'t have any songs in your library: Go to settings, add your music folders, and update your library.'**
  String get noSongsYet;

  /// No description provided for @library.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get library;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @updateLibrary.
  ///
  /// In en, this message translates to:
  /// **'Update library'**
  String get updateLibrary;

  /// No description provided for @artistsAlbumsSongs.
  ///
  /// In en, this message translates to:
  /// **'{artistCount} artists, {albumCount} albums, {songCount} songs'**
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount);

  /// No description provided for @manageLibraryFolders.
  ///
  /// In en, this message translates to:
  /// **'Manage library folders'**
  String get manageLibraryFolders;

  /// No description provided for @allowedFileExtensions.
  ///
  /// In en, this message translates to:
  /// **'Allowed file extensions'**
  String get allowedFileExtensions;

  /// No description provided for @allowedFileExtensionsDescription.
  ///
  /// In en, this message translates to:
  /// **'A comma-separated list of allowed file extensions. Lower- or uppercase does not matter. If you are unsure about this, just use the default.'**
  String get allowedFileExtensionsDescription;

  /// No description provided for @manageBlockedFiles.
  ///
  /// In en, this message translates to:
  /// **'Manage blocked files'**
  String get manageBlockedFiles;

  /// No description provided for @numberOfBlockedFiles.
  ///
  /// In en, this message translates to:
  /// **'Number of currently blocked files: {blockedFiles}'**
  String numberOfBlockedFiles(int blockedFiles);

  /// No description provided for @playback.
  ///
  /// In en, this message translates to:
  /// **'Playback'**
  String get playback;

  /// No description provided for @playAlbumsInOrder.
  ///
  /// In en, this message translates to:
  /// **'Play albums in order'**
  String get playAlbumsInOrder;

  /// No description provided for @playAlbumsInOrderDescription.
  ///
  /// In en, this message translates to:
  /// **'When you click a song in an album the songs will be played in order instead of keeping the previous play mode.'**
  String get playAlbumsInOrderDescription;

  /// No description provided for @countSongsPlayed.
  ///
  /// In en, this message translates to:
  /// **'Count songs as played after: {percentage}%'**
  String countSongsPlayed(int percentage);

  /// No description provided for @libraryFolders.
  ///
  /// In en, this message translates to:
  /// **'Library Folders'**
  String get libraryFolders;

  /// No description provided for @blockedFiles.
  ///
  /// In en, this message translates to:
  /// **'Blocked Files'**
  String get blockedFiles;

  /// No description provided for @homeCustomization.
  ///
  /// In en, this message translates to:
  /// **'Home Customization'**
  String get homeCustomization;

  /// No description provided for @albumOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Album of the Day'**
  String get albumOfTheDay;

  /// No description provided for @artistOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Artist of the Day'**
  String get artistOfTheDay;

  /// No description provided for @shuffleAll.
  ///
  /// In en, this message translates to:
  /// **'Shuffle All'**
  String get shuffleAll;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @addWidgetToHome.
  ///
  /// In en, this message translates to:
  /// **'Add a Widget to Your Home Page'**
  String get addWidgetToHome;

  /// No description provided for @noPlaylistsYet.
  ///
  /// In en, this message translates to:
  /// **'No playlists yet. You can add them in the library.'**
  String get noPlaylistsYet;

  /// No description provided for @lastPlayed.
  ///
  /// In en, this message translates to:
  /// **'Last played'**
  String get lastPlayed;

  /// No description provided for @noHistoryYet.
  ///
  /// In en, this message translates to:
  /// **'Nothing to see here yet. Play something.'**
  String get noHistoryYet;

  /// No description provided for @allSongs.
  ///
  /// In en, this message translates to:
  /// **'All Songs'**
  String get allSongs;

  /// No description provided for @song.
  ///
  /// In en, this message translates to:
  /// **'Song'**
  String get song;

  /// No description provided for @songs.
  ///
  /// In en, this message translates to:
  /// **'Songs'**
  String get songs;

  /// No description provided for @nSongs.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{no songs} =1{one song} other{{count} songs}}'**
  String nSongs(num count);

  /// No description provided for @album.
  ///
  /// In en, this message translates to:
  /// **'Album'**
  String get album;

  /// No description provided for @albums.
  ///
  /// In en, this message translates to:
  /// **'Albums'**
  String get albums;

  /// No description provided for @artist.
  ///
  /// In en, this message translates to:
  /// **'Artist'**
  String get artist;

  /// No description provided for @artists.
  ///
  /// In en, this message translates to:
  /// **'Artists'**
  String get artists;

  /// No description provided for @playlist.
  ///
  /// In en, this message translates to:
  /// **'Playlist'**
  String get playlist;

  /// No description provided for @playlists.
  ///
  /// In en, this message translates to:
  /// **'Playlists'**
  String get playlists;

  /// No description provided for @smartlist.
  ///
  /// In en, this message translates to:
  /// **'Smartlist'**
  String get smartlist;

  /// No description provided for @smartlists.
  ///
  /// In en, this message translates to:
  /// **'Smartlists'**
  String get smartlists;

  /// No description provided for @noShuffle.
  ///
  /// In en, this message translates to:
  /// **'None (keep the current shuffle mode)'**
  String get noShuffle;

  /// No description provided for @normalMode.
  ///
  /// In en, this message translates to:
  /// **'Normal Mode'**
  String get normalMode;

  /// No description provided for @shuffleMode.
  ///
  /// In en, this message translates to:
  /// **'Shuffle Mode'**
  String get shuffleMode;

  /// No description provided for @favShuffleMode.
  ///
  /// In en, this message translates to:
  /// **'Favorite Shuffle Mode'**
  String get favShuffleMode;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @sortingFilterSettings.
  ///
  /// In en, this message translates to:
  /// **'Sorting and Filter Settings'**
  String get sortingFilterSettings;

  /// No description provided for @maxNumberEntries.
  ///
  /// In en, this message translates to:
  /// **'Maximum number of entries'**
  String get maxNumberEntries;

  /// No description provided for @creationDate.
  ///
  /// In en, this message translates to:
  /// **'Creation Date'**
  String get creationDate;

  /// No description provided for @changeDate.
  ///
  /// In en, this message translates to:
  /// **'Change Date'**
  String get changeDate;

  /// No description provided for @lastTimePlayed.
  ///
  /// In en, this message translates to:
  /// **'Last Time Played'**
  String get lastTimePlayed;

  /// No description provided for @ascending.
  ///
  /// In en, this message translates to:
  /// **'Ascending'**
  String get ascending;

  /// No description provided for @descending.
  ///
  /// In en, this message translates to:
  /// **'Descending'**
  String get descending;

  /// No description provided for @both.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get both;

  /// No description provided for @playlistsOnly.
  ///
  /// In en, this message translates to:
  /// **'Playlists Only'**
  String get playlistsOnly;

  /// No description provided for @smartlistsOnly.
  ///
  /// In en, this message translates to:
  /// **'Smartlists Only'**
  String get smartlistsOnly;

  /// No description provided for @displaySettings.
  ///
  /// In en, this message translates to:
  /// **'Display Settings'**
  String get displaySettings;

  /// No description provided for @addSmartlist.
  ///
  /// In en, this message translates to:
  /// **'Add Smartlist'**
  String get addSmartlist;

  /// No description provided for @addPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Add Playlist'**
  String get addPlaylist;

  /// No description provided for @createPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Create Playlist'**
  String get createPlaylist;

  /// No description provided for @editPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Edit Playlist'**
  String get editPlaylist;

  /// No description provided for @customizeCover.
  ///
  /// In en, this message translates to:
  /// **'Customize Cover'**
  String get customizeCover;

  /// No description provided for @playbackMode.
  ///
  /// In en, this message translates to:
  /// **'Playback Mode'**
  String get playbackMode;

  /// No description provided for @excludeAllSongs.
  ///
  /// In en, this message translates to:
  /// **'Exclude all songs marked for exclusion.'**
  String get excludeAllSongs;

  /// No description provided for @excludeInShuffle.
  ///
  /// In en, this message translates to:
  /// **'Exclude songs marked for exclusion in shuffle mode.'**
  String get excludeInShuffle;

  /// No description provided for @excludeAlways.
  ///
  /// In en, this message translates to:
  /// **'Exclude only songs marked as always exclude.'**
  String get excludeAlways;

  /// No description provided for @dontExclude.
  ///
  /// In en, this message translates to:
  /// **'Don\'t exclude any songs.'**
  String get dontExclude;

  /// No description provided for @filterSettings.
  ///
  /// In en, this message translates to:
  /// **'Filter Settings'**
  String get filterSettings;

  /// No description provided for @filterLikes.
  ///
  /// In en, this message translates to:
  /// **'Likes between {min} and {max}'**
  String filterLikes(int min, int max);

  /// No description provided for @minPlayCount.
  ///
  /// In en, this message translates to:
  /// **'Minimum play count'**
  String get minPlayCount;

  /// No description provided for @maxPlayCount.
  ///
  /// In en, this message translates to:
  /// **'Maximum play count'**
  String get maxPlayCount;

  /// No description provided for @minYear.
  ///
  /// In en, this message translates to:
  /// **'Minimum Year'**
  String get minYear;

  /// No description provided for @maxYear.
  ///
  /// In en, this message translates to:
  /// **'Maximum Year'**
  String get maxYear;

  /// No description provided for @selectArtistsExclude.
  ///
  /// In en, this message translates to:
  /// **'Select artists to exclude: {num} selected.'**
  String selectArtistsExclude(int num);

  /// No description provided for @selectArtistsInclude.
  ///
  /// In en, this message translates to:
  /// **'Select artists to include: {num} selected.'**
  String selectArtistsInclude(int num);

  /// No description provided for @includeAllArtists.
  ///
  /// In en, this message translates to:
  /// **'Include all artists if none are selected.'**
  String get includeAllArtists;

  /// No description provided for @excludeArtists.
  ///
  /// In en, this message translates to:
  /// **'Exclude selected artists'**
  String get excludeArtists;

  /// No description provided for @limitSongs.
  ///
  /// In en, this message translates to:
  /// **'Limit number of songs'**
  String get limitSongs;

  /// No description provided for @orderSettings.
  ///
  /// In en, this message translates to:
  /// **'Order Settings'**
  String get orderSettings;

  /// No description provided for @orderSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Reorder options to change priorities.'**
  String get orderSettingsDescription;

  /// No description provided for @createSmartlist.
  ///
  /// In en, this message translates to:
  /// **'Create Smartlist'**
  String get createSmartlist;

  /// No description provided for @editSmartlist.
  ///
  /// In en, this message translates to:
  /// **'Edit Smartlist'**
  String get editSmartlist;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @nSongsSelected.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{no songs selected} =1{one song selected} other{{count} songs selected}}'**
  String nSongsSelected(num count);

  /// No description provided for @playNext.
  ///
  /// In en, this message translates to:
  /// **'Play next'**
  String get playNext;

  /// No description provided for @appendToQueued.
  ///
  /// In en, this message translates to:
  /// **'Append to manually queued songs'**
  String get appendToQueued;

  /// No description provided for @addToQueue.
  ///
  /// In en, this message translates to:
  /// **'Add to queue'**
  String get addToQueue;

  /// No description provided for @disc.
  ///
  /// In en, this message translates to:
  /// **'Disc'**
  String get disc;

  /// No description provided for @blockFromLibrary.
  ///
  /// In en, this message translates to:
  /// **'Remove and block from library'**
  String get blockFromLibrary;

  /// No description provided for @highlights.
  ///
  /// In en, this message translates to:
  /// **'Highlights'**
  String get highlights;

  /// No description provided for @shuffle.
  ///
  /// In en, this message translates to:
  /// **'Shuffle'**
  String get shuffle;

  /// No description provided for @selectArtists.
  ///
  /// In en, this message translates to:
  /// **'Select Artists'**
  String get selectArtists;

  /// No description provided for @removeFromQueue.
  ///
  /// In en, this message translates to:
  /// **'Remove from queue'**
  String get removeFromQueue;

  /// No description provided for @currentlyPlaying.
  ///
  /// In en, this message translates to:
  /// **'Currently playing'**
  String get currentlyPlaying;

  /// No description provided for @nSongsInQueue.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{no songs} =1{one song} other{{count} songs}} in queue'**
  String nSongsInQueue(num count);

  /// No description provided for @moreAvailable.
  ///
  /// In en, this message translates to:
  /// **'{num} more available'**
  String moreAvailable(int num);

  /// No description provided for @nameMustNotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'The name must not be empty.'**
  String get nameMustNotBeEmpty;

  /// No description provided for @artistName.
  ///
  /// In en, this message translates to:
  /// **'Artist name'**
  String get artistName;

  /// No description provided for @likeCount.
  ///
  /// In en, this message translates to:
  /// **'Like count'**
  String get likeCount;

  /// No description provided for @playCount.
  ///
  /// In en, this message translates to:
  /// **'Play count'**
  String get playCount;

  /// No description provided for @songTitle.
  ///
  /// In en, this message translates to:
  /// **'Song title'**
  String get songTitle;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @timeAdded.
  ///
  /// In en, this message translates to:
  /// **'Time added'**
  String get timeAdded;

  /// No description provided for @addToPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Add to playlist'**
  String get addToPlaylist;

  /// No description provided for @removeFromPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Remove from playlist'**
  String get removeFromPlaylist;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @nextUp.
  ///
  /// In en, this message translates to:
  /// **'Next up'**
  String get nextUp;

  /// No description provided for @previousSong.
  ///
  /// In en, this message translates to:
  /// **'previous'**
  String get previousSong;

  /// No description provided for @playedNTimes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{not played yet} =1{played once} other{played {count} times}}'**
  String playedNTimes(num count);

  /// No description provided for @alwaysPlayPrevious.
  ///
  /// In en, this message translates to:
  /// **'Always play previous song before'**
  String get alwaysPlayPrevious;

  /// No description provided for @alwaysPlayNext.
  ///
  /// In en, this message translates to:
  /// **'Always play next song after'**
  String get alwaysPlayNext;

  /// No description provided for @dontExcludeSong.
  ///
  /// In en, this message translates to:
  /// **'Don\'t exclude this song.'**
  String get dontExcludeSong;

  /// No description provided for @excludeShuffleAllSong.
  ///
  /// In en, this message translates to:
  /// **'Exclude when shuffling all songs.'**
  String get excludeShuffleAllSong;

  /// No description provided for @excludeShuffleSong.
  ///
  /// In en, this message translates to:
  /// **'Exclude when shuffling.'**
  String get excludeShuffleSong;

  /// No description provided for @alwaysExcludeSong.
  ///
  /// In en, this message translates to:
  /// **'Always exclude this song.'**
  String get alwaysExcludeSong;

  /// No description provided for @welcomeToMucke.
  ///
  /// In en, this message translates to:
  /// **'Welcome to mucke!'**
  String get welcomeToMucke;

  /// No description provided for @setupLibrary.
  ///
  /// In en, this message translates to:
  /// **'Set up Library'**
  String get setupLibrary;

  /// No description provided for @setupLibraryDescription.
  ///
  /// In en, this message translates to:
  /// **'Select folders, included file extensions, etc.'**
  String get setupLibraryDescription;

  /// No description provided for @importData.
  ///
  /// In en, this message translates to:
  /// **'Import data'**
  String get importData;

  /// No description provided for @importDataDescription.
  ///
  /// In en, this message translates to:
  /// **'Import your data from a previous mucke installation.'**
  String get importDataDescription;

  /// No description provided for @yourLibrary.
  ///
  /// In en, this message translates to:
  /// **'Your Library:'**
  String get yourLibrary;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @noFoldersSelected.
  ///
  /// In en, this message translates to:
  /// **'No folders selected so far.'**
  String get noFoldersSelected;

  /// No description provided for @addFolder.
  ///
  /// In en, this message translates to:
  /// **'Add folder'**
  String get addFolder;

  /// No description provided for @availableFromImport.
  ///
  /// In en, this message translates to:
  /// **'Available from imported data:'**
  String get availableFromImport;

  /// No description provided for @use.
  ///
  /// In en, this message translates to:
  /// **'Use'**
  String get use;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @blockedFilesDescription.
  ///
  /// In en, this message translates to:
  /// **'Blocked files from the imported data. Only exact matches will be excluded from the library scan. Additional files can be blocked later in the app.'**
  String get blockedFilesDescription;

  /// No description provided for @importLibData.
  ///
  /// In en, this message translates to:
  /// **'Import Library Data'**
  String get importLibData;

  /// No description provided for @songMetaData.
  ///
  /// In en, this message translates to:
  /// **'Song Metadata'**
  String get songMetaData;

  /// No description provided for @metaDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'Metadata for {num} songs available'**
  String metaDataAvailable(int num);

  /// No description provided for @metaDataDescription.
  ///
  /// In en, this message translates to:
  /// **'Import likes, blocks etc.'**
  String get metaDataDescription;

  /// No description provided for @imported.
  ///
  /// In en, this message translates to:
  /// **'Imported'**
  String get imported;

  /// This means the verb of importing something - not the noun.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importVerb;

  /// No description provided for @miscellaneous.
  ///
  /// In en, this message translates to:
  /// **'Miscellaneous'**
  String get miscellaneous;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export data'**
  String get exportData;

  /// No description provided for @exportDescription.
  ///
  /// In en, this message translates to:
  /// **'Select the data you want to export. By default, everything is exported. When exporting, you can select a folder for the file to be stored.'**
  String get exportDescription;

  /// No description provided for @songsAlbumsArtists.
  ///
  /// In en, this message translates to:
  /// **'Songs, Albums, and Artists'**
  String get songsAlbumsArtists;

  /// No description provided for @librarySettings.
  ///
  /// In en, this message translates to:
  /// **'Library Settings'**
  String get librarySettings;

  /// No description provided for @dataExportedTo.
  ///
  /// In en, this message translates to:
  /// **'Data exported to:\n{path}'**
  String dataExportedTo(String path);

  /// No description provided for @dataExportFailed.
  ///
  /// In en, this message translates to:
  /// **'Data export failed!'**
  String get dataExportFailed;

  /// No description provided for @yourPlaylists.
  ///
  /// In en, this message translates to:
  /// **'Your Playlists'**
  String get yourPlaylists;

  /// No description provided for @systemSettings.
  ///
  /// In en, this message translates to:
  /// **'System Settings'**
  String get systemSettings;

  /// No description provided for @batteryExplanation.
  ///
  /// In en, this message translates to:
  /// **'Starting with Android 12, the battery optimization causes an error with the notification after losing the audio focus, for example when receiving a call. Disabling the optimization for mucke solves this issue.'**
  String get batteryExplanation;

  /// No description provided for @openBattery.
  ///
  /// In en, this message translates to:
  /// **'Open battery settings'**
  String get openBattery;

  /// No description provided for @disableBattery.
  ///
  /// In en, this message translates to:
  /// **'Disable optimization for mucke to solve notification issues.'**
  String get disableBattery;

  /// No description provided for @disabledBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery optimization is disabled.'**
  String get disabledBattery;

  /// No description provided for @manageExternalExplanation.
  ///
  /// In en, this message translates to:
  /// **'Granting this permission can improve the speed of library scans significantly. It does not change the behavior of the app otherwise.'**
  String get manageExternalExplanation;

  /// No description provided for @grantManagePermission.
  ///
  /// In en, this message translates to:
  /// **'Grant permission to manage all files.'**
  String get grantManagePermission;

  /// No description provided for @managePermissionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Revoking the permission will result in a restart of the app.'**
  String get managePermissionSubtitle;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @favoritesDesc.
  ///
  /// In en, this message translates to:
  /// **'Contains all the songs that you like.'**
  String get favoritesDesc;

  /// No description provided for @newlyAdded.
  ///
  /// In en, this message translates to:
  /// **'Newly added'**
  String get newlyAdded;

  /// No description provided for @newlyAddedDesc.
  ///
  /// In en, this message translates to:
  /// **'Contains the 100 songs that were added last.'**
  String get newlyAddedDesc;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @errorReadData.
  ///
  /// In en, this message translates to:
  /// **'Error reading data file.'**
  String get errorReadData;

  /// No description provided for @createSmartlists.
  ///
  /// In en, this message translates to:
  /// **'Create Smartlists'**
  String get createSmartlists;

  /// No description provided for @createSmartlistsDesc.
  ///
  /// In en, this message translates to:
  /// **'Create suggested smartlists to enhance your listening experience. You can customize these lists later.'**
  String get createSmartlistsDesc;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ca',
        'de',
        'en',
        'es',
        'fi',
        'fr',
        'it',
        'ms',
        'nb',
        'pt',
        'ru',
        'uk',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return L10nPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ca':
      return L10nCa();
    case 'de':
      return L10nDe();
    case 'en':
      return L10nEn();
    case 'es':
      return L10nEs();
    case 'fi':
      return L10nFi();
    case 'fr':
      return L10nFr();
    case 'it':
      return L10nIt();
    case 'ms':
      return L10nMs();
    case 'nb':
      return L10nNb();
    case 'pt':
      return L10nPt();
    case 'ru':
      return L10nRu();
    case 'uk':
      return L10nUk();
    case 'zh':
      return L10nZh();
  }

  throw FlutterError(
      'L10n.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
