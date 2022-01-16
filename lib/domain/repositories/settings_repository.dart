import 'package:rxdart/rxdart.dart';

abstract class SettingsInfoRepository {
  Stream<List<String>> get libraryFoldersStream;
  ValueStream<bool> get manageExternalStorageGranted;
}

abstract class SettingsRepository extends SettingsInfoRepository {
  Future<void> addLibraryFolder(String? path);
  Future<void> removeLibraryFolder(String? path);
  Future<void> setManageExternalStorageGranted(bool granted);
}
