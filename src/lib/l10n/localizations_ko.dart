// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class L10nKo extends L10n {
  L10nKo([String locale = 'ko']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get customizeHomePage => 'Customize Home Page';

  @override
  String get settings => 'Settings';

  @override
  String get noSongsYet =>
      'Lightryy에 당신의 Syngs를 찾고 있습니다. 설정으로 이동하여 음악 폴더를 추가하고 라이브러리를 업데이트하십시오.';

  @override
  String get library => 'Library';

  @override
  String get search => 'Search';

  @override
  String get updateLibrary => 'Update library';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount 아티스트, $albumCount 앨범, $songCount 곡';
  }

  @override
  String get manageLibraryFolders => 'Manage library folders';

  @override
  String get allowedFileExtensions => 'Allowed file extensions';

  @override
  String get allowedFileExtensionsDescription =>
      '허용 된 확장의 일부 컴파일 목록은 하부에 논픽되지 않습니다. 아무런 결과가 있으면이 기본값은 기본값을 불필요하게합니다.';

  @override
  String get manageBlockedFiles => 'Manage blocked files';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return '현재 차단된 파일의 수: $blockedFiles';
  }

  @override
  String get playback => 'Playback';

  @override
  String get playAlbumsInOrder => 'Play albums in order';

  @override
  String get playAlbumsInOrderDescription =>
      '앨범에서 노래를 클릭하면 이전 재생 모드를 유지 대신 주문에서 재생됩니다.';

  @override
  String countSongsPlayed(int percentage) {
    return '연주 후: $percentage%';
  }

  @override
  String get libraryFolders => 'Library Folders';

  @override
  String get blockedFiles => 'Blocked Files';

  @override
  String get homeCustomization => 'Home Customization';

  @override
  String get albumOfTheDay => 'Album of the Day';

  @override
  String get artistOfTheDay => 'Artist of the Day';

  @override
  String get shuffleAll => 'Shuffle All';

  @override
  String get history => 'History';

  @override
  String get addWidgetToHome => '홈 페이지에 위젯 추가';

  @override
  String get noPlaylistsYet => '아직 재생 목록이 없습니다. 도서관에 추가할 수 있습니다.';

  @override
  String get lastPlayed => 'Last played';

  @override
  String get noHistoryYet => '아직 볼 수 없습니다. 뭔가를 재생합니다.';

  @override
  String get allSongs => 'All Songs';

  @override
  String get song => 'Song';

  @override
  String get songs => 'Songs';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 노래',
      one: 'one song',
      zero: 'no songs',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Album';

  @override
  String get albums => 'Albums';

  @override
  String get artist => 'Artist';

  @override
  String get artists => 'Artists';

  @override
  String get playlist => 'Playlist';

  @override
  String get playlists => 'Playlists';

  @override
  String get smartlist => 'Smartlist';

  @override
  String get smartlists => 'Smartlists';

  @override
  String get noShuffle => '없음 (현재 shuffle 형태를 따르십시오)';

  @override
  String get normalMode => 'Normal Mode';

  @override
  String get shuffleMode => 'Shuffle Mode';

  @override
  String get favShuffleMode => 'Favorite Shuffle Mode';

  @override
  String get playlistNormalMode => 'Play from the top';

  @override
  String get playlistShuffleMode => 'Start shuffle playback';

  @override
  String get playlistFavShuffleMode => 'Start favorite shuffle playback';

  @override
  String get name => 'Name';

  @override
  String get sortingFilterSettings => 'Sorting and Filter Settings';

  @override
  String get maxNumberEntries => 'Maximum number of entries';

  @override
  String get creationDate => 'Creation Date';

  @override
  String get changeDate => 'Change Date';

  @override
  String get lastTimePlayed => 'Last Time Played';

  @override
  String get ascending => 'Ascending';

  @override
  String get descending => 'Descending';

  @override
  String get both => 'Both';

  @override
  String get playlistsOnly => 'Playlists Only';

  @override
  String get smartlistsOnly => 'Smartlists Only';

  @override
  String get displaySettings => 'Display Settings';

  @override
  String get addSmartlist => 'Add Smartlist';

  @override
  String get addPlaylist => 'Add Playlist';

  @override
  String get createPlaylist => 'Create Playlist';

  @override
  String get editPlaylist => 'Edit Playlist';

  @override
  String get customizeCover => 'Customize Cover';

  @override
  String get playbackMode => 'Playback Mode';

  @override
  String get excludeAllSongs => '제외된 모든 곡을 제외합니다.';

  @override
  String get excludeInShuffle => '셔플 패션에서 배제를 위해 표시된 노래를 제외하십시오.';

  @override
  String get excludeAlways => '항상 제외로 노래 한 노래 만 제외하십시오.';

  @override
  String get dontExclude => 'Don\'t exclude any songs.';

  @override
  String get filterSettings => 'Filter Settings';

  @override
  String filterLikes(int min, int max) {
    return '$min와 $max와 같은';
  }

  @override
  String get minPlayCount => 'Minimum play count';

  @override
  String get maxPlayCount => 'Maximum play count';

  @override
  String get minYear => 'Minimum Year';

  @override
  String get maxYear => 'Maximum Year';

  @override
  String selectArtistsExclude(int num) {
    return '아티스트를 선택하세요: $num 선택.';
  }

  @override
  String selectArtistsInclude(int num) {
    return '아티스트 선택: $num 선택.';
  }

  @override
  String get includeAllArtists => '선택되지 않은 경우 모든 아티스트를 포함.';

  @override
  String get excludeArtists => 'Exclude selected artists';

  @override
  String get limitSongs => 'Limit number of songs';

  @override
  String get orderSettings => 'Order Settings';

  @override
  String get orderSettingsDescription => '사전을 변경하는 주문 옵션.';

  @override
  String get createSmartlist => 'Create Smartlist';

  @override
  String get editSmartlist => 'Edit Smartlist';

  @override
  String get play => 'Play';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 곡 선택',
      one: 'one song selected',
      zero: 'no songs selected',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Play next';

  @override
  String get appendToQueued => '수동 퀴즈 곡에 대한 감사';

  @override
  String get addToQueue => 'Add to queue';

  @override
  String get disc => 'Disc';

  @override
  String get blockFromLibrary => '도서관에서 제거 및 차단';

  @override
  String get highlights => 'Highlights';

  @override
  String get shuffle => 'Shuffle';

  @override
  String get selectArtists => 'Select Artists';

  @override
  String get removeFromQueue => 'Remove from queue';

  @override
  String get currentlyPlaying => 'Currently playing';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count song',
      one: 'one song',
      zero: 'no songs',
    );
    return '$_temp0';
  }

  @override
  String moreAvailable(int num) {
    return '$num more available';
  }

  @override
  String get nameMustNotBeEmpty => '이름은 비어 있어야합니다.';

  @override
  String get artistName => 'Artist name';

  @override
  String get likeCount => 'Like count';

  @override
  String get playCount => 'Play count';

  @override
  String get songTitle => 'Song title';

  @override
  String get year => 'Year';

  @override
  String get timeAdded => 'Time added';

  @override
  String get addToPlaylist => 'Add to playlist';

  @override
  String get removeFromPlaylist => 'Remove from playlist';

  @override
  String get cancel => 'Cancel';

  @override
  String get nextUp => 'Next up';

  @override
  String get previousSong => 'previous';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'played $count times',
      one: 'played once',
      zero: 'not plays yet',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => '항상 이전 노래를 재생하기 전에';

  @override
  String get alwaysPlayNext => '항상 다음 노래를 재생하십시오.';

  @override
  String get dontExcludeSong => 'Don\'t exclude this song.';

  @override
  String get excludeShuffleAllSong => '모든 노래를 shuffling 할 때 예외.';

  @override
  String get excludeShuffleSong => 'Exclude when shuffling.';

  @override
  String get alwaysExcludeSong => 'Always exclude this song.';

  @override
  String get welcomeToMucke => 'Welcome to mucke!';

  @override
  String get setupLibrary => 'Set up Library';

  @override
  String get setupLibraryDescription => '폴더를 선택, 포함 파일 확장, 기타.';

  @override
  String get importData => 'Import data';

  @override
  String get importDataDescription => '이전 mucke 설치에서 데이터를 가져옵니다.';

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
      '가져온 데이터에서 차단 된 파일. 라이브러리 검사에서 제외 된 와트 젤 벨라 만 만 제출하십시오. 앱에서 앱을 추가로 막을 수 있습니다.';

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
      '수출하고 싶은 자료를 선택하십시오. 기본적으로, 모든 것이 수출됩니다. 수출 할 때, 당신은 저장 될 파일에 대한 폴더를 선택할 수 있습니다.';

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
      'Android 12부터 Battery Optimization은 콜백을 수신 한 후에는 풋 오디오 오디오를 잃은 후에 알림으로 인한 오류를 일으키고 있습니다. 믹스에 대한 최적화를 사용하지 않으면이 문제를 해결합니다.';

  @override
  String get openBattery => 'Open battery settings';

  @override
  String get disableBattery => '통보 문제를 해결하기 위해 Mucke에 대한 최적화를 비활성화하십시오.';

  @override
  String get disableBatteryDescription =>
      'Disabling battery optimization can solve potential notification issues.';

  @override
  String get disabledBattery => 'Battery optimization is disabled.';

  @override
  String get manageExternalExplanation =>
      '이 권한을 부여하면 라이브러리 스캔 속도를 크게 향상시킬 수 있습니다. 그렇지 않으면 앱의 동작을 변경하지 않습니다.';

  @override
  String get grantManagePermission => '모든 파일을 관리 할 수있는 권한을 부여합니다.';

  @override
  String get managePermissionSubtitle => '권한을 취소하면 앱을 다시 시작할 수 있습니다.';

  @override
  String get favorites => 'Favorites';

  @override
  String get favoritesDesc => '당신이 좋아하는 모든 노래를 포함합니다.';

  @override
  String get newlyAdded => 'Newly added';

  @override
  String get newlyAddedDesc => '마지막으로 추가 된 100 곡을 포함합니다.';

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
      '청취 경험을 향상시키기 위해 제안 된 스마트리스트를 만듭니다. 이 목록을 나중에 사용자 정의 할 수 있습니다.';

  @override
  String get create => 'Create';

  @override
  String get created => 'Created';
}
