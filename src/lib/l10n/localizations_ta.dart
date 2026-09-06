// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class L10nTa extends L10n {
  L10nTa([String locale = 'ta']) : super(locale);

  @override
  String get home => 'வீடு';

  @override
  String get customizeHomePage => 'முகப்பு பக்கத்தைத் தனிப்பயனாக்குங்கள்';

  @override
  String get settings => 'அமைப்புகள்';

  @override
  String get noSongsYet =>
      'உங்கள் நூலகத்தில் உங்களிடம் எந்த பாடல்களும் இல்லை என்று தெரிகிறது: அமைப்புகளுக்குச் சென்று, உங்கள் இசை கோப்புறைகளைச் சேர்த்து, உங்கள் நூலகத்தைப் புதுப்பிக்கவும்.';

  @override
  String get library => 'நூலகம்';

  @override
  String get search => 'தேடல்';

  @override
  String get updateLibrary => 'நூலகத்தைப் புதுப்பிக்கவும்';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount கலைஞர்கள், $albumCount ஆல்பங்கள், $songCount பாடல்கள்';
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
  String get manageLibraryFolders => 'நூலக கோப்புறைகளை நிர்வகிக்கவும்';

  @override
  String get allowedFileExtensions => 'அனுமதிக்கப்பட்ட கோப்பு நீட்டிப்புகள்';

  @override
  String get allowedFileExtensionsDescription =>
      'அனுமதிக்கப்பட்ட கோப்பு நீட்டிப்புகளின் கமாவால் பிரிக்கப்பட்ட பட்டியல். கீழ்- அல்லது பெரிய எழுத்துக்கள் ஒரு பொருட்டல்ல. இதைப் பற்றி உங்களுக்குத் தெரியாவிட்டால், இயல்புநிலையைப் பயன்படுத்தவும்.';

  @override
  String get manageBlockedFiles => 'தடுக்கப்பட்ட கோப்புகளை நிர்வகிக்கவும்';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'தற்போது தடுக்கப்பட்ட கோப்புகளின் எண்ணிக்கை: $blockedFiles';
  }

  @override
  String get playback => 'பின்னணி';

  @override
  String get playAlbumsInOrder => 'வரிசையில் ஆல்பங்களை இயக்கவும்';

  @override
  String get playAlbumsInOrderDescription =>
      'ஒரு ஆல்பத்தில் ஒரு பாடலைக் சொடுக்கு செய்யும் போது, முந்தைய நாடக பயன்முறையை வைத்திருப்பதற்கு பதிலாக பாடல்கள் ஒழுங்காக இயக்கப்படும்.';

  @override
  String countSongsPlayed(int percentage) {
    return 'பின்னர் பாடல்களை எண்ணுங்கள்: $percentage%';
  }

  @override
  String get libraryFolders => 'நூலக கோப்புறைகள்';

  @override
  String get blockedFiles => 'தடுக்கப்பட்ட கோப்புகள்';

  @override
  String get homeCustomization => 'முகப்பு தனிப்பயனாக்கம்';

  @override
  String get albumOfTheDay => 'அன்றைய ஆல்பம்';

  @override
  String get artistOfTheDay => 'அன்றைய கலைஞர்';

  @override
  String get shuffleAll => 'அனைத்தையும் மாற்றவும்';

  @override
  String get history => 'வரலாறு';

  @override
  String get addWidgetToHome =>
      'உங்கள் முகப்பு பக்கத்தில் ஒரு விட்செட்டைச் சேர்க்கவும்';

  @override
  String get noPlaylistsYet =>
      'பிளேலிச்ட்கள் இதுவரை இல்லை. நீங்கள் அவற்றை நூலகத்தில் சேர்க்கலாம்.';

  @override
  String get lastPlayed => 'கடைசியாக விளையாடியது';

  @override
  String get noHistoryYet =>
      'இதுவரை இங்கு பார்க்க எதுவும் இல்லை. ஏதாவது விளையாடுங்கள்.';

  @override
  String get allSongs => 'அனைத்து பாடல்களும்';

  @override
  String get song => 'பாடல்';

  @override
  String get songs => 'பாடல்கள்';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count பாடல்கள்',
      one: 'ஒரு பாடல்',
      zero: 'பாடல்கள் இல்லை',
    );
    return '$_temp0';
  }

  @override
  String get album => 'தொகுப்பு';

  @override
  String get albums => 'தொகுப்புகள்';

  @override
  String get artist => 'கலைஞர்';

  @override
  String get artists => 'கலைஞர்கள்';

  @override
  String get playlist => 'பிளேலிச்ட்';

  @override
  String get playlists => 'பிளேலிச்ட்கள்';

  @override
  String get smartlist => 'அறிவுள்ள பட்டியல்';

  @override
  String get smartlists => 'அறிவுள்ள பட்டியல்கள்';

  @override
  String get noShuffle =>
      'எதுவுமில்லை (தற்போதைய கலக்கு பயன்முறையை வைத்திருங்கள்)';

  @override
  String get normalMode => 'சாதாரண பயன்முறை';

  @override
  String get shuffleMode => 'கலக்கு பயன்முறை';

  @override
  String get favShuffleMode => 'பிடித்த கலக்கு முறை';

  @override
  String get playlistNormalMode => 'Play from the top';

  @override
  String get playlistShuffleMode => 'Start shuffle playback';

  @override
  String get playlistFavShuffleMode => 'Start favorite shuffle playback';

  @override
  String get name => 'பெயர்';

  @override
  String get sortingFilterSettings =>
      'அமைப்புகளை வரிசைப்படுத்துதல் மற்றும் வடிகட்டி';

  @override
  String get maxNumberEntries => 'உள்ளீடுகளின் அதிகபட்ச எண்ணிக்கை';

  @override
  String get creationDate => 'உருவாக்கும் தேதி';

  @override
  String get changeDate => 'தேதியை மாற்றவும்';

  @override
  String get lastTimePlayed => 'கடைசியாக விளையாடியது';

  @override
  String get ascending => 'ஏறுதல்';

  @override
  String get descending => 'இறங்கு';

  @override
  String get both => 'இரண்டும்';

  @override
  String get playlistsOnly => 'பிளேலிச்ட்கள் மட்டுமே';

  @override
  String get smartlistsOnly => 'அறிவுள்ள பட்டியல்கள் மட்டுமே';

  @override
  String get displaySettings => 'அமைப்புகளைக் காண்பி';

  @override
  String get addSmartlist => 'ச்மார்ட்லிச்ட்டைச் சேர்க்கவும்';

  @override
  String get addPlaylist => 'பிளேலிச்ட்டைச் சேர்க்கவும்';

  @override
  String get createPlaylist => 'பிளேலிச்ட்டை உருவாக்கவும்';

  @override
  String get editPlaylist => 'பிளேலிச்ட்டைத் திருத்து';

  @override
  String get customizeCover => 'கவர் தனிப்பயனாக்கு';

  @override
  String get playbackMode => 'பிளேபேக் பயன்முறை';

  @override
  String get excludeAllSongs =>
      'விலக்குவதற்கு குறிக்கப்பட்ட அனைத்து பாடல்களையும் விலக்கு.';

  @override
  String get excludeInShuffle =>
      'சஃபிள் பயன்முறையில் விலக்குவதற்கு குறிக்கப்பட்ட பாடல்களை விலக்கு.';

  @override
  String get excludeAlways =>
      'எப்போதும் விலக்கு என குறிக்கப்பட்ட பாடல்களை மட்டுமே விலக்குங்கள்.';

  @override
  String get dontExclude => 'எந்த பாடல்களையும் விலக்க வேண்டாம்.';

  @override
  String get filterSettings => 'அமைப்புகளை வடிகட்டவும்';

  @override
  String filterLikes(int min, int max) {
    return '$min மற்றும் $max க்கு இடையில் விருப்பங்கள்';
  }

  @override
  String get minPlayCount => 'குறைந்தபட்ச விளையாட்டு எண்ணிக்கை';

  @override
  String get maxPlayCount => 'அதிகபட்ச விளையாட்டு எண்ணிக்கை';

  @override
  String get minYear => 'குறைந்தபட்ச ஆண்டு';

  @override
  String get maxYear => 'அதிகபட்ச ஆண்டு';

  @override
  String selectArtistsExclude(int num) {
    return 'விலக்க கலைஞர்களைத் தேர்ந்தெடுக்கவும்: $num தேர்ந்தெடுக்கப்பட்டது.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'சேர்க்க கலைஞர்களைத் தேர்ந்தெடுக்கவும்: $num தேர்ந்தெடுக்கப்பட்டது.';
  }

  @override
  String get includeAllArtists =>
      'எதுவும் தேர்ந்தெடுக்கப்படாவிட்டால் அனைத்து கலைஞர்களையும் சேர்க்கவும்.';

  @override
  String get excludeArtists => 'தேர்ந்தெடுக்கப்பட்ட கலைஞர்களை விலக்கு';

  @override
  String get limitSongs => 'பாடல்களின் எண்ணிக்கையை கட்டுப்படுத்துங்கள்';

  @override
  String get orderSettings => 'அமைப்புகளை ஆர்டர் செய்யுங்கள்';

  @override
  String get orderSettingsDescription =>
      'முன்னுரிமைகளை மாற்ற விருப்பங்களை மறுவரிசைப்படுத்தவும்.';

  @override
  String get createSmartlist => 'ச்மார்ட்லிச்ட்டை உருவாக்கவும்';

  @override
  String get editSmartlist => 'ச்மார்ட்லிச்ட்டைத் திருத்து';

  @override
  String get play => 'விளையாடுங்கள்';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count தேர்ந்தெடுக்கப்பட்ட பாடல்கள்',
      one: 'ஒரு தேர்ந்தெடுக்கப்பட்ட பாடல்',
      zero: 'பாடல்கள் தேர்ந்தெடுக்கப்படவில்லை',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'அடுத்து விளையாடுங்கள்';

  @override
  String get appendToQueued =>
      'கைமுறையாக வரிசைப்படுத்தப்பட்ட பாடல்களைச் சேர்க்கவும்';

  @override
  String get addToQueue => 'வரிசையில் சேர்க்கவும்';

  @override
  String get disc => 'வட்டு';

  @override
  String get blockFromLibrary => 'நூலகத்திலிருந்து அகற்றி தடுக்கவும்';

  @override
  String get highlights => 'சிறப்பம்சங்கள்';

  @override
  String get shuffle => 'கலக்கு';

  @override
  String get selectArtists => 'கலைஞர்களைத் தேர்ந்தெடுக்கவும்';

  @override
  String get removeFromQueue => 'வரிசையிலிருந்து அகற்று';

  @override
  String get currentlyPlaying => 'தற்போது விளையாடுகிறது';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count பாடல்கள்',
      one: 'ஒரு பாடல்',
      zero: 'பாடல்கள் இல்லை',
    );
    return 'வரிசையில் $_temp0';
  }

  @override
  String moreAvailable(int num) {
    return '$num மேலும் கிடைக்கிறது';
  }

  @override
  String get nameMustNotBeEmpty => 'பெயர் காலியாக இருக்கக்கூடாது.';

  @override
  String get artistName => 'கலைஞரின் பெயர்';

  @override
  String get likeCount => 'எண்ணிக்கை போன்றது';

  @override
  String get playCount => 'விளையாட்டு எண்ணிக்கை';

  @override
  String get songTitle => 'பாடல் தலைப்பு';

  @override
  String get year => 'ஆண்டு';

  @override
  String get timeAdded => 'நேரம் சேர்க்கப்பட்டது';

  @override
  String get addToPlaylist => 'பிளேலிச்ட்டில் சேர்க்கவும்';

  @override
  String get removeFromPlaylist => 'பிளேலிச்ட்டிலிருந்து அகற்று';

  @override
  String get cancel => 'ரத்துசெய்';

  @override
  String get nextUp => 'அடுத்து';

  @override
  String get previousSong => 'முந்தைய';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count முறை இயக்கப்பட்டது',
      one: 'ஒருமுறை இயக்கப்பட்டது',
      zero: 'இன்னும் இயக்கவில்லை',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => 'முன்பு முந்தைய பாடலை எப்போதும் வாசிக்கவும்';

  @override
  String get alwaysPlayNext => 'எப்போதும் அடுத்த பாடலை வாசிக்கவும்';

  @override
  String get dontExcludeSong => 'இந்த பாடலை விலக்க வேண்டாம்.';

  @override
  String get excludeShuffleAllSong =>
      'எல்லா பாடல்களையும் மாற்றும்போது விலக்கு.';

  @override
  String get excludeShuffleSong => 'கலக்கும்போது விலக்கு.';

  @override
  String get alwaysExcludeSong => 'இந்த பாடலை எப்போதும் விலக்குங்கள்.';

  @override
  String get welcomeToMucke => 'மக்கிக்கு வருக!';

  @override
  String get setupLibrary => 'நூலகத்தை அமைக்கவும்';

  @override
  String get setupLibraryDescription =>
      'கோப்புறைகளைத் தேர்ந்தெடுக்கவும், சேர்க்கப்பட்ட கோப்பு நீட்டிப்புகள் போன்றவை.';

  @override
  String get importData => 'தரவை இறக்குமதி செய்யுங்கள்';

  @override
  String get importDataDescription =>
      'முந்தைய மக் நிறுவலில் இருந்து உங்கள் தரவை இறக்குமதி செய்யுங்கள்.';

  @override
  String get yourLibrary => 'உங்கள் நூலகம்:';

  @override
  String get scan => 'ச்கேன்';

  @override
  String get noFoldersSelected =>
      'இதுவரை எந்த கோப்புறைகளும் தேர்ந்தெடுக்கப்படவில்லை.';

  @override
  String get addFolder => 'கோப்புறையைச் சேர்';

  @override
  String get availableFromImport =>
      'இறக்குமதி செய்யப்பட்ட தரவுகளிலிருந்து கிடைக்கிறது:';

  @override
  String get use => 'பயன்படுத்தவும்';

  @override
  String get reset => 'மீட்டமை';

  @override
  String get blockedFilesDescription =>
      'இறக்குமதி செய்யப்பட்ட தரவுகளிலிருந்து தடுக்கப்பட்ட கோப்புகள். சரியான போட்டிகள் மட்டுமே நூலக ச்கேன் மூலம் விலக்கப்படும். கூடுதல் கோப்புகளை பின்னர் பயன்பாட்டில் தடுக்கலாம்.';

  @override
  String get importLibData => 'நூலகத் தரவை இறக்குமதி செய்யுங்கள்';

  @override
  String get songMetaData => 'பாடல் மேனிலை தரவு';

  @override
  String metaDataAvailable(int num) {
    return '$num பாடல்களுக்கான மேனிலை தரவு';
  }

  @override
  String get metaDataDescription =>
      'இறக்குமதி விருப்பங்கள், தொகுதிகள் போன்றவை.';

  @override
  String get imported => 'இறக்குமதி செய்யப்பட்டது';

  @override
  String get importVerb => 'இறக்குமதி';

  @override
  String get miscellaneous => 'மற்றவை';

  @override
  String get exportData => 'தரவு ஏற்றுமதி';

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
      'நீங்கள் ஏற்றுமதி செய்ய விரும்பும் தரவைத் தேர்ந்தெடுக்கவும். இயல்பாக, எல்லாம் ஏற்றுமதி செய்யப்படுகிறது. ஏற்றுமதி செய்யும் போது, கோப்பை சேமிக்க ஒரு கோப்புறையைத் தேர்ந்தெடுக்கலாம்.';

  @override
  String get songsAlbumsArtists => 'பாடல்கள், ஆல்பங்கள் மற்றும் கலைஞர்கள்';

  @override
  String get librarySettings => 'நூலக அமைப்புகள்';

  @override
  String dataExportedTo(String path) {
    return 'தரவு ஏற்றுமதி:\n $path';
  }

  @override
  String get dataExportFailed => 'தரவு ஏற்றுமதி தோல்வியடைந்தது!';

  @override
  String get yourPlaylists => 'உங்கள் பிளேலிச்ட்கள்';

  @override
  String get systemSettings => 'கணினி அமைப்புகள்';

  @override
  String get batteryExplanation =>
      'ஆண்ட்ராய்டு 12 இல் தொடங்கி, பேட்டரி தேர்வுமுறை ஆடியோ கவனத்தை இழந்த பிறகு அறிவிப்புடன் பிழையை ஏற்படுத்துகிறது, எடுத்துக்காட்டாக அழைப்பைப் பெறும்போது. மக்கிற்கான தேர்வுமுறையை முடக்குவது இந்த சிக்கலை தீர்க்கிறது.';

  @override
  String get openBattery => 'பேட்டரி அமைப்புகளைத் திறக்கவும்';

  @override
  String get disableBattery =>
      'அறிவிப்பு சிக்கல்களைத் தீர்க்க முக்கேக்கான தேர்வுமுறை முடக்கு.';

  @override
  String get disableBatteryDescription =>
      'Disabling battery optimization can solve potential notification issues.';

  @override
  String get disabledBattery => 'பேட்டரி தேர்வுமுறை முடக்கப்பட்டுள்ளது.';

  @override
  String get manageExternalExplanation =>
      'இந்த அனுமதியை வழங்குவது நூலக ச்கேன்களின் வேகத்தை கணிசமாக மேம்படுத்தலாம். இது பயன்பாட்டின் நடத்தையை மாற்றாது.';

  @override
  String get grantManagePermission =>
      'எல்லா கோப்புகளையும் நிர்வகிக்க இசைவு வழங்கவும்.';

  @override
  String get managePermissionSubtitle =>
      'இசைவு திரும்பப் பெறுவது பயன்பாட்டின் மறுதொடக்கத்தை ஏற்படுத்தும்.';

  @override
  String get favorites => 'பிடித்தவை';

  @override
  String get favoritesDesc => 'நீங்கள் விரும்பும் அனைத்து பாடல்களும் உள்ளன.';

  @override
  String get newlyAdded => 'புதிதாக சேர்க்கப்பட்டது';

  @override
  String get newlyAddedDesc => 'கடைசியாக சேர்க்கப்பட்ட 100 பாடல்கள் உள்ளன.';

  @override
  String get back => 'பின்';

  @override
  String get next => 'அடுத்தது';

  @override
  String get finish => 'முடிக்க';

  @override
  String get errorReadData => 'தரவு கோப்பைப் படிப்பதில் பிழை.';

  @override
  String get createSmartlists => 'அறிவுள்ள பட்டியல்களை உருவாக்கவும்';

  @override
  String get createSmartlistsDesc =>
      'உங்கள் கேட்கும் அனுபவத்தை மேம்படுத்த பரிந்துரைக்கப்பட்ட ச்மார்ட்லிச்ட்களை உருவாக்கவும். இந்த பட்டியல்களை பின்னர் தனிப்பயனாக்கலாம்.';

  @override
  String get create => 'உருவாக்கு';

  @override
  String get created => 'உருவாக்கப்பட்டது';
}
