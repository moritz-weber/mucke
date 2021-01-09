import 'package:moor/moor.dart';

import '../../models/album_model.dart';
import '../../models/artist_model.dart';
import '../../models/song_model.dart';
import '../moor_database.dart';
import '../music_data_source_contract.dart';

part 'music_data_dao.g.dart';

@UseDao(tables: [Albums, Artists, Songs])
class MusicDataDao extends DatabaseAccessor<MoorDatabase>
    with _$MusicDataDaoMixin
    implements MusicDataSource {
  MusicDataDao(MoorDatabase db) : super(db);

  @override
  Future<List<AlbumModel>> getAlbums() async {
    return select(albums).get().then((moorAlbumList) =>
        moorAlbumList.map((moorAlbum) => AlbumModel.fromMoor(moorAlbum)).toList());
  }

  // TODO: insert can throw exception -> implications?
  @override
  Future<int> insertAlbum(AlbumModel albumModel) async {
    return await into(albums).insert(albumModel.toAlbumsCompanion());
  }

  @override
  Stream<List<SongModel>> get songStream {
    return select(songs).watch().map(
        (moorSongList) => moorSongList.map((moorSong) => SongModel.fromMoor(moorSong)).toList());
  }

  @override
  Stream<List<AlbumModel>> get albumStream {
    return select(albums).watch().map((moorAlbumList) =>
        moorAlbumList.map((moorAlbum) => AlbumModel.fromMoor(moorAlbum)).toList());
  }

  @override
  Stream<List<ArtistModel>> get artistStream {
    return select(artists).watch().map((moorArtistList) =>
        moorArtistList.map((moorArtist) => ArtistModel.fromMoor(moorArtist)).toList());
  }

  @override
  Future<List<SongModel>> getSongs() {
    return select(songs).get().then(
        (moorSongList) => moorSongList.map((moorSong) => SongModel.fromMoor(moorSong)).toList());
  }

  @override
  Stream<List<SongModel>> getAlbumSongStream(AlbumModel album) {
    return (select(songs)
          ..where((tbl) => tbl.albumId.equals(album.id))
          ..orderBy([
            (t) => OrderingTerm(expression: t.discNumber),
            (t) => OrderingTerm(expression: t.trackNumber)
          ]))
        .watch()
        .map((moorSongList) =>
            moorSongList.map((moorSong) => SongModel.fromMoor(moorSong)).toList());
  }

  @override
  Stream<List<AlbumModel>> getArtistAlbumStream(ArtistModel artist) {
    return (select(albums)
          ..where((tbl) => tbl.artist.equals(artist.name))
          ..orderBy([
            (t) => OrderingTerm(expression: t.title),
          ]))
        .watch()
        .map((moorAlbumList) =>
            moorAlbumList.map((moorAlbum) => AlbumModel.fromMoor(moorAlbum)).toList());
  }

  @override
  Future<void> insertSong(SongModel songModel) async {
    await into(songs).insert(songModel.toSongsCompanion());
  }

  @override
  Future<SongModel> getSongByPath(String path) async {
    return (select(songs)..where((t) => t.path.equals(path))).getSingle().then(
      (moorSong) {
        if (moorSong == null) {
          return null;
        }
        return SongModel.fromMoor(moorSong);
      },
    );
  }

  @override
  Future<void> deleteAllArtists() async {
    delete(artists).go();
  }

  @override
  Future<int> insertArtist(ArtistModel artistModel) async {
    return into(artists).insert(artistModel.toArtistsCompanion());
  }

  @override
  Future<void> deleteAllAlbums() async {
    delete(albums).go();
  }

  @override
  Future<void> deleteAllSongs() async {
    delete(songs).go();
  }

  @override
  Future<List<ArtistModel>> getArtists() {
    return select(artists).get().then((moorArtistList) =>
        moorArtistList.map((moorArtist) => ArtistModel.fromMoor(moorArtist)).toList());
  }

  @override
  Future<void> insertSongs(List<SongModel> songModels) async {
    await update(songs).write(const SongsCompanion(present: Value(false)));

    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        songs,
        songModels.map((e) => e.toMoorInsert()).toList(),
      );
    });

    await (delete(songs)..where((tbl) => tbl.present.equals(false))).go();
  }

  @override
  Future<void> setSongBlocked(SongModel song, bool blocked) async {
    await (update(songs)..where((tbl) => tbl.path.equals(song.path)))
        .write(SongsCompanion(blocked: Value(blocked)));
  }

  // EXPLORATORY CODE!!!
  @override
  Future<void> toggleNextSongLink(SongModel song) async {
    if (song.next == null) {
      final albumSongs = await (select(songs)
            ..where((tbl) => tbl.albumId.equals(song.albumId))
            ..orderBy([
              (t) => OrderingTerm(expression: t.discNumber),
              (t) => OrderingTerm(expression: t.trackNumber)
            ]))
          .get()
          .then((moorSongList) =>
              moorSongList.map((moorSong) => SongModel.fromMoor(moorSong)).toList());

      bool current = false;
      SongModel nextSong;
      for (final s in albumSongs) {
        if (current) {
          nextSong = s;
          break;
        }
        if (s.path == song.path) {
          current = true;
        }
      }
      await (update(songs)..where((tbl) => tbl.path.equals(song.path)))
          .write(SongsCompanion(next: Value(nextSong.path)));
    } else {
      await (update(songs)..where((tbl) => tbl.path.equals(song.path)))
          .write(const SongsCompanion(next: Value(null)));
    }
  }

  @override
  Future<void> decrementLikeCount(SongModel song) async {
    final songEntry = await (select(songs)..where((tbl) => tbl.path.equals(song.path))).getSingle();

    if (song.likeCount > 0) {
      await (update(songs)..where((tbl) => tbl.path.equals(song.path)))
          .write(SongsCompanion(likeCount: Value(songEntry.likeCount - 1)));
    }
  }

  @override
  Future<void> incrementLikeCount(SongModel song) async {
    final songEntry = await (select(songs)..where((tbl) => tbl.path.equals(song.path))).getSingle();

    if (song.likeCount < 5) {
      await (update(songs)..where((tbl) => tbl.path.equals(song.path)))
          .write(SongsCompanion(likeCount: Value(songEntry.likeCount + 1)));
    }
  }

  @override
  Future<void> incrementPlayCount(SongModel song) async {
    final songEntry = await (select(songs)..where((tbl) => tbl.path.equals(song.path))).getSingle();

    await (update(songs)..where((tbl) => tbl.path.equals(song.path)))
        .write(SongsCompanion(playCount: Value(songEntry.playCount + 1)));
  }

  @override
  Future<void> incrementSkipCount(SongModel song) async {
    final songEntry = await (select(songs)..where((tbl) => tbl.path.equals(song.path))).getSingle();

    await (update(songs)..where((tbl) => tbl.path.equals(song.path)))
        .write(SongsCompanion(skipCount: Value(songEntry.skipCount + 1)));
  }

  @override
  Future<void> resetLikeCount(SongModel song) async {
    await (update(songs)..where((tbl) => tbl.path.equals(song.path)))
        .write(const SongsCompanion(likeCount: Value(0)));
  }

  @override
  Future<void> resetPlayCount(SongModel song) async {
    await (update(songs)..where((tbl) => tbl.path.equals(song.path)))
        .write(const SongsCompanion(playCount: Value(0)));
  }

  @override
  Future<void> resetSkipCount(SongModel song) async {
    await (update(songs)..where((tbl) => tbl.path.equals(song.path)))
        .write(const SongsCompanion(skipCount: Value(0)));
  }
}
