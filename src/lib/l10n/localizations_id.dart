// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class L10nId extends L10n {
  L10nId([String locale = 'id']) : super(locale);

  @override
  String get home => 'Beranda';

  @override
  String get customizeHomePage => 'Kustomisasi beranda';

  @override
  String get settings => 'Pengaturan';

  @override
  String get noSongsYet =>
      'Sepertinya tidak ada lagu di library kamu; coba ke pengaturan, tambahkan folder musik, kemudian perbarui library.';

  @override
  String get library => 'Library';

  @override
  String get search => 'Cari';

  @override
  String get updateLibrary => 'Perbarui library';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount artis, $albumCount album, $songCount lagu';
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
  String get manageLibraryFolders => 'Atur folder library';

  @override
  String get allowedFileExtensions => 'Ekstensi file yang diperbolehkan';

  @override
  String get allowedFileExtensionsDescription =>
      'Daftar ekstensi file boleh dipisahkan dengan koma. Huruf kapital atau tidak bukanlah masalah. Jika ragu, jangan diubah.';

  @override
  String get manageBlockedFiles => 'Atur file yang diblokir';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Jumlah file yang terblokir: $blockedFiles';
  }

  @override
  String get playback => 'Pemutaran';

  @override
  String get playAlbumsInOrder => 'Putar album sesuai urutan';

  @override
  String get playAlbumsInOrderDescription =>
      'Ketika mengklik lagu pada sebuah album lagu tersebut akan dimainkan sesuai urutan dibanding mengikuti pemutaran sebelumnya.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Tandai lagu sudah diputar setelah: $percentage%';
  }

  @override
  String get libraryFolders => 'Folder library';

  @override
  String get blockedFiles => 'File terblokir';

  @override
  String get homeCustomization => 'Kustomisasi beranda';

  @override
  String get albumOfTheDay => 'Album pada hari ini';

  @override
  String get artistOfTheDay => 'Artis pada hari ini';

  @override
  String get shuffleAll => 'Acak semua';

  @override
  String get history => 'Riwayat';

  @override
  String get addWidgetToHome => 'Tambahkan widget pada beranda perangkat kamu';

  @override
  String get noPlaylistsYet =>
      'Tidak ada playlist. Kamu bisa menambahkan playlist di library.';

  @override
  String get lastPlayed => 'Terakhir diputar';

  @override
  String get noHistoryYet => 'Tidak ada apapun. Coba putar lagu dahulu.';

  @override
  String get allSongs => 'Semua lagu';

  @override
  String get song => 'Lagu';

  @override
  String get songs => 'Lagu';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lagu',
      one: 'satu lagu',
      zero: 'tidak ada lagu',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Album';

  @override
  String get albums => 'Album';

  @override
  String get artist => 'Artis';

  @override
  String get artists => 'Artis';

  @override
  String get playlist => 'Playlist';

  @override
  String get playlists => 'Playlist';

  @override
  String get smartlist => 'Smartlist';

  @override
  String get smartlists => 'Smartlist';

  @override
  String get noShuffle => 'Tidak ada (biarkan mode acak saat ini)';

  @override
  String get normalMode => 'Mode normal';

  @override
  String get shuffleMode => 'Mode acak';

  @override
  String get favShuffleMode => 'Mode acak favorit';

  @override
  String get playlistNormalMode => 'Play from the top';

  @override
  String get playlistShuffleMode => 'Start shuffle playback';

  @override
  String get playlistFavShuffleMode => 'Start favorite shuffle playback';

  @override
  String get name => 'Nama';

  @override
  String get sortingFilterSettings => 'Pengaturan sortir dan penyaringan';

  @override
  String get maxNumberEntries => 'Jumlah entri maksimal';

  @override
  String get creationDate => 'Tanggal dibuat';

  @override
  String get changeDate => 'Tanggal dirubah';

  @override
  String get lastTimePlayed => 'Terakhir dimainkan pada';

  @override
  String get ascending => 'Menanjak';

  @override
  String get descending => 'Menurun';

  @override
  String get both => 'Keduanya';

  @override
  String get playlistsOnly => 'Hanya playlist';

  @override
  String get smartlistsOnly => 'Hanya smartlist';

  @override
  String get displaySettings => 'Pengaturan display';

  @override
  String get addSmartlist => 'Tambah smartlist';

  @override
  String get addPlaylist => 'Tambah playlist';

  @override
  String get createPlaylist => 'Buat playlist';

  @override
  String get editPlaylist => 'Ubah playlist';

  @override
  String get customizeCover => 'Kustom cover';

  @override
  String get playbackMode => 'Mode pemutaran';

  @override
  String get excludeAllSongs => 'Mengecualikan semua lagu yang ditandai.';

  @override
  String get excludeInShuffle =>
      'Mengecualikan lagu yang ditandai pada mode acak.';

  @override
  String get excludeAlways =>
      'Mengecualikan lagu yang ditandai sebagai selalu dikecualikan.';

  @override
  String get dontExclude => 'Tidak ada lagu yang dikecualikan.';

  @override
  String get filterSettings => 'Pengaturan penyaringan';

  @override
  String filterLikes(int min, int max) {
    return 'Suka berdasarkan $min dan $max';
  }

  @override
  String get minPlayCount => 'Minimal jumlah pemutaran';

  @override
  String get maxPlayCount => 'Maksimal jumlah pemutaran';

  @override
  String get minYear => 'Minimal tahun';

  @override
  String get maxYear => 'Maksimal tahun';

  @override
  String selectArtistsExclude(int num) {
    return 'Pilih artis untuk dikecualikan: $num terpilih.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Pilih artis untuk dimasukkan: $num terpilih.';
  }

  @override
  String get includeAllArtists =>
      'Masukkan semua artis jika tidak ada yang terpilih.';

  @override
  String get excludeArtists => 'Kecualikan semua artis terpilih';

  @override
  String get limitSongs => 'Batas jumlah lagu';

  @override
  String get orderSettings => 'Pengaturan urutan';

  @override
  String get orderSettingsDescription =>
      'Ubah pengaturan untuk mengganti prioritas.';

  @override
  String get createSmartlist => 'Buat smartlist';

  @override
  String get editSmartlist => 'Ubah smartlist';

  @override
  String get play => 'Putar';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lagu terpilih',
      one: 'satu lagu terpilih',
      zero: 'tidak ada lagu terpilih',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Putar selanjutnya';

  @override
  String get appendToQueued => 'Tambahkan manual ke antrean lagu';

  @override
  String get addToQueue => 'Tambah ke antrean';

  @override
  String get disc => 'Kaset';

  @override
  String get blockFromLibrary => 'Hapus dan blokir dari library';

  @override
  String get highlights => 'Sorotan';

  @override
  String get shuffle => 'Acak';

  @override
  String get selectArtists => 'Pilih artis';

  @override
  String get removeFromQueue => 'Hapus dari antrean';

  @override
  String get currentlyPlaying => 'Saat ini diputar';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lagu',
      one: 'satu lagu',
      zero: 'tidak ada lagu',
    );
    return '$_temp0 di antrean';
  }

  @override
  String moreAvailable(int num) {
    return '$num lebih tersedia';
  }

  @override
  String get nameMustNotBeEmpty => 'Nama tidak boleh kosong.';

  @override
  String get artistName => 'Nama artis';

  @override
  String get likeCount => 'Jumlah suka';

  @override
  String get playCount => 'Jumlah putar';

  @override
  String get songTitle => 'Judul lagu';

  @override
  String get year => 'Tahun';

  @override
  String get timeAdded => 'Waktu ditambahkan';

  @override
  String get addToPlaylist => 'Tambah ke playlist';

  @override
  String get removeFromPlaylist => 'Hapus dari playlist';

  @override
  String get cancel => 'Batal';

  @override
  String get nextUp => 'Selanjutnya';

  @override
  String get previousSong => 'Sebelumnya';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'diputar $count kali',
      one: 'diputar sekali',
      zero: 'belum pernah diputar',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => 'Selalu putar lagu sebelumnya';

  @override
  String get alwaysPlayNext => 'Selalu putar lagu selanjutnya';

  @override
  String get dontExcludeSong => 'Jangan kecualikan lagu ini.';

  @override
  String get excludeShuffleAllSong => 'Kecualikan ketika mengacak semua lagu.';

  @override
  String get excludeShuffleSong => 'Kecualikan ketika mengacak.';

  @override
  String get alwaysExcludeSong => 'Selalu kecualikan lagu ini.';

  @override
  String get welcomeToMucke => 'Selamat datang di mucke!';

  @override
  String get setupLibrary => 'Mempersiapkan library';

  @override
  String get setupLibraryDescription =>
      'Pilih folder, masukkan semua ekstensi file, dll.';

  @override
  String get importData => 'Impor data';

  @override
  String get importDataDescription =>
      'Impor data kamu dari instalasi mucke sebelumnya.';

  @override
  String get yourLibrary => 'Library kamu:';

  @override
  String get scan => 'Pindai';

  @override
  String get noFoldersSelected => 'Tidak ada folder terpilih saat ini.';

  @override
  String get addFolder => 'Tambah folder';

  @override
  String get availableFromImport => 'Tersedia dari data terimpor:';

  @override
  String get use => 'Gunakan';

  @override
  String get reset => 'Mulai ulang';

  @override
  String get blockedFilesDescription =>
      'File terblokir dari data yang terimpor. Hanya file yang benar-benar sesuai yang akan dikecualikan. File yang lain bisa diblokir nanti di aplikasi.';

  @override
  String get importLibData => 'Impor data library';

  @override
  String get songMetaData => 'Metadata lagu';

  @override
  String metaDataAvailable(int num) {
    return 'Metadata untuk $num lagu tersedia';
  }

  @override
  String get metaDataDescription => 'Impor suka, blokir, dll.';

  @override
  String get imported => 'Terimpor';

  @override
  String get importVerb => 'Impor';

  @override
  String get miscellaneous => 'Lain-lain';

  @override
  String get exportData => 'Ekspor data';

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
      'Pilih data yang akan diekspor. Secara bawaan semuanya akan diekspor. Ketika mengekspor, kamu bisa memilih sebuah folder untuk file yang akan disortir.';

  @override
  String get songsAlbumsArtists => 'Lagu, album, dan artis';

  @override
  String get librarySettings => 'Pengaturan library';

  @override
  String dataExportedTo(String path) {
    return 'Data diekspor ke:\n$path';
  }

  @override
  String get dataExportFailed => 'Gagal mengekspor data!';

  @override
  String get yourPlaylists => 'Playlist kamu';

  @override
  String get systemSettings => 'Pengaturan sistem';

  @override
  String get batteryExplanation =>
      'Dari android 12 keatas, optimasi baterai akan mengakibatkan eror pada notifikasi setelah audio terganggu, contohnya ketika menerima telepon. Matikan optimasi untuk mucke akan memperbaiki masalah ini.';

  @override
  String get openBattery => 'Buka pengaturan baterai';

  @override
  String get disableBattery =>
      'Matikan optimasi untuk mucke untuk memperbaiki masalah notifikasi.';

  @override
  String get disableBatteryDescription =>
      'Disabling battery optimization can solve potential notification issues.';

  @override
  String get disabledBattery => 'Optimasi baterai dimatikan.';

  @override
  String get manageExternalExplanation =>
      'Memberi perijinan ini akan meningkatkan kecepatan pemindaian library. Dimatikanpun tidak berdampak apapun pada penggunaan aplikasi.';

  @override
  String get grantManagePermission =>
      'Berikan ijin untuk mengatur seluruh file.';

  @override
  String get managePermissionSubtitle =>
      'Mencabut ijin akan merestart aplikasi.';

  @override
  String get favorites => 'Favorit';

  @override
  String get favoritesDesc => 'Berisi semua lagu yang kamu sukai.';

  @override
  String get newlyAdded => 'Baru-baru ini ditambahkan';

  @override
  String get newlyAddedDesc => 'Berisi 100 lagu terakhir yang ditambahkan.';

  @override
  String get back => 'Kembali';

  @override
  String get next => 'Selanjutnya';

  @override
  String get finish => 'Selesai';

  @override
  String get errorReadData => 'Eror membaca data file .';

  @override
  String get createSmartlists => 'Buat smartlist';

  @override
  String get createSmartlistsDesc =>
      'Buat saran smartlist untuk meningkatkan pengalaman mendengarkan. Kamu bisa mengubah list ini nanti.';

  @override
  String get create => 'Buat';

  @override
  String get created => 'Dibuat';
}
