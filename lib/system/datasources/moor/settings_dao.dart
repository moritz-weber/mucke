import 'package:moor/moor.dart';

import '../moor_database.dart';
import '../settings_data_source.dart';

part 'settings_dao.g.dart';

@UseDao(tables: [LibraryFolders, BlockSkippedSongs])
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
  Stream<bool> get isBlockSkippedSongsEnabled =>
      (select(blockSkippedSongs)..limit(1)).watchSingle().map((tbl) => tbl.enabled);

  @override
  Stream<int> get blockSkippedSongsThreshold =>
      (select(blockSkippedSongs)..limit(1)).watchSingle().map((tbl) => tbl.threshold);

  @override
  Future<void> setBlockSkippedSongsThreshold(int threshold) async {
    await update(blockSkippedSongs).write(BlockSkippedSongsCompanion(threshold: Value(threshold)));
  }

  @override
  Future<void> setBlockSkippedSongs(bool enabled) async {
    await update(blockSkippedSongs).write(BlockSkippedSongsCompanion(enabled: Value(enabled)));
  }
}
