// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class L10nRu extends L10n {
  L10nRu([String locale = 'ru']) : super(locale);

  @override
  String get home => 'Главная';

  @override
  String get customizeHomePage => 'Настроить главную страницу';

  @override
  String get settings => 'Настройки';

  @override
  String get noSongsYet =>
      'Похоже, что у вас нет ни одной песни в вашей медиатеке: перейдите в настройки, добавьте свои папки с треками и обновите медиатеку.';

  @override
  String get library => 'Библиотека';

  @override
  String get search => 'Поиск';

  @override
  String get updateLibrary => 'Обновить библиотеку';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount исполнителей, $albumCount альбомов, $songCount треков';
  }

  @override
  String get manageLibraryFolders => 'Управление папками библиотеки';

  @override
  String get allowedFileExtensions => 'Разрешенные расширения файлов';

  @override
  String get allowedFileExtensionsDescription =>
      'Список, разрешенных расширений файлов, разделенный запятыми. Строчные или прописные буквы не имеют значения. Если вы не уверены в этом, просто используйте по умолчанию.';

  @override
  String get manageBlockedFiles => 'Управление заблокированными файлами';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Количество заблокированных в данный момент файлов: $blockedFiles';
  }

  @override
  String get playback => 'Воспроизведение';

  @override
  String get playAlbumsInOrder => 'Воспроизводить альбомы по порядку';

  @override
  String get playAlbumsInOrderDescription =>
      'Когда вы нажимаете на песню в альбоме, песни будут воспроизводиться по порядку, вместо сохранения предыдущего режима воспроизведения.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Подсчитывать песни, которые были воспроизведены после: $percentage%';
  }

  @override
  String get libraryFolders => 'Папки библиотеки';

  @override
  String get blockedFiles => 'Заблокированные файлы';

  @override
  String get homeCustomization => 'Настройка главной страницы';

  @override
  String get albumOfTheDay => 'Альбом дня';

  @override
  String get artistOfTheDay => 'Артист дня';

  @override
  String get shuffleAll => 'Перемещать все';

  @override
  String get history => 'История';

  @override
  String get addWidgetToHome => 'Добавить виджет на домашнюю страницу';

  @override
  String get noPlaylistsYet =>
      'Плейлистов пока нет. Вы можете добавить их в библиотеке.';

  @override
  String get lastPlayed => 'Последнее воспроизведение';

  @override
  String get noHistoryYet =>
      'Пока здесь не на что смотреть. Послушайте что-нибудь.';

  @override
  String get allSongs => 'Все песни';

  @override
  String get song => 'Песня';

  @override
  String get songs => 'Песни';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count песни',
      one: 'одна песня',
      zero: 'песен нет',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Альбом';

  @override
  String get albums => 'Альбомы';

  @override
  String get artist => 'Исполнитель';

  @override
  String get artists => 'Исполнители';

  @override
  String get playlist => 'Плейлист';

  @override
  String get playlists => 'Плейлисты';

  @override
  String get smartlist => 'Умный список';

  @override
  String get smartlists => 'Умные списки';

  @override
  String get noShuffle => 'Нет (сохранить текущий режим перемешивания)';

  @override
  String get normalMode => 'Обычный режим';

  @override
  String get shuffleMode => 'Режим перемешивания';

  @override
  String get favShuffleMode => 'Режим перемешивания по избранному';

  @override
  String get name => 'Имя';

  @override
  String get sortingFilterSettings => 'Настройка сортировки и фильтров';

  @override
  String get maxNumberEntries => 'Максимальное количество записей';

  @override
  String get creationDate => 'Дата создания';

  @override
  String get changeDate => 'Дата изменения';

  @override
  String get lastTimePlayed => 'Последнее воспроизведение';

  @override
  String get ascending => 'По возрастанию';

  @override
  String get descending => 'По убыванию';

  @override
  String get both => 'Оба';

  @override
  String get playlistsOnly => 'Только плейлисты';

  @override
  String get smartlistsOnly => 'Только смарт-списки';

  @override
  String get displaySettings => 'Настройки отображения';

  @override
  String get addSmartlist => 'Добавить смарт-список';

  @override
  String get addPlaylist => 'Добавить плейлист';

  @override
  String get createPlaylist => 'Создать плейлист';

  @override
  String get editPlaylist => 'Изменить плейлист';

  @override
  String get customizeCover => 'Изменить обложку';

  @override
  String get playbackMode => 'Режим воспроизведения';

  @override
  String get excludeAllSongs =>
      'Исключить все песни, помеченные для исключения.';

  @override
  String get excludeInShuffle =>
      'Исключить песни, помеченные для исключения в режиме перемешивания.';

  @override
  String get excludeAlways =>
      'Исключать только песни, помеченные как всегда исключаемые.';

  @override
  String get dontExclude => 'Не исключать любые песни.';

  @override
  String get filterSettings => 'Настройка фильтров';

  @override
  String filterLikes(int min, int max) {
    return 'Количество лайков от $min до $max';
  }

  @override
  String get minPlayCount => 'Минимальное количество воспроизведений';

  @override
  String get maxPlayCount => 'Максимальное количество воспроизведений';

  @override
  String get minYear => 'Минимальный год';

  @override
  String get maxYear => 'Максимальный год';

  @override
  String selectArtistsExclude(int num) {
    return 'Выберите исполнителей, которых хотите исключить: $num выбрано.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Выберите исполнителей, которых хотите включить: $num выбрано.';
  }

  @override
  String get includeAllArtists =>
      'Включить всех исполнителей, если ни один не выбран.';

  @override
  String get excludeArtists => 'Исключить выбранных исполнителей';

  @override
  String get limitSongs => 'Ограничение количества песен';

  @override
  String get orderSettings => 'Сортировка';

  @override
  String get orderSettingsDescription =>
      'Измените порядок опций, чтобы изменить приоритеты.';

  @override
  String get createSmartlist => 'Создать смарт-список';

  @override
  String get editSmartlist => 'Редактировать смарт-список';

  @override
  String get play => 'Играть';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'выбрано $count песен',
      one: 'выбрана одна песня',
      zero: 'песни не выбраны',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Играть дальше';

  @override
  String get appendToQueued =>
      'Добавлять к песням, помещенным в очередь вручную';

  @override
  String get addToQueue => 'Добавить в очередь';

  @override
  String get disc => 'Диск';

  @override
  String get blockFromLibrary => 'Удалить из библиотеки и заблокировать';

  @override
  String get highlights => 'Основные моменты';

  @override
  String get shuffle => 'Перемешать';

  @override
  String get selectArtists => 'Выбрать исполнителей';

  @override
  String get removeFromQueue => 'Удалить из очереди';

  @override
  String get currentlyPlaying => 'Сейчас играет';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count песен',
      one: 'одна песня',
      zero: 'песен нет',
    );
    return '$_temp0 в очереди';
  }

  @override
  String moreAvailable(int num) {
    return 'Доступно еще $num';
  }

  @override
  String get nameMustNotBeEmpty => 'Имя не должно быть пустым.';

  @override
  String get artistName => 'Имя исполнителя';

  @override
  String get likeCount => 'Количество лайков';

  @override
  String get playCount => 'Количество воспроизведений';

  @override
  String get songTitle => 'Название песни';

  @override
  String get year => 'Год';

  @override
  String get timeAdded => 'Время добавления';

  @override
  String get addToPlaylist => 'Добавить в список воспроизведения';

  @override
  String get removeFromPlaylist => 'Удалить из списка воспроизведения';

  @override
  String get cancel => 'Отменить';

  @override
  String get nextUp => 'Далее';

  @override
  String get previousSong => 'предыдущая';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'играло $count раз',
      one: 'играло один раз',
      zero: 'еще не играло',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => 'Всегда воспроизводить предыдущую песню';

  @override
  String get alwaysPlayNext => 'Всегда воспроизводить следующую песню';

  @override
  String get dontExcludeSong => 'Не исключать эту песню.';

  @override
  String get excludeShuffleAllSong => 'Исключить при перемешивании всех песен.';

  @override
  String get excludeShuffleSong => 'Исключить при перемешивании.';

  @override
  String get alwaysExcludeSong => 'Всегда исключать эту песню.';

  @override
  String get welcomeToMucke => 'Добро пожаловать в mucke!';

  @override
  String get setupLibrary => 'Настройка библиотеки';

  @override
  String get setupLibraryDescription =>
      'Выберите папки, включая расширения файлов и т.д.';

  @override
  String get importData => 'Импорт данных';

  @override
  String get importDataDescription =>
      'Импортируйте свои данные из предыдущей установки mucke.';

  @override
  String get yourLibrary => 'Ваша библиотека:';

  @override
  String get scan => 'Сканировать';

  @override
  String get noFoldersSelected => 'До сих пор не выбраны папки.';

  @override
  String get addFolder => 'Добавить папку';

  @override
  String get availableFromImport => 'Доступно из импортных данных:';

  @override
  String get use => 'Использовать';

  @override
  String get reset => 'Сбросить';

  @override
  String get blockedFilesDescription =>
      'Файлы, исключенные из импортированных данных. Только точные совпадения будут исключены. Другие файлы также могут быть исключены позже.';

  @override
  String get importLibData => 'Импорт данных библиотеки';

  @override
  String get songMetaData => 'Метаданные композиции';

  @override
  String metaDataAvailable(int num) {
    return 'Metadata for $num songs available';
  }

  @override
  String get metaDataDescription => 'Импорт лайков, блоков и т.д.';

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
  String get songsAlbumsArtists => 'Песни, альбомы и исполнители';

  @override
  String get librarySettings => 'Library Settings';

  @override
  String dataExportedTo(String path) {
    return 'Данные экспортируются в:\n$path';
  }

  @override
  String get dataExportFailed => 'Экспорт данных не удался!';

  @override
  String get yourPlaylists => 'Ваши плейлисты';

  @override
  String get systemSettings => 'Системные Настройки';

  @override
  String get batteryExplanation =>
      'Начиная с Android 12, оптимизация батареи приводит к проблемам с уведомлением после потери аудио фокуса, например при получении звонка. Отключение оптимизации для mucke решает эту проблему.';

  @override
  String get openBattery => 'Открыть настройки батареи';

  @override
  String get disableBattery =>
      'Отключить оптимизацию для mucke чтобы решить проблемы с уведомлением.';

  @override
  String get disabledBattery => 'Оптимизация батареи отключена.';

  @override
  String get manageExternalExplanation =>
      'Предоставление этого разрешения может значительно ускорить сканирование библиотеки. Больше это никак не повлияет на поведение приложения.';

  @override
  String get grantManagePermission =>
      'Предоставить разрешение на управление всеми файлами.';

  @override
  String get managePermissionSubtitle =>
      'Отзыв разрешения вызовет перезапуск приложения.';

  @override
  String get favorites => 'Favorites';

  @override
  String get favoritesDesc => 'Contains all the songs that you like.';

  @override
  String get newlyAdded => 'Newly added';

  @override
  String get newlyAddedDesc => 'Содержит последние 100 добавленных композиций.';

  @override
  String get back => 'Назад';

  @override
  String get next => 'Далее';

  @override
  String get finish => 'Finish';

  @override
  String get errorReadData => 'Ошибка чтения файла данных.';

  @override
  String get createSmartlists => 'Создание умных списков';

  @override
  String get createSmartlistsDesc =>
      'Create suggested smartlists to enhance your listening experience. You can customize these lists later.';

  @override
  String get create => 'Create';

  @override
  String get created => 'Created';
}
