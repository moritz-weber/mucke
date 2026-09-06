// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dao.dart';

// ignore_for_file: type=lint
mixin _$SettingsDaoMixin on DatabaseAccessor<MainDatabase> {
  $LibraryFoldersTable get libraryFolders => attachedDatabase.libraryFolders;
  $KeyValueEntriesTable get keyValueEntries => attachedDatabase.keyValueEntries;
  $BlockedFilesTable get blockedFiles => attachedDatabase.blockedFiles;
  SettingsDaoManager get managers => SettingsDaoManager(this);
}

class SettingsDaoManager {
  final _$SettingsDaoMixin _db;
  SettingsDaoManager(this._db);
  $$LibraryFoldersTableTableManager get libraryFolders =>
      $$LibraryFoldersTableTableManager(
          _db.attachedDatabase, _db.libraryFolders);
  $$KeyValueEntriesTableTableManager get keyValueEntries =>
      $$KeyValueEntriesTableTableManager(
          _db.attachedDatabase, _db.keyValueEntries);
  $$BlockedFilesTableTableManager get blockedFiles =>
      $$BlockedFilesTableTableManager(_db.attachedDatabase, _db.blockedFiles);
}
