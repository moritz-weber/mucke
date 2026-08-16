// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class L10nTr extends L10n {
  L10nTr([String locale = 'tr']) : super(locale);

  @override
  String get home => 'Ana Sayfa';

  @override
  String get customizeHomePage => 'Ana Sayfayı Özelleştir';

  @override
  String get settings => 'Ayarlar';

  @override
  String get noSongsYet =>
      'Görünüşe göre kitaplığınızda hiçbir şarkı bulunmuyor: Ayarlara gidin, müzik klasörlerinizi ekleyin, ve kitaplığınızı güncelleyin.';

  @override
  String get library => 'Kitaplık';

  @override
  String get search => 'Ara';

  @override
  String get updateLibrary => 'Kütüphaneyi güncelle';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount sanatçı, $albumCount albüm, $songCount şarkı';
  }

  @override
  String get manageLibraryFolders => 'Kütüphane klasörlerini yönet';

  @override
  String get allowedFileExtensions => 'Geçerli dosya uzantıları';

  @override
  String get allowedFileExtensionsDescription =>
      'Virgülle ayrılmış geçerli dosya uzantıları listesi. Büyük-küçük karakter fark etmez. Ne olduğundan emin değilseniz varsayılanı kullanın.';

  @override
  String get manageBlockedFiles => 'Engellenmiş dosyaları yönet';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Şuanlık engellenen dosya sayısı: $blockedFiles';
  }

  @override
  String get playback => 'Oynatma';

  @override
  String get playAlbumsInOrder => 'Albümleri sırayla oynat';

  @override
  String get playAlbumsInOrderDescription =>
      'Bir albümdeki şarkıya tıkladığınızda, şarkılar önceki oynatma modunu korumak yerine sırayla oynatılır.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Şarkılar %$percentage oynatılınca oynatıldı sayılsın';
  }

  @override
  String get libraryFolders => 'Kitaplık Klasörleri';

  @override
  String get blockedFiles => 'Engellenen Klasörler';

  @override
  String get homeCustomization => 'Ana Sayfa Özelleştirme';

  @override
  String get albumOfTheDay => 'Günün Albümü';

  @override
  String get artistOfTheDay => 'Günün Sanatçısı';

  @override
  String get shuffleAll => 'Tümünü Karıştır';

  @override
  String get history => 'Geçmiş';

  @override
  String get addWidgetToHome => 'Ana Sayfanıza Bir Widget Ekleyin';

  @override
  String get noPlaylistsYet =>
      'Henüz bir oynatma listesi bulunmuyor. Kitaplıkta ekleyebilirsiniz.';

  @override
  String get lastPlayed => 'Son oynatılan';

  @override
  String get noHistoryYet =>
      'Burada henüz görülecek bir şey yok. Biir şeyler oynatın.';

  @override
  String get allSongs => 'Tüm Şarkılar';

  @override
  String get song => 'Şarkı';

  @override
  String get songs => 'Şarkılar';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '${count}songs',
      one: 'one song',
      zero: 'no songs',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Albüm';

  @override
  String get albums => 'Albümler';

  @override
  String get artist => 'Sanatçı';

  @override
  String get artists => 'Sanatçılar';

  @override
  String get playlist => 'Oynatma Listesi';

  @override
  String get playlists => 'Oynatma Listeleri';

  @override
  String get smartlist => 'Akıllı liste';

  @override
  String get smartlists => 'Akıllı listeler';

  @override
  String get noShuffle => 'Yok (mevcut karışık moda devam et)';

  @override
  String get normalMode => 'Normal mod';

  @override
  String get shuffleMode => 'Karma Mod';

  @override
  String get favShuffleMode => 'Favori Karma Mod';

  @override
  String get playlistNormalMode => 'Play from the top';

  @override
  String get playlistShuffleMode => 'Start shuffle playback';

  @override
  String get playlistFavShuffleMode => 'Start favorite shuffle playback';

  @override
  String get name => 'Ad';

  @override
  String get sortingFilterSettings => 'Sıralama ve Filtre Ayarları';

  @override
  String get maxNumberEntries => 'Maksimum girdi sayısı';

  @override
  String get creationDate => 'Oluşturma Tarihi';

  @override
  String get changeDate => 'Değişiklik Tarihi';

  @override
  String get lastTimePlayed => 'Son Oynatılma Zamanı';

  @override
  String get ascending => 'Artan';

  @override
  String get descending => 'Azalan';

  @override
  String get both => 'Her ikisi';

  @override
  String get playlistsOnly => 'Yalnızca Oynatma Listeleri';

  @override
  String get smartlistsOnly => 'Yalnızca Akıllı Listeler';

  @override
  String get displaySettings => 'Görüntü ayarları';

  @override
  String get addSmartlist => 'Akıllı Liste Ekle';

  @override
  String get addPlaylist => 'Oynatma listesi Ekle';

  @override
  String get createPlaylist => 'Oynatma listesi oluştur';

  @override
  String get editPlaylist => 'Oynatma listesi düzenle';

  @override
  String get customizeCover => 'Kapağı Özelleştir';

  @override
  String get playbackMode => 'Oynatma Modu';

  @override
  String get excludeAllSongs =>
      'Hariçlik için seçilen bütün şarkıları hariç tut.';

  @override
  String get excludeInShuffle =>
      'Karışık modda hariç tutulmak üzere işaretlenmiş şarkıları hariç tutun.';

  @override
  String get excludeAlways =>
      'Yalnızca Her zaman hariç tut olarak işaretlenmiş şarkıları hariç tut.';

  @override
  String get dontExclude => 'Hiçbir şarkıyı hariç tutma.';

  @override
  String get filterSettings => 'Filtreleme Ayarları';

  @override
  String filterLikes(int min, int max) {
    return '$min ve $max arası beğeniler';
  }

  @override
  String get minPlayCount => 'Minimum oynatma sayısı';

  @override
  String get maxPlayCount => 'Maksimum oynatma sayısı';

  @override
  String get minYear => 'Minimum yıl';

  @override
  String get maxYear => 'Maksimum yıl';

  @override
  String selectArtistsExclude(int num) {
    return 'Hariç tutulacak sanatçıları seçin: $num seçili.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Eklenecek sanatçıları seçin: $num seçili.';
  }

  @override
  String get includeAllArtists =>
      'Hiçbiri seçilmezse tüm sanatçıları dahil edin.';

  @override
  String get excludeArtists => 'Seçilen sanatçıları hariç tut';

  @override
  String get limitSongs => 'Şarkı sayısını sınırla';

  @override
  String get orderSettings => 'Sıralama Ayarları';

  @override
  String get orderSettingsDescription =>
      'Öncelikleri değiştirmek için seçenekleri yeniden sıralayın.';

  @override
  String get createSmartlist => 'Akıllı Liste Oluştur';

  @override
  String get editSmartlist => 'Akıllı Listeyi Düzenle';

  @override
  String get play => 'Oynat';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count şarkı seçildi',
      one: 'bir şarkı seçildi',
      zero: 'şarkı seçilmedi',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Sonrakini çal';

  @override
  String get appendToQueued => 'Manuel olarak sıraya alınmış şarkılara ekleme';

  @override
  String get addToQueue => 'Kuyruğa ekle';

  @override
  String get disc => 'Disk';

  @override
  String get blockFromLibrary => 'Kitaplıktan kaldır ve engelle';

  @override
  String get highlights => 'Öne Çıkanlar';

  @override
  String get shuffle => 'Karma et';

  @override
  String get selectArtists => 'Sanatçıları Seç';

  @override
  String get removeFromQueue => 'Kuyruktan kaldır';

  @override
  String get currentlyPlaying => 'Şuanda oynatılan';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count şarkı',
      one: 'bir şarkı',
      zero: 'şarkı yok',
    );
    return 'Kuyrukta $_temp0';
  }

  @override
  String moreAvailable(int num) {
    return '$num tane daha mevcut';
  }

  @override
  String get nameMustNotBeEmpty => 'Ad boş olmamalıdır.';

  @override
  String get artistName => 'Sanatçı adı';

  @override
  String get likeCount => 'Sayımı beğen';

  @override
  String get playCount => 'Oynatma sayısı';

  @override
  String get songTitle => 'Şarkı adı';

  @override
  String get year => 'Yıl';

  @override
  String get timeAdded => 'Zaman eklendi';

  @override
  String get addToPlaylist => 'Oynatma listesine ekle';

  @override
  String get removeFromPlaylist => 'Oynatma listesinden kaldır';

  @override
  String get cancel => 'İptal';

  @override
  String get nextUp => 'Sonraki';

  @override
  String get previousSong => 'öncesi';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count defa oynatıldı',
      one: 'bir defa oynatıldı',
      zero: 'henüz oynatılmadı',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => 'Her zaman önceki şarkıyı daha önce çal';

  @override
  String get alwaysPlayNext => 'Her zaman sonraki şarkıyı sonra çal';

  @override
  String get dontExcludeSong => 'Bu şarkıyı hariç tutmayın.';

  @override
  String get excludeShuffleAllSong =>
      'Tüm şarkıları karıştırırken hariç tutun.';

  @override
  String get excludeShuffleSong => 'Karıştırırken hariç tutun.';

  @override
  String get alwaysExcludeSong => 'Bu şarkıyı her zaman hariç tut.';

  @override
  String get welcomeToMucke => 'Mucke\'ye hoşgeldiniz!';

  @override
  String get setupLibrary => 'Kitaplığı Kur';

  @override
  String get setupLibraryDescription =>
      'Klasörleri, dahil edilen dosya uzantılarını vb. seçin.';

  @override
  String get importData => 'Verileri içe aktar';

  @override
  String get importDataDescription =>
      'Verilerinizi önceki bir mucke kurulumundan içe aktarın.';

  @override
  String get yourLibrary => 'Kütüphaneniz:';

  @override
  String get scan => 'Tara';

  @override
  String get noFoldersSelected => 'Şu ana kadar hiçbir klasör seçilmedi.';

  @override
  String get addFolder => 'Klasörü eklemek';

  @override
  String get availableFromImport => 'İçe aktarılan verilerden edinilebilir:';

  @override
  String get use => 'Kullanmak';

  @override
  String get reset => 'Sıfırla';

  @override
  String get blockedFilesDescription =>
      'İçe aktarılan verilerdeki dosyalar engellendi. Yalnızca tam eşleşmeler kitaplık taramasının dışında tutulacaktır. Ek dosyalar daha sonra uygulamada engellenebilir.';

  @override
  String get importLibData => 'Kütüphane Verilerini İçe Aktar';

  @override
  String get songMetaData => 'Şarkı Meta Verileri';

  @override
  String metaDataAvailable(int num) {
    return '$num şarkı için meta veriler mevcut';
  }

  @override
  String get metaDataDescription => 'Beğenileri, blokları vb. içe aktarın.';

  @override
  String get imported => 'aktarılan';

  @override
  String get importVerb => 'İçe aktar';

  @override
  String get miscellaneous => 'Çeşitli';

  @override
  String get exportData => 'Verileri dışa aktar';

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
      'Dışa aktarmak istediğiniz verileri seçin. Varsayılan olarak her şey dışa aktarılır. Dışa aktarırken, saklanacak dosya için bir klasör seçebilirsiniz.';

  @override
  String get songsAlbumsArtists => 'Şarkılar, Albümler ve Sanatçılar';

  @override
  String get librarySettings => 'Kütüphane Ayarları';

  @override
  String dataExportedTo(String path) {
    return 'Veriler şuraya aktarıldı:\n$path';
  }

  @override
  String get dataExportFailed => 'Veri aktarımı başarısız oldu!';

  @override
  String get yourPlaylists => 'Oynatma listeleriniz';

  @override
  String get systemSettings => 'Sistem ayarları';

  @override
  String get batteryExplanation =>
      'Android 12\'den başlayarak, pil optimizasyonu, örneğin bir çağrı alırken ses odağını kaybettikten sonra bildirimde hataya neden oluyor. Mucke için optimizasyonun devre dışı bırakılması bu sorunu çözer.';

  @override
  String get openBattery => 'Pil ayarlarını aç';

  @override
  String get disableBattery =>
      'Mucke için pil iyileştirmesini devre dışı bırak.';

  @override
  String get disableBatteryDescription =>
      'Pil iyileştirmesini devre dışı bırakmak, olası bildirim sorunlarını çözebilir.';

  @override
  String get disabledBattery => 'Pil optimizasyonu devre dışı.';

  @override
  String get manageExternalExplanation =>
      'Bu iznin verilmesi kitaplık taramalarının hızını önemli ölçüde artırabilir. Aksi takdirde uygulamanın davranışını değiştirmez.';

  @override
  String get grantManagePermission => 'Tüm dosyaları yönetme izni verin.';

  @override
  String get managePermissionSubtitle =>
      'İznin iptal edilmesi uygulamanın yeniden başlatılmasıyla sonuçlanacaktır.';

  @override
  String get favorites => 'Favoriler';

  @override
  String get favoritesDesc => 'Beğendiğiniz tüm şarkıları içerir.';

  @override
  String get newlyAdded => 'Yeni eklenmiş';

  @override
  String get newlyAddedDesc => 'En son eklenen 100 şarkıyı içerir.';

  @override
  String get back => 'Geri';

  @override
  String get next => 'İleri';

  @override
  String get finish => 'Bitti';

  @override
  String get errorReadData => 'Veri dosyası okunurken hata oluştu.';

  @override
  String get createSmartlists => 'Akıllı Listeler Oluşturun';

  @override
  String get createSmartlistsDesc =>
      'Dinleme deneyiminizi geliştirmek için önerilen akıllı listeler oluşturun. Bu listeleri daha sonra özelleştirebilirsiniz.';

  @override
  String get create => 'Oluştur';

  @override
  String get created => 'Oluşturuldu';
}
