// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_dao.dart';

// ignore_for_file: type=lint
mixin _$PlaylistDaoMixin on DatabaseAccessor<MainDatabase> {
  $AlbumsTable get albums => attachedDatabase.albums;
  $ArtistsTable get artists => attachedDatabase.artists;
  $SongsTable get songs => attachedDatabase.songs;
  $PlaylistsTable get playlists => attachedDatabase.playlists;
  $PlaylistEntriesTable get playlistEntries => attachedDatabase.playlistEntries;
  $SmartListsTable get smartLists => attachedDatabase.smartLists;
  $SmartListArtistsTable get smartListArtists =>
      attachedDatabase.smartListArtists;
  $HistoryEntriesTable get historyEntries => attachedDatabase.historyEntries;
  PlaylistDaoManager get managers => PlaylistDaoManager(this);
}

class PlaylistDaoManager {
  final _$PlaylistDaoMixin _db;
  PlaylistDaoManager(this._db);
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
  $$HistoryEntriesTableTableManager get historyEntries =>
      $$HistoryEntriesTableTableManager(
          _db.attachedDatabase, _db.historyEntries);
}
