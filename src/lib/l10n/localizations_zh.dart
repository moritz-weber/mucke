// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class L10nZh extends L10n {
  L10nZh([String locale = 'zh']) : super(locale);

  @override
  String get home => '主页';

  @override
  String get customizeHomePage => '个性化主页';

  @override
  String get settings => '设置';

  @override
  String get noSongsYet => '当前无歌曲，请到设置中添加你的音乐文件夹';

  @override
  String get library => '歌曲库';

  @override
  String get search => '搜索';

  @override
  String get updateLibrary => '更新歌曲库';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount 歌手, $albumCount 专辑, $songCount 歌曲';
  }

  @override
  String get manageLibraryFolders => '管理歌曲文件夹';

  @override
  String get allowedFileExtensions => '允许扫描的歌曲扩展名';

  @override
  String get allowedFileExtensionsDescription =>
      '需要扫描的媒体文件扩展名列表，多个以英文逗号分隔，不区分大小写。如果您不清楚做什么，保持默认值即可。';

  @override
  String get manageBlockedFiles => '管理音乐黑名单';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return '被禁用的音乐数量： $blockedFiles';
  }

  @override
  String get playback => '播放';

  @override
  String get playAlbumsInOrder => '按专辑列表音乐顺序播放';

  @override
  String get playAlbumsInOrderDescription => '当点击专辑某首歌时将按列表顺序播放其他歌曲，而不是按其他顺序';

  @override
  String countSongsPlayed(int percentage) {
    return '在播放达 $percentage% 后计入歌曲播放量';
  }

  @override
  String get libraryFolders => '歌曲文件夹';

  @override
  String get blockedFiles => '禁用的文件夹';

  @override
  String get homeCustomization => '个性化主页';

  @override
  String get albumOfTheDay => '今日特辑';

  @override
  String get artistOfTheDay => '今日大咖';

  @override
  String get shuffleAll => '无序播放全部';

  @override
  String get history => '历史';

  @override
  String get addWidgetToHome => '添加快捷方式至主屏';

  @override
  String get noPlaylistsYet => '歌单空空如也，从曲库中添加点吧。';

  @override
  String get lastPlayed => '上次播放';

  @override
  String get noHistoryYet => '没有更多了，随便听听吧';

  @override
  String get allSongs => '所有歌曲';

  @override
  String get song => '首歌曲';

  @override
  String get songs => '首歌曲';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 首',
      one: '1 首',
      zero: '无歌曲',
    );
    return '$_temp0';
  }

  @override
  String get album => '专辑';

  @override
  String get albums => '专辑';

  @override
  String get artist => '艺人';

  @override
  String get artists => '艺人';

  @override
  String get playlist => '歌单';

  @override
  String get playlists => '歌单';

  @override
  String get smartlist => '智能歌单';

  @override
  String get smartlists => '智能歌单';

  @override
  String get noShuffle => '无（保持当前随机模式）';

  @override
  String get normalMode => '正常模式';

  @override
  String get shuffleMode => '随机模式';

  @override
  String get favShuffleMode => '随机播放收藏夹模式';

  @override
  String get name => '名称';

  @override
  String get sortingFilterSettings => '排序与筛选设置';

  @override
  String get maxNumberEntries => '最大音乐数';

  @override
  String get creationDate => '创建日期';

  @override
  String get changeDate => '修改日期';

  @override
  String get lastTimePlayed => '上次播放时间';

  @override
  String get ascending => '升序';

  @override
  String get descending => '降序';

  @override
  String get both => '二者皆可';

  @override
  String get playlistsOnly => '仅自建歌单';

  @override
  String get smartlistsOnly => '仅智能歌单';

  @override
  String get displaySettings => '显示设置';

  @override
  String get addSmartlist => '添加智能歌单';

  @override
  String get addPlaylist => '添加自建歌单';

  @override
  String get createPlaylist => '创建歌单';

  @override
  String get editPlaylist => '编辑歌单';

  @override
  String get customizeCover => '自定义封面';

  @override
  String get playbackMode => '单曲循环模式';

  @override
  String get excludeAllSongs => '排除所有已标记歌曲';

  @override
  String get excludeInShuffle => '在随机模式下排除已标记歌曲';

  @override
  String get excludeAlways => '仅排除标记为始终排除的歌曲';

  @override
  String get dontExclude => '不排除任何歌曲';

  @override
  String get filterSettings => '过滤器设置';

  @override
  String filterLikes(int min, int max) {
    return '点赞介于 $min 和 $max 之间';
  }

  @override
  String get minPlayCount => '最小播放量';

  @override
  String get maxPlayCount => '最大播放量';

  @override
  String get minYear => '最早年份';

  @override
  String get maxYear => '最晚年份';

  @override
  String selectArtistsExclude(int num) {
    return '选择要排除的艺人：已选择 $num 项';
  }

  @override
  String selectArtistsInclude(int num) {
    return '选择要包含的艺人：已选择 $num 项';
  }

  @override
  String get includeAllArtists => '如果未选择任何艺人，则包括所有。';

  @override
  String get excludeArtists => '排除选定的艺人';

  @override
  String get limitSongs => '限制歌曲数目';

  @override
  String get orderSettings => '排序设置';

  @override
  String get orderSettingsDescription => '重排选项以更改排序优先级。';

  @override
  String get createSmartlist => '创建智能歌单';

  @override
  String get editSmartlist => '编辑智能歌单';

  @override
  String get play => '播放';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '选中 $count 首歌',
      one: '选中 1 首歌',
      zero: '未选中任何歌',
    );
    return '$_temp0';
  }

  @override
  String get playNext => '播放下一首';

  @override
  String get appendToQueued => '附加至手动排列歌曲后';

  @override
  String get addToQueue => '添加到队列';

  @override
  String get disc => '唱片';

  @override
  String get blockFromLibrary => '拉黑并移出曲库';

  @override
  String get highlights => '高亮';

  @override
  String get shuffle => '随机';

  @override
  String get selectArtists => '选择艺人';

  @override
  String get removeFromQueue => '从队列移除';

  @override
  String get currentlyPlaying => '正在播放';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '含 $count 首歌',
      one: '含 1 首歌',
      zero: '无歌曲',
    );
    return '队列 $_temp0';
  }

  @override
  String moreAvailable(int num) {
    return '超过 $num 项可用';
  }

  @override
  String get nameMustNotBeEmpty => '名称不能为空';

  @override
  String get artistName => '艺人名称';

  @override
  String get likeCount => '点赞数';

  @override
  String get playCount => '播放量';

  @override
  String get songTitle => '歌曲标题';

  @override
  String get year => '年';

  @override
  String get timeAdded => '添加时间';

  @override
  String get addToPlaylist => '加入歌单';

  @override
  String get removeFromPlaylist => '从歌单移除';

  @override
  String get cancel => '取消';

  @override
  String get nextUp => '播放队列';

  @override
  String get previousSong => '上一首';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已播放 $count 次',
      one: '已播放 1 次',
      zero: '从未播放',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => '总是播放前一首歌';

  @override
  String get alwaysPlayNext => '总是继续播放下一首歌';

  @override
  String get dontExcludeSong => '不要排除这首歌';

  @override
  String get excludeShuffleAllSong => '随机播放所有歌曲时排除';

  @override
  String get excludeShuffleSong => '随机播放时排除';

  @override
  String get alwaysExcludeSong => '始终排除这首歌曲';

  @override
  String get welcomeToMucke => '欢迎使用 Mucke ！';

  @override
  String get setupLibrary => '设置曲库';

  @override
  String get setupLibraryDescription => '选择歌曲所在的文件夹';

  @override
  String get importData => '导入数据';

  @override
  String get importDataDescription => '从旧版 Mucke 导入数据';

  @override
  String get yourLibrary => '你的曲库：';

  @override
  String get scan => '扫描';

  @override
  String get noFoldersSelected => '暂未选择任何文件夹。';

  @override
  String get addFolder => '添加文件夹';

  @override
  String get availableFromImport => '可导入的数据：';

  @override
  String get use => '使用';

  @override
  String get reset => '重置';

  @override
  String get blockedFilesDescription =>
      '只有与导入数据完全匹配的黑名单文件才会从扫描中排除，您可在稍后中拉黑排除其他文件。';

  @override
  String get importLibData => '导入曲库数据';

  @override
  String get songMetaData => '歌曲元数据';

  @override
  String metaDataAvailable(int num) {
    return '$num 首歌曲的元数据有效';
  }

  @override
  String get metaDataDescription => '导入点赞量、黑名单等。';

  @override
  String get imported => '已完成导入';

  @override
  String get importVerb => '导入';

  @override
  String get miscellaneous => '杂七杂八';

  @override
  String get exportData => '导出备份数据';

  @override
  String get exportDescription => '选择要导出的内容，默认导出所有。导出时可选择保存位置。';

  @override
  String get songsAlbumsArtists => '歌曲、专辑以及艺人';

  @override
  String get librarySettings => '曲库设置';

  @override
  String dataExportedTo(String path) {
    return '数据导出位置：\n$path';
  }

  @override
  String get dataExportFailed => '导出数据失败！';

  @override
  String get yourPlaylists => '你的播放列表';

  @override
  String get systemSettings => '系统设置';

  @override
  String get batteryExplanation =>
      '从 Android 12(S) 开始，电池优化会导致失去音频焦点（例如收到来电时）后通知出错。禁用针对 Mucke 的省电优化（改为无限制）可解决该问题。';

  @override
  String get openBattery => '打开省电设置';

  @override
  String get disableBattery => '禁用针对 Mucke 的省电优化（改为无限制）以解决通知问题。';

  @override
  String get disabledBattery => '针对 Mucke 的省电优化已禁用';

  @override
  String get manageExternalExplanation => '授予该权限可增强扫描歌曲的速度。这不会影响应用的其他行为。';

  @override
  String get grantManagePermission => '授予所有文件读写权限。';

  @override
  String get managePermissionSubtitle => '撤销权限将导致应用程序重新启动。';

  @override
  String get favorites => '我的收藏';

  @override
  String get favoritesDesc => '包含您喜欢的所有歌曲。';

  @override
  String get newlyAdded => '近期新增';

  @override
  String get newlyAddedDesc => '包含最早添加的100首歌曲。';

  @override
  String get back => '返回';

  @override
  String get next => '下一步';

  @override
  String get finish => '完成';

  @override
  String get errorReadData => '读取数据文件时出错。';

  @override
  String get createSmartlists => '创建智能歌单';

  @override
  String get createSmartlistsDesc => '创建智能歌单以增强您的使用体验，您可以稍后自定义列表内容。';

  @override
  String get create => '创建';

  @override
  String get created => '已创建';
}
