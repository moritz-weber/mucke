import 'package:drift/drift.dart';

import '../../../constants.dart';
import '../drift_database.dart';
import '../settings_data_source.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [LibraryFolders, KeyValueEntries, BlockedFiles])
class SettingsDao extends DatabaseAccessor<MainDatabase>
    with _$SettingsDaoMixin
    implements SettingsDataSource {
  SettingsDao(MainDatabase attachedDatabase) : super(attachedDatabase);

  @override
  Stream<List<String>> get libraryFoldersStream =>
      select(libraryFolders).watch().map((value) => value.map((e) => e.path).toList());

  @override
  Future<void> removeLibraryFolder(String path) async {
    await (delete(libraryFolders)..where((tbl) => tbl.path.equals(path))).go();
  }

  @override
  Future<void> addLibraryFolder(String path) async {
    await into(libraryFolders).insert(LibraryFoldersCompanion(path: Value(path)));
  }

  @override
  Stream<String> get fileExtensionsStream =>
      (select(keyValueEntries)..where((tbl) => tbl.key.equals(SETTING_ALLOWED_EXTENSIONS)))
          .watchSingle()
          .map((event) => event.value);

  @override
  Future<void> setFileExtension(String extensions) async {
    print(extensions);
    await (update(keyValueEntries)..where((tbl) => tbl.key.equals(SETTING_ALLOWED_EXTENSIONS)))
        .write(KeyValueEntriesCompanion(value: Value(extensions)));
  }

  @override
  Stream<bool> get playAlbumsInOrderStream =>
      (select(keyValueEntries)..where((tbl) => tbl.key.equals(SETTING_PLAY_ALBUMS_IN_ORDER)))
          .watchSingle()
          .map((event) => event.value == 'true');

  @override
  Future<void> setPlayAlbumsInOrder(bool playInOrder) async {
    await (update(keyValueEntries)..where((tbl) => tbl.key.equals(SETTING_PLAY_ALBUMS_IN_ORDER)))
        .write(KeyValueEntriesCompanion(value: Value(playInOrder ? 'true' : 'false')));
  }

  @override
  Stream<int> get listenedPercentageStream =>
      (select(keyValueEntries)..where((tbl) => tbl.key.equals(LISTENED_PERCENTAGE)))
          .watchSingle()
          .map((event) => int.parse(event.value));

  @override
  Future<void> setListenedPercentage(int percentage) async {
    await (update(keyValueEntries)..where((tbl) => tbl.key.equals(LISTENED_PERCENTAGE)))
        .write(KeyValueEntriesCompanion(value: Value(percentage.toString())));
  }
}
