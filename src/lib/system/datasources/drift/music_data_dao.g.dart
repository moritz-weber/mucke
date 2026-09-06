// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_data_dao.dart';

// ignore_for_file: type=lint
mixin _$MusicDataDaoMixin on DatabaseAccessor<MainDatabase> {
  $AlbumsTable get albums => attachedDatabase.albums;
  $ArtistsTable get artists => attachedDatabase.artists;
  $SongsTable get songs => attachedDatabase.songs;
  $PlaylistsTable get playlists => attachedDatabase.playlists;
  $PlaylistEntriesTable get playlistEntries => attachedDatabase.playlistEntries;
  $KeyValueEntriesTable get keyValueEntries => attachedDatabase.keyValueEntries;
  $BlockedFilesTable get blockedFiles => attachedDatabase.blockedFiles;
  $HistoryEntriesTable get historyEntries => attachedDatabase.historyEntries;
  $SmartListArtistsTable get smartListArtists =>
      attachedDatabase.smartListArtists;
  MusicDataDaoManager get managers => MusicDataDaoManager(this);
}

class MusicDataDaoManager {
  final _$MusicDataDaoMixin _db;
  MusicDataDaoManager(this._db);
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
  $$KeyValueEntriesTableTableManager get keyValueEntries =>
      $$KeyValueEntriesTableTableManager(
          _db.attachedDatabase, _db.keyValueEntries);
  $$BlockedFilesTableTableManager get blockedFiles =>
      $$BlockedFilesTableTableManager(_db.attachedDatabase, _db.blockedFiles);
  $$HistoryEntriesTableTableManager get historyEntries =>
      $$HistoryEntriesTableTableManager(
          _db.attachedDatabase, _db.historyEntries);
  $$SmartListArtistsTableTableManager get smartListArtists =>
      $$SmartListArtistsTableTableManager(
          _db.attachedDatabase, _db.smartListArtists);
}
