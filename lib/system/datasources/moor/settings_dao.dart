import 'package:moor/moor.dart';

import '../../../constants.dart';
import '../moor_database.dart';
import '../settings_data_source.dart';

part 'settings_dao.g.dart';

@UseDao(tables: [LibraryFolders, KeyValueEntries])
class SettingsDao extends DatabaseAccessor<MoorDatabase>
    with _$SettingsDaoMixin
    implements SettingsDataSource {
  SettingsDao(MoorDatabase attachedDatabase) : super(attachedDatabase);

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
  Stream<bool> get isBlockSkippedSongsEnabled {
    return (select(keyValueEntries)..where((tbl) => tbl.key.equals(SETTING_EXCLUDE_SKIPPED_SONGS)))
        .watchSingle()
        .map((entry) => entry.value == 'true');
  }

  @override
  Stream<int> get blockSkippedSongsThreshold {
    return (select(keyValueEntries)..where((tbl) => tbl.key.equals(SETTING_SKIP_THRESHOLD)))
        .watchSingle()
        .map((entry) => int.parse(entry.value));
  }

  @override
  Future<void> setBlockSkippedSongsThreshold(int threshold) async {
    (update(keyValueEntries)..where((tbl) => tbl.key.equals(SETTING_SKIP_THRESHOLD)))
        .write(KeyValueEntriesCompanion(value: Value(threshold.toString())));
  }

  @override
  Future<void> setBlockSkippedSongs(bool enabled) async {
    (update(keyValueEntries)..where((tbl) => tbl.key.equals(SETTING_EXCLUDE_SKIPPED_SONGS)))
        .write(KeyValueEntriesCompanion(value: Value(enabled.toString())));
  }
}
