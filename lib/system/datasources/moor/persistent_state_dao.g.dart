// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_state_dao.dart';

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$PersistentStateDaoMixin on DatabaseAccessor<MoorDatabase> {
  $SongsTable get songs => attachedDatabase.songs;
  $QueueEntriesTable get queueEntries => attachedDatabase.queueEntries;
  $OriginalSongEntriesTable get originalSongEntries =>
      attachedDatabase.originalSongEntries;
  $AddedSongEntriesTable get addedSongEntries =>
      attachedDatabase.addedSongEntries;
  $PersistentIndexTable get persistentIndex => attachedDatabase.persistentIndex;
  $PersistentShuffleModeTable get persistentShuffleMode =>
      attachedDatabase.persistentShuffleMode;
  $PersistentLoopModeTable get persistentLoopMode =>
      attachedDatabase.persistentLoopMode;
}
