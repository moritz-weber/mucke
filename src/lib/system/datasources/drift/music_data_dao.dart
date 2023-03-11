import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';

import '../../../constants.dart';
import '../../../domain/entities/playable.dart';
import '../../models/album_model.dart';
import '../../models/artist_model.dart';
import '../../models/song_model.dart';
import '../drift_database.dart';
import '../music_data_source_contract.dart';

part 'music_data_dao.g.dart';

@DriftAccessor(tables: [
  Albums,
  Artists,
  Songs,
  Playlists,
  PlaylistEntries,
  KeyValueEntries,
  BlockedFiles,
  HistoryEntries,
  SmartListArtists
])
class MusicDataDao extends DatabaseAccessor<MainDatabase>
    with _$MusicDataDaoMixin
    implements MusicDataSource {
  MusicDataDao(MainDatabase db) : super(db);

  @override
  Stream<List<SongModel>> get songStream {
    return (select(songs)..orderBy([(t) => OrderingTerm(expression: t.title)])).watch().map(
        (driftSongList) =>
            driftSongList.map((driftSong) => SongModel.fromDrift(driftSong)).toList());
  }

  @override
  Stream<List<AlbumModel>> get albumStream {
    return (select(albums)..orderBy([(t) => OrderingTerm(expression: t.title)])).watch().map(
        (driftAlbumList) =>
            driftAlbumList.map((driftAlbum) => AlbumModel.fromDrift(driftAlbum)).toList());
  }

  @override
  Stream<List<ArtistModel>> get artistStream {
    return (select(artists)..orderBy([(t) => OrderingTerm(expression: t.name)])).watch().map(
        (driftArtistList) =>
            driftArtistList.map((driftArtist) => ArtistModel.fromDrift(driftArtist)).toList());
  }

  @override
  Stream<List<SongModel>> getAlbumSongStream(AlbumModel album) {
    return (select(songs)
          ..where((tbl) => tbl.albumId.equals(album.id))
          ..orderBy([
            (t) => OrderingTerm(expression: t.discNumber),
            (t) => OrderingTerm(expression: t.trackNumber),
            (t) => OrderingTerm(expression: t.title),
          ]))
        .watch()
        .distinct(const ListEquality().equals)
        .map((driftSongList) =>
            driftSongList.map((driftSong) => SongModel.fromDrift(driftSong)).toList());
  }

  @override
  Stream<List<AlbumModel>> getArtistAlbumStream(ArtistModel artist) {
    return (select(albums)..where((tbl) => tbl.artist.equals(artist.name)))
        .watch()
        .distinct(const ListEquality().equals)
        .map((driftAlbumList) {
      return driftAlbumList.map((driftAlbum) => AlbumModel.fromDrift(driftAlbum)).toList();
    });
  }

  @override
  Stream<List<SongModel>> getArtistSongStream(ArtistModel artist) {
    return (select(albums)..where((tbl) => tbl.artist.equals(artist.name)))
        .join([innerJoin(songs, songs.albumId.equalsExp(albums.id))])
        .map((row) => row.readTable(songs))
        .watch()
        .distinct(const ListEquality().equals)
        .map(
          (driftSongList) =>
              driftSongList.map((driftSong) => SongModel.fromDrift(driftSong)).toList(),
        );
  }

  @override
  Future<SongModel?> getSongByPath(String path) async {
    return (select(songs)..where((t) => t.path.equals(path))).getSingleOrNull().then(
          (driftSong) => driftSong == null ? null : SongModel.fromDrift(driftSong),
        );
  }

  @override
  Future<void> deleteAllArtists() async {
    delete(artists).go();
  }

  @override
  Future<void> deleteAllAlbums() async {
    delete(albums).go();
  }

  @override
  Future<void> insertSongs(List<SongModel> songModels) async {
    final List<SongModel> deletedSongs = [];

    transaction(() async {
      await update(songs).write(const SongsCompanion(present: Value(false)));

      await batch((batch) {
        batch.insertAllOnConflictUpdate(
          songs,
          songModels.map((e) => e.toDriftInsert()).toList(),
        );
      });
    });

    deletedSongs.addAll(await (select(songs)..where((tbl) => tbl.present.equals(false))).get().then(
        (driftSongList) =>
            driftSongList.map((driftSong) => SongModel.fromDrift(driftSong)).toList()));

    await (delete(songs)..where((tbl) => tbl.present.equals(false))).go();

    final Set<String> artistSet = {};
    final Set<int> albumSet = {};

    for (final song in deletedSongs) {
      artistSet.add(song.artist);
      albumSet.add(song.albumId);
    }

    // delete empty albums
    albumSet.forEach(_deleteAlbumIfEmpty);
    // delete artists without albums
    artistSet.forEach(_deleteArtistIfEmpty);
  }

  @override
  Future<void> insertAlbums(List<AlbumModel> albumModels) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        albums,
        albumModels.map((e) => e.toAlbumsCompanion()).toList(),
      );
    });
  }

  @override
  Future<void> insertArtists(List<ArtistModel> artistModels) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        artists,
        artistModels.map((e) => e.toArtistsCompanion()).toList(),
      );
    });
  }

  @override
  Future<SongModel?> getPredecessor(SongModel song) async {
    final albumSongs = await (select(songs)
          ..where((tbl) => tbl.albumId.equals(song.albumId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.discNumber),
            (t) => OrderingTerm(expression: t.trackNumber)
          ]))
        .get()
        .then((driftSongList) =>
            driftSongList.map((driftSong) => SongModel.fromDrift(driftSong)).toList());

    SongModel? prevSong;
    for (final s in albumSongs) {
      if (s.path == song.path) {
        break;
      }
      prevSong = s;
    }
    return prevSong;
  }

  @override
  Future<SongModel?> getSuccessor(SongModel song) async {
    final albumSongs = await (select(songs)
          ..where((tbl) => tbl.albumId.equals(song.albumId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.discNumber),
            (t) => OrderingTerm(expression: t.trackNumber)
          ]))
        .get()
        .then((driftSongList) =>
            driftSongList.map((driftSong) => SongModel.fromDrift(driftSong)).toList());

    bool current = false;
    SongModel? nextSong;
    for (final s in albumSongs) {
      if (current) {
        nextSong = s;
        break;
      }
      if (s.path == song.path) {
        current = true;
      }
    }
    return nextSong;
  }

  @override
  Future<void> updateSongs(List<SongModel> songModels) async {
    await batch((batch) {
      batch.replaceAll(songs, songModels.map((e) => e.toSongsCompanion()).toList());
    });
  }

  @override
  Future<AlbumOfDay?> getAlbumOfDay() async {
    final value = await (select(keyValueEntries)..where((tbl) => tbl.key.equals(ALBUM_OF_DAY)))
        .getSingleOrNull()
        .then((entry) => entry?.value);

    if (value == null) {
      return null;
    }

    final dict = jsonDecode(value) as Map;

    final int id = dict['id'] as int;
    final int millisecondsSinceEpoch = dict['date'] as int;

    final AlbumModel? album = await (select(albums)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull()
        .then((value) => value == null ? null : AlbumModel.fromDrift(value));

    if (album == null) return null;

    return AlbumOfDay(album, DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch));
  }

  @override
  Future<void> setAlbumOfDay(AlbumOfDay albumOfDay) async {
    await into(keyValueEntries).insertOnConflictUpdate(
      KeyValueEntriesCompanion(
        key: const Value(ALBUM_OF_DAY),
        value: Value(albumOfDay.toJSON()),
      ),
    );
  }

  @override
  Future<ArtistOfDay?> getArtistOfDay() async {
    final value = await (select(keyValueEntries)..where((tbl) => tbl.key.equals(ARTIST_OF_DAY)))
        .getSingleOrNull()
        .then((entry) => entry?.value);

    if (value == null) {
      return null;
    }

    final dict = jsonDecode(value) as Map;

    final int id = dict['id'] as int;
    final int millisecondsSinceEpoch = dict['date'] as int;

    final ArtistModel? artist = await (select(artists)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull()
        .then((value) => value == null ? null : ArtistModel.fromDrift(value));

    if (artist == null) return null;

    return ArtistOfDay(artist, DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch));
  }

  @override
  Future<void> setArtistOfDay(ArtistOfDay artistOfDay) async {
    await into(keyValueEntries).insertOnConflictUpdate(
      KeyValueEntriesCompanion(
        key: const Value(ARTIST_OF_DAY),
        value: Value(artistOfDay.toJSON()),
      ),
    );
  }

  @override
  Future<List<AlbumModel>> searchAlbums(String searchText, {int? limit}) async {
    final List<AlbumModel> result = await (select(albums)
          ..where((tbl) => tbl.title.regexp(searchText, dotAll: true, caseSensitive: false)))
        .get()
        .then(
          (driftList) => driftList.map((driftAlbum) => AlbumModel.fromDrift(driftAlbum)).toList(),
        );

    if (limit != null) {
      if (limit < 0) return [];
      return result.take(limit).toList();
    }
    return result;
  }

  @override
  Future<List<ArtistModel>> searchArtists(String searchText, {int? limit}) async {
    final List<ArtistModel> result = await (select(artists)
          ..where((tbl) => tbl.name.regexp(searchText, dotAll: true, caseSensitive: false)))
        .get()
        .then(
          (driftList) =>
              driftList.map((driftArtist) => ArtistModel.fromDrift(driftArtist)).toList(),
        );

    if (limit != null) {
      if (limit < 0) return [];
      return result.take(limit).toList();
    }
    return result;
  }

  @override
  Future<List<SongModel>> searchSongs(String searchText, {int? limit}) async {
    final List<SongModel> result = await (select(songs)
          ..where((tbl) => tbl.title.regexp(searchText, dotAll: true, caseSensitive: false)))
        .get()
        .then(
          (driftList) => driftList.map((driftSong) => SongModel.fromDrift(driftSong)).toList(),
        );

    if (limit != null) {
      if (limit < 0) return [];
      return result.take(limit).toList();
    }
    return result;
  }

  @override
  Stream<SongModel> getSongStream(String path) {
    return (select(songs)..where((t) => t.path.equals(path))).watchSingle().distinct().map(
          (driftSong) => SongModel.fromDrift(driftSong),
        );
  }

  @override
  Future<int?> getAlbumId(String? title, String? artist, int? year) {
    return (select(albums)
          ..where(
            (t) =>
                t.artist.equalsNullable(artist) &
                t.title.equalsNullable(title) &
                t.year.equalsNullable(year),
          ))
        .getSingleOrNull()
        .then((v) => v?.id);
  }

  @override
  Future<void> addBlockedFiles(List<String> paths) async {
    final Set<String> artistSet = {};
    final Set<int> albumSet = {};

    for (final path in paths) {
      final song = await getSongByPath(path);
      artistSet.add(song!.artist);
      albumSet.add(song.albumId);
    }

    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        blockedFiles,
        paths.map((e) => BlockedFilesCompanion(path: Value(e))),
      );

      // delete songs
      batch.deleteWhere<$SongsTable, dynamic>(songs, (tbl) => tbl.path.isIn(paths));
    });

    // delete empty albums
    albumSet.forEach(_deleteAlbumIfEmpty);

    // delete artists without albums
    artistSet.forEach(_deleteArtistIfEmpty);
  }

  // Delete empty albums and all their database appearances.
  Future<void> _deleteAlbumIfEmpty(int albumId) async {
    final aSongs = await (select(songs)..where((tbl) => tbl.albumId.equals(albumId))).get();
    if (aSongs.isEmpty) {
      await (delete(albums)..where((tbl) => tbl.id.equals(albumId))).go();
      // delete history entries with this album
      await (delete(historyEntries)
            ..where((tbl) =>
                tbl.type.equals(PlayableType.album.toString()) &
                tbl.identifier.equals(albumId.toString())))
          .go();
    }
  }

  // Delete empty artists and all their database appearances.
  Future<void> _deleteArtistIfEmpty(String name) async {
    final aAlbums = await (select(albums)..where((tbl) => tbl.artist.equals(name))).get();
    if (aAlbums.isEmpty) {
      final emptyArtists = await (select(artists)..where((tbl) => tbl.name.equals(name))).get();
      await (delete(artists)..where((tbl) => tbl.name.equals(name))).go();
      await (delete(smartListArtists)..where((tbl) => tbl.artistName.equals(name))).go();

      for (final emptyArtist in emptyArtists) {
        (delete(historyEntries)
              ..where((tbl) =>
                  tbl.type.equals(PlayableType.artist.toString()) &
                  tbl.identifier.equals(emptyArtist.id.toString())))
            .go();
      }
    }
  }

  @override
  Stream<Set<String>> get blockedFilesStream =>
      select(blockedFiles).watch().map((value) => value.map((e) => e.path).toSet());

  @override
  Future<void> removeBlockedFiles(List<String> paths) async {
    await batch((batch) {
      batch.deleteWhere<$BlockedFilesTable, dynamic>(blockedFiles, (tbl) => tbl.path.isIn(paths));
    });
  }

  @override
  Future<void> cleanupDatabase() async {
    // get album history entries
    final albumHistoryEntries = await (select(historyEntries)
          ..where((tbl) => tbl.type.equals(PlayableType.album.toString())))
        .get();

    // delete history entries with missing album
    for (final entry in albumHistoryEntries) {
      if ((await (select(albums)..where((tbl) => tbl.id.equals(int.parse(entry.identifier)))).get())
          .isEmpty) {
        (delete(historyEntries)
              ..where((tbl) =>
                  tbl.type.equals(PlayableType.album.toString()) &
                  tbl.identifier.equals(entry.identifier)))
            .go();
      }
    }

    // get album history entries
    final artistHistoryEntries = await (select(historyEntries)
          ..where((tbl) => tbl.type.equals(PlayableType.artist.toString())))
        .get();

    // delete history entries with missing album
    for (final entry in artistHistoryEntries) {
      if ((await (select(artists)..where((tbl) => tbl.id.equals(int.parse(entry.identifier))))
              .get())
          .isEmpty) {
        (delete(historyEntries)
              ..where((tbl) =>
                  tbl.type.equals(PlayableType.artist.toString()) &
                  tbl.identifier.equals(entry.identifier)))
            .go();
      }
    }
  }
}
