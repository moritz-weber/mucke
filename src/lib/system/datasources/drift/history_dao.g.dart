// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_dao.dart';

// ignore_for_file: type=lint
mixin _$HistoryDaoMixin on DatabaseAccessor<MainDatabase> {
  $HistoryEntriesTable get historyEntries => attachedDatabase.historyEntries;
  $AlbumsTable get albums => attachedDatabase.albums;
  $ArtistsTable get artists => attachedDatabase.artists;
  $PlaylistsTable get playlists => attachedDatabase.playlists;
  $SmartListsTable get smartLists => attachedDatabase.smartLists;
  $SmartListArtistsTable get smartListArtists =>
      attachedDatabase.smartListArtists;
  HistoryDaoManager get managers => HistoryDaoManager(this);
}

class HistoryDaoManager {
  final _$HistoryDaoMixin _db;
  HistoryDaoManager(this._db);
  $$HistoryEntriesTableTableManager get historyEntries =>
      $$HistoryEntriesTableTableManager(
          _db.attachedDatabase, _db.historyEntries);
  $$AlbumsTableTableManager get albums =>
      $$AlbumsTableTableManager(_db.attachedDatabase, _db.albums);
  $$ArtistsTableTableManager get artists =>
      $$ArtistsTableTableManager(_db.attachedDatabase, _db.artists);
  $$PlaylistsTableTableManager get playlists =>
      $$PlaylistsTableTableManager(_db.attachedDatabase, _db.playlists);
  $$SmartListsTableTableManager get smartLists =>
      $$SmartListsTableTableManager(_db.attachedDatabase, _db.smartLists);
  $$SmartListArtistsTableTableManager get smartListArtists =>
      $$SmartListArtistsTableTableManager(
          _db.attachedDatabase, _db.smartListArtists);
}
