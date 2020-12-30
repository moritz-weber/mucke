import 'package:moor/moor.dart';

import '../moor_database.dart';
import '../settings_data_source.dart';

part 'settings_dao.g.dart';

@UseDao(tables: [LibraryFolders])
class SettingsDao extends DatabaseAccessor<MoorDatabase>
    with _$SettingsDaoMixin
    implements SettingsDataSource {
  SettingsDao(MoorDatabase attachedDatabase) : super(attachedDatabase);

  @override
  Future<void> addLibraryFolder(String path) async {
    await into(libraryFolders).insert(LibraryFoldersCompanion(path: Value(path)));
  }

  @override
  Future<List<String>> getLibraryFolders() {
    return select(libraryFolders).get().then((value) => value.map((e) => e.path).toList());
  }
}
