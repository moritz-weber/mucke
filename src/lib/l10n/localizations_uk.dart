// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class L10nUk extends L10n {
  L10nUk([String locale = 'uk']) : super(locale);

  @override
  String get home => 'Головна';

  @override
  String get customizeHomePage => 'Налаштувати Головну сторінку';

  @override
  String get settings => 'Налаштування';

  @override
  String get noSongsYet =>
      'Схоже, у вашій бібліотеці немає жодної пісні: Перейдіть до налаштувань, додайте теки з музикою та оновіть бібліотеку.';

  @override
  String get library => 'Бібліотека';

  @override
  String get search => 'Пошук';

  @override
  String get updateLibrary => 'Оновити бібліотеку';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount виконавці, $albumCount альбоми, $songCount пісні';
  }

  @override
  String get manageLibraryFolders => 'Керування папками бібліотеки';

  @override
  String get allowedFileExtensions => 'Допустимі розширення файлів';

  @override
  String get allowedFileExtensionsDescription =>
      'Список дозволених розширень файлів через кому. Малі чи великі літери не мають значення. Якщо ви не впевнені в цьому, просто використовуйте значення за замовчуванням.';

  @override
  String get manageBlockedFiles => 'Керування заблокованими файлами';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Кількість заблокованих на даний момент файлів: $blockedFiles';
  }

  @override
  String get playback => 'Відтворення';

  @override
  String get playAlbumsInOrder => 'Відтворювати альбоми по порядку';

  @override
  String get playAlbumsInOrderDescription =>
      'Коли ви натискаєте на пісню в альбомі, пісні відтворюватимуться по порядку, замість того, щоб зберігати попередній режим відтворення.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Порахуйте пісні, які були відтворені після: $percentage%';
  }

  @override
  String get libraryFolders => 'Теки бібліотеки';

  @override
  String get blockedFiles => 'Заблоковані файли';

  @override
  String get homeCustomization => 'Налаштування Головної сторінки';

  @override
  String get albumOfTheDay => 'Альбом дня';

  @override
  String get artistOfTheDay => 'Виконавець дня';

  @override
  String get shuffleAll => 'Перемішати все';

  @override
  String get history => 'Історія';

  @override
  String get addWidgetToHome => 'Додати віджет на Головну сторінку';

  @override
  String get noPlaylistsYet =>
      'Поки що немає плейлистів. Ви можете додати їх у бібліотеці.';

  @override
  String get lastPlayed => 'Останнє відтворення';

  @override
  String get noHistoryYet =>
      'Поки що тут нема на що дивитися. Відтворіть що-небудь.';

  @override
  String get allSongs => 'Всі пісні';

  @override
  String get song => 'Пісня';

  @override
  String get songs => 'Пісні';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пісні',
      one: 'одна пісня',
      zero: 'немає пісень',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Альбом';

  @override
  String get albums => 'Альбоми';

  @override
  String get artist => 'Виконавець';

  @override
  String get artists => 'Виконавці';

  @override
  String get playlist => 'Список відтворення';

  @override
  String get playlists => 'Списки відтворення';

  @override
  String get smartlist => 'Розумний список';

  @override
  String get smartlists => 'Розумні списки';

  @override
  String get noShuffle => 'Ні (зберегти поточний режим перемішування)';

  @override
  String get normalMode => 'Звичайний режим';

  @override
  String get shuffleMode => 'Режим перемішування';

  @override
  String get favShuffleMode => 'Улюблений режим перемішування';

  @override
  String get name => 'Ім\'я';

  @override
  String get sortingFilterSettings => 'Налаштування сортування та фільтрів';

  @override
  String get maxNumberEntries => 'Максимальна кількість записів';

  @override
  String get creationDate => 'Дата створення';

  @override
  String get changeDate => 'Дата зміни';

  @override
  String get lastTimePlayed => 'Востаннє відтворено';

  @override
  String get ascending => 'За зростанням';

  @override
  String get descending => 'За спаданням';

  @override
  String get both => 'Обидва';

  @override
  String get playlistsOnly => 'Тільки списки відтворення';

  @override
  String get smartlistsOnly => 'Тільки розумні списки';

  @override
  String get displaySettings => 'Налаштування дисплею';

  @override
  String get addSmartlist => 'Додати розумний список';

  @override
  String get addPlaylist => 'Додати список відтворення';

  @override
  String get createPlaylist => 'Створити список відтворення';

  @override
  String get editPlaylist => 'Редагувати список відтворення';

  @override
  String get customizeCover => 'Налаштувати обкладинку';

  @override
  String get playbackMode => 'Режим відтворення';

  @override
  String get excludeAllSongs =>
      'Виключіть всі пісні, позначені для виключення.';

  @override
  String get excludeInShuffle =>
      'Виключити пісні, позначені для виключення в режимі перемішування.';

  @override
  String get excludeAlways =>
      'Виключати лише пісні, позначені як завжди виключати.';

  @override
  String get dontExclude => 'Не виключати жодної пісні.';

  @override
  String get filterSettings => 'Налаштування фільтрів';

  @override
  String filterLikes(int min, int max) {
    return 'Вподобання між $min та $max';
  }

  @override
  String get minPlayCount => 'Мінімальна кількість відтворення';

  @override
  String get maxPlayCount => 'Максимальна кількість відтворення';

  @override
  String get minYear => 'Мінімальний рік';

  @override
  String get maxYear => 'Максимальний рік';

  @override
  String selectArtistsExclude(int num) {
    return 'Виберіть виконавців, яких потрібно виключити: $num вибрано.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Виберіть виконавців, яких потрібно включити: $num вибрано.';
  }

  @override
  String get includeAllArtists =>
      'Включити всіх виконавців, якщо жоден не був вибраний.';

  @override
  String get excludeArtists => 'Виключити вибраних виконавців';

  @override
  String get limitSongs => 'Обмеження на кількість пісень';

  @override
  String get orderSettings => 'Сортування';

  @override
  String get orderSettingsDescription =>
      'Перевпорядкуйте варіанти, щоб змінити пріоритети.';

  @override
  String get createSmartlist => 'Створити розумний список';

  @override
  String get editSmartlist => 'Редагувати розумний список';

  @override
  String get play => 'Грати';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'вибрано $count пісень',
      one: 'вибрано одну пісню',
      zero: 'пісні не вибрано',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Грати далі';

  @override
  String get appendToQueued => 'Додати до пісні, поставлених у чергу вручну';

  @override
  String get addToQueue => 'Додати в чергу';

  @override
  String get disc => 'Диск';

  @override
  String get blockFromLibrary => 'Видалити та заблокувати з бібліотеки';

  @override
  String get highlights => 'Основні моменти';

  @override
  String get shuffle => 'Перемішати';

  @override
  String get selectArtists => 'Вибрати виконавців';

  @override
  String get removeFromQueue => 'Видалити з черги';

  @override
  String get currentlyPlaying => 'Зараз грає';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пісні',
      one: 'одна пісня',
      zero: 'немає пісень',
    );
    return '$_temp0в черзі';
  }

  @override
  String moreAvailable(int num) {
    return 'Доступно ще $num';
  }

  @override
  String get nameMustNotBeEmpty => 'Ім\'я не повинно бути порожнім.';

  @override
  String get artistName => 'Ім\'я виконавця';

  @override
  String get likeCount => 'Кількість вподобань';

  @override
  String get playCount => 'Кількість відтворень';

  @override
  String get songTitle => 'Назва пісні';

  @override
  String get year => 'Рік';

  @override
  String get timeAdded => 'Час додавання';

  @override
  String get addToPlaylist => 'Додати до списку відтворення';

  @override
  String get removeFromPlaylist => 'Видалити зі списку відтворення';

  @override
  String get cancel => 'Скасувати';

  @override
  String get nextUp => 'Далі';

  @override
  String get previousSong => 'попередня';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'грали $count разів',
      one: 'грали один раз',
      zero: 'ще не грали',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => 'Завжди відтворювати попередню пісню';

  @override
  String get alwaysPlayNext => 'Завжди відтворювати наступну пісню';

  @override
  String get dontExcludeSong => 'Не виключати цю пісню.';

  @override
  String get excludeShuffleAllSong =>
      'Виключити під час перемішування всіх пісень.';

  @override
  String get excludeShuffleSong => 'Виключити при перемішуванні.';

  @override
  String get alwaysExcludeSong => 'Завжди виключати цю пісню.';

  @override
  String get welcomeToMucke => 'Ласкаво просимо до mucke!';

  @override
  String get setupLibrary => 'Налаштувати бібліотеку';

  @override
  String get setupLibraryDescription =>
      'Виберіть теки, розширення включених файлів тощо.';

  @override
  String get importData => 'Імпорт даних';

  @override
  String get importDataDescription =>
      'Імпортуйте дані з попереднього встановлення mucke.';

  @override
  String get yourLibrary => 'Ваша бібліотека:';

  @override
  String get scan => 'Сканувати';

  @override
  String get noFoldersSelected => 'Поки що не вибрано жодної теки.';

  @override
  String get addFolder => 'Додати теку';

  @override
  String get availableFromImport => 'Доступно з імпортованих даних:';

  @override
  String get use => 'Використовувати';

  @override
  String get reset => 'Скинути';

  @override
  String get blockedFilesDescription =>
      'Заблоковані файли з імпортованих даних. Тільки точні збіги будуть виключені зі сканування бібліотеки. Додаткові файли можна заблокувати пізніше в застосунку.';

  @override
  String get importLibData => 'Імпорт даних бібліотеки';

  @override
  String get songMetaData => 'Метадані пісні';

  @override
  String metaDataAvailable(int num) {
    return 'Доступні метадані для $num пісень';
  }

  @override
  String get metaDataDescription => 'Імпорт лайків, блоків і т.д.';

  @override
  String get imported => 'Імпортовано';

  @override
  String get importVerb => 'Імпортувати';

  @override
  String get miscellaneous => 'Різне';

  @override
  String get exportData => 'Експорт даних';

  @override
  String get exportDescription =>
      'Виберіть дані, які ви хочете експортувати. За замовчуванням експортується все. Під час експорту ви можете вибрати теку для збереження файлу.';

  @override
  String get songsAlbumsArtists => 'Пісні, альбоми та виконавці';

  @override
  String get librarySettings => 'Налаштування бібліотеки';

  @override
  String dataExportedTo(String path) {
    return 'Дані експортовано в:\n$path';
  }

  @override
  String get dataExportFailed => 'Не вдалося експортувати дані!';

  @override
  String get yourPlaylists => 'Ваші списки відтворення';

  @override
  String get systemSettings => 'Системні налаштування';

  @override
  String get batteryExplanation =>
      'Починаючи з Android 12, оптимізація заряду акумулятора спричиняє помилку сповіщення після втрати фокусу звуку, наприклад, при отриманні дзвінка. Вимкнення оптимізації для mucke вирішує цю проблему.';

  @override
  String get openBattery => 'Відкрити налаштування батареї';

  @override
  String get disableBattery =>
      'Вимкніть оптимізацію для mucke, щоб вирішити проблеми зі сповіщеннями.';

  @override
  String get disabledBattery => 'Оптимізацію батареї вимкнено.';

  @override
  String get manageExternalExplanation =>
      'Надання цього дозволу може значно покращити швидкість сканування бібліотеки. Це не змінює поведінку застосунку.';

  @override
  String get grantManagePermission =>
      'Надати дозвіл на управління всіма файлами.';

  @override
  String get managePermissionSubtitle =>
      'Скасування дозволу призведе до перезавантаження застосунку.';

  @override
  String get favorites => 'Улюблене';

  @override
  String get favoritesDesc => 'Містить усі пісні, які вам подобаються.';

  @override
  String get newlyAdded => 'Нещодавно додано';

  @override
  String get newlyAddedDesc => 'Містить 100 пісень, доданих останніми.';

  @override
  String get back => 'Назад';

  @override
  String get next => 'Далі';

  @override
  String get finish => 'Кінець';

  @override
  String get errorReadData => 'Помилка читання файлу даних.';

  @override
  String get createSmartlists => 'Створити розумні списки';

  @override
  String get createSmartlistsDesc =>
      'Створюйте запропоновані розумні списки, щоб покращити свій досвід прослуховування. Ці списки можна налаштувати пізніше.';

  @override
  String get create => 'Створити';

  @override
  String get created => 'Створено';
}
