// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_state_dao.dart';

// ignore_for_file: type=lint
mixin _$PersistentStateDaoMixin on DatabaseAccessor<MainDatabase> {
  $AlbumsTable get albums => attachedDatabase.albums;
  $ArtistsTable get artists => attachedDatabase.artists;
  $SongsTable get songs => attachedDatabase.songs;
  $PlaylistsTable get playlists => attachedDatabase.playlists;
  $PlaylistEntriesTable get playlistEntries => attachedDatabase.playlistEntries;
  $SmartListsTable get smartLists => attachedDatabase.smartLists;
  $SmartListArtistsTable get smartListArtists =>
      attachedDatabase.smartListArtists;
  $QueueEntriesTable get queueEntries => attachedDatabase.queueEntries;
  $AvailableSongEntriesTable get availableSongEntries =>
      attachedDatabase.availableSongEntries;
  $KeyValueEntriesTable get keyValueEntries => attachedDatabase.keyValueEntries;
  PersistentStateDaoManager get managers => PersistentStateDaoManager(this);
}

class PersistentStateDaoManager {
  final _$PersistentStateDaoMixin _db;
  PersistentStateDaoManager(this._db);
  $$AlbumsTableTableManager get albums =>
      $$AlbumsTableTableManager(_db.attachedDatabase, _db.albums);
  $$ArtistsTableTableManager get artists =>
      $$ArtistsTableTableManager(_db.attachedDatabase, _db.artists);
  $$SongsTableTableManager get songs =>
      $$SongsTableTableManager(_db.attachedDatabase, _db.songs);
  $$PlaylistsTableTableManager get playlists =>
      $$PlaylistsTableTableManager(_db.attachedDatabase, _db.playlists);
  $$PlaylistEntriesTableTableManager get playlistEntries =>
      $$PlaylistEntriesTableTableManager(
          _db.attachedDatabase, _db.playlistEntries);
  $$SmartListsTableTableManager get smartLists =>
      $$SmartListsTableTableManager(_db.attachedDatabase, _db.smartLists);
  $$SmartListArtistsTableTableManager get smartListArtists =>
      $$SmartListArtistsTableTableManager(
          _db.attachedDatabase, _db.smartListArtists);
  $$QueueEntriesTableTableManager get queueEntries =>
      $$QueueEntriesTableTableManager(_db.attachedDatabase, _db.queueEntries);
  $$AvailableSongEntriesTableTableManager get availableSongEntries =>
      $$AvailableSongEntriesTableTableManager(
          _db.attachedDatabase, _db.availableSongEntries);
  $$KeyValueEntriesTableTableManager get keyValueEntries =>
      $$KeyValueEntriesTableTableManager(
          _db.attachedDatabase, _db.keyValueEntries);
}
