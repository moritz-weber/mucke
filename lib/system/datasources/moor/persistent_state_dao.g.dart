// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_state_dao.dart';

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$PersistentStateDaoMixin on DatabaseAccessor<MoorDatabase> {
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
}
