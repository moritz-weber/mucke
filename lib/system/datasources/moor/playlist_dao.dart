import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/shuffle_mode.dart';
import '../../../domain/entities/smart_list.dart' as sl;
import '../../models/playlist_model.dart';
import '../../models/smart_list_model.dart';
import '../../models/song_model.dart';
import '../moor_database.dart';
import '../playlist_data_source.dart';

part 'playlist_dao.g.dart';

@DriftAccessor(tables: [Albums, Artists, Songs, Playlists, PlaylistEntries, SmartLists, SmartListArtists])
class PlaylistDao extends DatabaseAccessor<MoorDatabase>
    with _$PlaylistDaoMixin
    implements PlaylistDataSource {
  PlaylistDao(MoorDatabase db) : super(db);

  @override
  Future<void> appendSongToPlaylist(PlaylistModel playlist, SongModel song) async {
    final plSongs =
        await (select(playlistEntries)..where((tbl) => tbl.playlistId.equals(playlist.id))).get();

    final songCount = plSongs.length;
    into(playlistEntries).insert(PlaylistEntriesCompanion(
      playlistId: Value(playlist.id),
      songPath: Value(song.path),
      position: Value(songCount),
    ));
  }

  @override
  Stream<PlaylistModel> getPlaylistStream(int playlistId) {
    final plStream = (select(playlists)
          ..where((tbl) => tbl.id.equals(playlistId))
          ..limit(1))
        .watchSingle();

    final plSongStream = (select(playlistEntries)
          ..where((tbl) => tbl.playlistId.equals(playlistId))
          ..orderBy([(t) => OrderingTerm(expression: t.position)]))
        .join(
      [innerJoin(songs, songs.path.equalsExp(playlistEntries.songPath))],
    ).watch();

    return Rx.combineLatest2<MoorPlaylist, List<TypedResult>, PlaylistModel>(
      plStream,
      plSongStream,
      (a, b) {
        final moorSongs = b.map((e) => e.readTable(songs)).toList();
        return PlaylistModel.fromMoor(a, moorSongs);
      },
    );
  }

  @override
  Future<void> insertPlaylist(String name) async {
    await into(playlists).insert(PlaylistsCompanion(name: Value(name)));
  }

  @override
  Stream<List<PlaylistModel>> get playlistsStream {
    final plStream = select(playlists).watch();

    final plSongStream = (select(playlistEntries).join(
      [innerJoin(songs, songs.path.equalsExp(playlistEntries.songPath))],
    )).watch();

    return Rx.combineLatest2<List<MoorPlaylist>, List<TypedResult>, List<PlaylistModel>>(
      plStream,
      plSongStream,
      (a, b) {
        return a.map((pl) {
          final moorSongs =
              (b.where((element) => element.readTable(playlistEntries).playlistId == pl.id))
                  .map((e) => e.readTable(songs))
                  .toList();
          return PlaylistModel.fromMoor(pl, moorSongs);
        }).toList();
      },
    );
  }

  @override
  Future<void> removePlaylist(PlaylistModel playlist) async {
    await (delete(playlists)..where((tbl) => tbl.id.equals(playlist.id))).go();
    await (delete(playlistEntries)..where((tbl) => tbl.playlistId.equals(playlist.id))).go();
  }

  @override
  Future<void> updatePlaylist(int id, String name) async {
    await (update(playlists)..where((tbl) => tbl.id.equals(id)))
        .write(PlaylistsCompanion(name: Value(name)));
  }

  @override
  Future<void> moveEntry(int playlistId, int oldIndex, int newIndex) async {
    if (oldIndex != newIndex) {
      transaction(() async {
        await (update(playlistEntries)
              ..where((tbl) => tbl.position.equals(oldIndex) & tbl.playlistId.equals(playlistId)))
            .write(const PlaylistEntriesCompanion(position: Value(-1)));
        if (oldIndex < newIndex) {
          for (int i = oldIndex + 1; i <= newIndex; i++) {
            await (update(playlistEntries)
                  ..where((tbl) => tbl.position.equals(i) & tbl.playlistId.equals(playlistId)))
                .write(PlaylistEntriesCompanion(position: Value(i - 1)));
          }
        } else {
          for (int i = oldIndex - 1; i >= newIndex; i--) {
            await (update(playlistEntries)
                  ..where((tbl) => tbl.position.equals(i) & tbl.playlistId.equals(playlistId)))
                .write(PlaylistEntriesCompanion(position: Value(i + 1)));
          }
        }
        await (update(playlistEntries)
              ..where((tbl) => tbl.position.equals(-1) & tbl.playlistId.equals(playlistId)))
            .write(PlaylistEntriesCompanion(position: Value(newIndex)));
      });
    }
  }

  @override
  Future<void> removeIndex(int playlistId, int index) async {
    final entries =
        await (select(playlistEntries)..where((tbl) => tbl.playlistId.equals(playlistId))).get();
    final count = entries.length;

    transaction(() async {
      await (delete(playlistEntries)
            ..where((tbl) => tbl.position.equals(index) & tbl.playlistId.equals(playlistId)))
          .go();
      for (int i = index + 1; i < count; i++) {
        await (update(playlistEntries)
              ..where((tbl) => tbl.position.equals(i) & tbl.playlistId.equals(playlistId)))
            .write(PlaylistEntriesCompanion(position: Value(i - 1)));
      }
    });
  }

  @override
  Future<void> insertSmartList(
    String name,
    sl.Filter filter,
    sl.OrderBy orderBy,
    ShuffleMode? shuffleMode,
  ) async {
    final orderCriteria = orderBy.orderCriteria.join(',');
    final orderDirections = orderBy.orderDirections.join(',');

    final id = await into(smartLists).insert(
      SmartListsCompanion(
        name: Value(name),
        shuffleMode: Value(shuffleMode?.toString()),
        excludeArtists: Value(filter.excludeArtists),
        minPlayCount: Value(filter.minPlayCount),
        maxPlayCount: Value(filter.maxPlayCount),
        minSkipCount: Value(filter.minSkipCount),
        maxSkipCount: Value(filter.maxSkipCount),
        minLikeCount: Value(filter.minLikeCount),
        maxLikeCount: Value(filter.maxLikeCount),
        minYear: Value(filter.minYear),
        maxYear: Value(filter.maxYear),
        blockLevel: Value(filter.blockLevel),
        limit: Value(filter.limit),
        orderCriteria: Value(orderCriteria),
        orderDirections: Value(orderDirections),
      ),
    );
    for (final a in filter.artists) {
      await into(smartListArtists).insert(
        SmartListArtistsCompanion(smartListId: Value(id), artistName: Value(a.name)),
      );
    }
  }

  @override
  Future<void> removeSmartList(SmartListModel smartListModel) async {
    await (delete(smartLists)..where((tbl) => tbl.id.equals(smartListModel.id))).go();
    await (delete(smartListArtists)..where((tbl) => tbl.smartListId.equals(smartListModel.id)))
        .go();
  }

  @override
  Stream<List<SmartListModel>> get smartListsStream {
    final slStream = select(smartLists).watch();

    final slArtistStream = (select(smartListArtists).join(
      [innerJoin(artists, artists.name.equalsExp(smartListArtists.artistName))],
    )).watch();

    return Rx.combineLatest2<List<MoorSmartList>, List<TypedResult>, List<SmartListModel>>(
      slStream,
      slArtistStream,
      (a, b) {
        return a.map((sl) {
          final moorArtists =
              (b.where((element) => element.readTable(smartListArtists).smartListId == sl.id))
                  .map((e) => e.readTable(artists))
                  .toList();
          return SmartListModel.fromMoor(sl, moorArtists);
        }).toList();
      },
    );
  }

  @override
  Stream<SmartListModel> getSmartListStream(int smartListId) {
    final slStream = (select(smartLists)
          ..where((tbl) => tbl.id.equals(smartListId))
          ..limit(1))
        .watchSingle();

    final slArtistStream =
        (select(smartListArtists)..where((tbl) => tbl.smartListId.equals(smartListId))).join(
      [innerJoin(artists, artists.name.equalsExp(smartListArtists.artistName))],
    ).watch();

    return Rx.combineLatest2<MoorSmartList, List<TypedResult>, SmartListModel>(
      slStream,
      slArtistStream,
      (a, b) {
        final moorArtists = b.map((e) => e.readTable(artists)).toList();
        return SmartListModel.fromMoor(a, moorArtists);
      },
    );
  }

  @override
  Future<void> updateSmartList(SmartListModel smartListModel) async {
    await (update(smartLists)..where((tbl) => tbl.id.equals(smartListModel.id)))
        .write(smartListModel.toCompanion());

    await (delete(smartListArtists)..where((tbl) => tbl.smartListId.equals(smartListModel.id)))
        .go();

    for (final a in smartListModel.filter.artists) {
      await into(smartListArtists).insert(
        SmartListArtistsCompanion(
          smartListId: Value(smartListModel.id),
          artistName: Value(a.name),
        ),
      );
    }
  }

  @override
  Stream<List<SongModel>> getSmartListSongStream(SmartListModel smartList) {
    SimpleSelectStatement<$SongsTable, MoorSong> query = select(songs);

    final filter = smartList.filter;
    query = query..where((tbl) => tbl.likeCount.isBiggerOrEqualValue(filter.minLikeCount));
    query = query..where((tbl) => tbl.likeCount.isSmallerOrEqualValue(filter.maxLikeCount));

    if (filter.minPlayCount != null)
      query = query..where((tbl) => tbl.playCount.isBiggerOrEqualValue(filter.minPlayCount));
    if (filter.maxPlayCount != null)
      query = query..where((tbl) => tbl.playCount.isSmallerOrEqualValue(filter.maxPlayCount));

    if (filter.minSkipCount != null)
      query = query..where((tbl) => tbl.skipCount.isBiggerOrEqualValue(filter.minSkipCount));
    if (filter.maxSkipCount != null)
      query = query..where((tbl) => tbl.skipCount.isSmallerOrEqualValue(filter.maxSkipCount));

    if (filter.minYear != null)
      query = query..where((tbl) => tbl.year.isBiggerOrEqualValue(filter.minYear));
    if (filter.maxYear != null)
      query = query..where((tbl) => tbl.year.isSmallerOrEqualValue(filter.maxYear));

    // TODO: adapt for different block levels
    query = query..where((tbl) => tbl.blockLevel.isSmallerOrEqualValue(filter.blockLevel));

    if (filter.artists.isNotEmpty) {
      if (filter.excludeArtists)
        query = query..where((tbl) => tbl.artist.isNotIn(filter.artists.map((e) => e.name)));
      else
        query = query..where((tbl) => tbl.artist.isIn(filter.artists.map((e) => e.name)));
    }

    if (filter.limit != null) query = query..limit(filter.limit!);

    final orderingTerms = _generateOrderingTerms(smartList.orderBy);

    query = query..orderBy(orderingTerms);

    return query.watch().map(
        (moorSongList) => moorSongList.map((moorSong) => SongModel.fromMoor(moorSong)).toList());
  }
}

List<OrderingTerm Function($SongsTable)> _generateOrderingTerms(sl.OrderBy orderBy) {
  final orderingTerms = <OrderingTerm Function($SongsTable)>[];

  int i = 0;
  while (i < orderBy.orderCriteria.length) {
    final OrderingMode mode = orderBy.orderDirections[i].toMoor();
    switch (orderBy.orderCriteria[i]) {
      case sl.OrderCriterion.artistName:
        orderingTerms.add(
          ($SongsTable t) => OrderingTerm(
            expression: t.artist,
            mode: mode,
          ),
        );
        break;
      case sl.OrderCriterion.likeCount:
        orderingTerms.add(
          ($SongsTable t) => OrderingTerm(
            expression: t.likeCount,
            mode: mode,
          ),
        );
        break;
      case sl.OrderCriterion.playCount:
        orderingTerms.add(
          ($SongsTable t) => OrderingTerm(
            expression: t.playCount,
            mode: mode,
          ),
        );
        break;
      case sl.OrderCriterion.skipCount:
        orderingTerms.add(
          ($SongsTable t) => OrderingTerm(
            expression: t.skipCount,
            mode: mode,
          ),
        );
        break;
      case sl.OrderCriterion.songTitle:
        orderingTerms.add(
          ($SongsTable t) => OrderingTerm(
            expression: t.title,
            mode: mode,
          ),
        );
        break;
      case sl.OrderCriterion.timeAdded:
        orderingTerms.add(
          ($SongsTable t) => OrderingTerm(
            expression: t.timeAdded,
            mode: mode,
          ),
        );
        break;
      case sl.OrderCriterion.year:
        orderingTerms.add(
          ($SongsTable t) => OrderingTerm(
            expression: t.year,
            mode: mode,
          ),
        );
        break;
    }
    i++;
  }

  return orderingTerms;
}
