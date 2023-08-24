import 'package:rxdart/rxdart.dart';

abstract class SettingsInfoRepository {
  Stream<List<String>> get libraryFoldersStream;
  ValueStream<String> get fileExtensionsStream;
  ValueStream<bool> get playAlbumsInOrderStream;
  ValueStream<int> get listenedPercentageStream;
  ValueStream<bool> get manageExternalStorageGranted;
}

abstract class SettingsRepository extends SettingsInfoRepository {
  Future<void> addLibraryFolder(String? path);
  Future<void> removeLibraryFolder(String? path);
  Future<void> setFileExtension(String extensions);
  Future<void> setPlayAlbumsInOrder(bool playInOrder);
  Future<void> setListenedPercentage(int percentage);
  Future<void> setManageExternalStorageGranted(bool granted);
}
