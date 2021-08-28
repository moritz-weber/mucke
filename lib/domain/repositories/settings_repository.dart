import '../entities/smart_list.dart';

abstract class SettingsRepository {
  Future<void> addLibraryFolder(String? path);

  Stream<List<SmartList>> get smartListsStream;
  Future<void> insertSmartList(SmartList smartList);
  Future<void> updateSmartList(SmartList smartList);
  Future<void> removeSmartList(SmartList smartList);
}
