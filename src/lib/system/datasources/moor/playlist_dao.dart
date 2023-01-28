import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/playable.dart';
import '../../../domain/entities/shuffle_mode.dart';
import '../../../domain/entities/smart_list.dart' as sl;
import '../../models/playlist_model.dart';
import '../../models/smart_list_model.dart';
import '../../models/song_model.dart';
import '../moor_database.dart';
import '../playlist_data_source.dart';

part 'playlist_dao.g.dart';

@DriftAccessor(tables: [
  Albums,
  Artists,
  Songs,
  Playlists,
  PlaylistEntries,
  SmartLists,
  SmartListArtists,
  HistoryEntries
])
class PlaylistDao extends DatabaseAccessor<MoorDatabase>
    with _$PlaylistDaoMixin
    implements PlaylistDataSource {
  PlaylistDao(MoorDatabase db) : super(db);

  @override
  Future<void> addSongsToPlaylist(PlaylistModel playlist, List<SongModel> songs) async {
    final plSongs =
        await (select(playlistEntries)..where((tbl) => tbl.playlistId.equals(playlist.id))).get();

    final songCount = plSongs.length;

    int i = 0;
    final entries = <PlaylistEntriesCompanion>[];

    for (final s in songs) {
      entries.add(PlaylistEntriesCompanion(
        playlistId: Value(playlist.id),
        songPath: Value(s.path),
        position: Value(songCount + i),
      ));
      i++;
    }

    await (update(playlists)..where((tbl) => tbl.id.equals(playlist.id)))
        .write(PlaylistsCompanion(timeChanged: Value(DateTime.now())));

    await batch((batch) {
      batch.insertAll(playlistEntries, entries);
    });
  }

  @override
  Stream<PlaylistModel> getPlaylistStream(int playlistId) {
    return (select(playlists)
          ..where((tbl) => tbl.id.equals(playlistId))
          ..limit(1))
        .watchSingle()
        .map((event) => PlaylistModel.fromMoor(event));
  }

  @override
  Future<void> insertPlaylist(
    String name,
    String iconString,
    String gradientString,
    ShuffleMode? shuffleMode,
  ) async {
    await into(playlists).insert(
      PlaylistsCompanion(
        name: Value(name),
        icon: Value(iconString),
        gradient: Value(gradientString),
        shuffleMode: Value(shuffleMode?.toString()),
      ),
    );
  }

  @override
  Stream<List<PlaylistModel>> get playlistsStream {
    return select(playlists)
        .watch()
        .map((moorPlaylists) => moorPlaylists.map((e) => PlaylistModel.fromMoor(e)).toList());
  }

  @override
  Stream<List<SongModel>> getPlaylistSongStream(PlaylistModel playlist) {
    return ((select(playlistEntries)
          ..where((tbl) => tbl.playlistId.equals(playlist.id))
          ..orderBy([(t) => OrderingTerm.asc(t.position)]))
        .join(
      [innerJoin(songs, songs.path.equalsExp(playlistEntries.songPath))],
    )).watch().map((moorSongList) =>
        moorSongList.map((moorSong) => SongModel.fromMoor(moorSong.readTable(songs))).toList());
  }

  @override
  Future<void> removePlaylist(PlaylistModel playlist) async {
    await (delete(playlists)..where((tbl) => tbl.id.equals(playlist.id))).go();
    await (delete(playlistEntries)..where((tbl) => tbl.playlistId.equals(playlist.id))).go();
    await (delete(historyEntries)
          ..where((tbl) =>
              tbl.type.equals(PlayableType.playlist.toString()) &
              tbl.identifier.equals(playlist.id.toString())))
        .go();
  }

  @override
  Future<void> updatePlaylist(PlaylistModel playlist) async {
    await (update(playlists)..where((tbl) => tbl.id.equals(playlist.id)))
        .write(playlist.toCompanion());
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

        await (update(playlists)..where((tbl) => tbl.id.equals(playlistId)))
            .write(PlaylistsCompanion(timeChanged: Value(DateTime.now())));
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

      await (update(playlists)..where((tbl) => tbl.id.equals(playlistId)))
          .write(PlaylistsCompanion(timeChanged: Value(DateTime.now())));
    });
  }

  @override
  Future<void> insertSmartList(
    String name,
    sl.Filter filter,
    sl.OrderBy orderBy,
    String iconString,
    String gradientString,
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
        minLikeCount: Value(filter.minLikeCount),
        maxLikeCount: Value(filter.maxLikeCount),
        minYear: Value(filter.minYear),
        maxYear: Value(filter.maxYear),
        blockLevel: Value(filter.blockLevel),
        limit: Value(filter.limit),
        orderCriteria: Value(orderCriteria),
        orderDirections: Value(orderDirections),
        icon: Value(iconString),
        gradient: Value(gradientString),
      ),
    );
    // filter.artists has to be set when inserting
    for (final a in filter.artists!) {
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
    await (delete(historyEntries)
          ..where((tbl) =>
              tbl.type.equals(PlayableType.playlist.toString()) &
              tbl.identifier.equals(smartListModel.id.toString())))
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
        print(sl);
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
    transaction(() async {
      await (update(smartLists)..where((tbl) => tbl.id.equals(smartListModel.id)))
          .write(smartListModel.toCompanion());

      await (delete(smartListArtists)..where((tbl) => tbl.smartListId.equals(smartListModel.id)))
          .go();

      // filter.artists has to be set when updating!
      for (final a in smartListModel.filter.artists!) {
        await into(smartListArtists).insert(
          SmartListArtistsCompanion(
            smartListId: Value(smartListModel.id),
            artistName: Value(a.name),
          ),
        );
      }
    });
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

    if (filter.minYear != null)
      query = query..where((tbl) => tbl.year.isBiggerOrEqualValue(filter.minYear));
    if (filter.maxYear != null)
      query = query..where((tbl) => tbl.year.isSmallerOrEqualValue(filter.maxYear));

    query = query..where((tbl) => tbl.blockLevel.isSmallerOrEqualValue(filter.blockLevel));

    // when requesting the actual songs, the smart list needs to be complete -> artists set
    if (filter.artists!.isNotEmpty) {
      if (filter.excludeArtists)
        query = query..where((tbl) => tbl.artist.isNotIn(filter.artists!.map((e) => e.name)));
      else
        query = query..where((tbl) => tbl.artist.isIn(filter.artists!.map((e) => e.name)));
    }

    if (filter.limit != null) query = query..limit(filter.limit!);

    final orderingTerms = _generateOrderingTerms(smartList.orderBy);

    query = query..orderBy(orderingTerms);

    return query.watch().map(
        (moorSongList) => moorSongList.map((moorSong) => SongModel.fromMoor(moorSong)).toList());
  }

  @override
  Future<List<PlaylistModel>> searchPlaylists(String searchText, {int? limit}) async {
    final List<PlaylistModel> result = await (select(playlists)
          ..where((tbl) => tbl.name.regexp(searchText, dotAll: true, caseSensitive: false)))
        .get()
        .then(
          (moorList) =>
              moorList.map((moorPlaylist) => PlaylistModel.fromMoor(moorPlaylist)).toList(),
        );

    if (limit != null) {
      if (limit < 0) return [];
      return result.take(limit).toList();
    }
    return result;
  }

  @override
  Future<List<SmartListModel>> searchSmartLists(String searchText, {int? limit}) async {
    final slArtists = await (select(smartListArtists).join(
      [innerJoin(artists, artists.name.equalsExp(smartListArtists.artistName))],
    )).get();

    final List<SmartListModel> result = await (select(smartLists)
          ..where((tbl) => tbl.name.regexp(searchText, dotAll: true, caseSensitive: false)))
        .get()
        .then(
      (moorList) {
        return moorList.map((moorSmartList) {
          final moorArtists = (slArtists.where(
                  (element) => element.readTable(smartListArtists).smartListId == moorSmartList.id))
              .map((e) => e.readTable(artists))
              .toList();
          return SmartListModel.fromMoor(moorSmartList, moorArtists);
        }).toList();
      },
    );

    if (limit != null) {
      if (limit < 0) return [];
      return result.take(limit).toList();
    }
    return result;
  }

  @override
  Future<void> removeBlockedSongs(List<String> paths) async {
    final Map<int, List<int>> playlistIndexMap = {};

    // gather the playlist entries to remove
    for (final path in paths) {
      final entries =
          await (select(playlistEntries)..where((tbl) => tbl.songPath.equals(path))).get();
      for (final entry in entries) {
        if (playlistIndexMap.containsKey(entry.playlistId)) {
          playlistIndexMap[entry.playlistId]!.add(entry.position);
        } else {
          playlistIndexMap[entry.playlistId] = [entry.position];
        }
      }
    }

    for (final playlistId in playlistIndexMap.keys) {
      final indices = List<int>.from(playlistIndexMap[playlistId]!);
      indices.sort();

      final entries =
          await (select(playlistEntries)..where((tbl) => tbl.playlistId.equals(playlistId))).get();

      int removedCount = 0;

      transaction(() async {
        for (final index
            in List.generate(entries.length - indices.first, (i) => i + indices.first)) {
          if (indices.isNotEmpty && index == indices.first) {
            // remove the entry
            await (delete(playlistEntries)
                  ..where((tbl) => tbl.position.equals(index) & tbl.playlistId.equals(playlistId)))
                .go();
            removedCount += 1;
            indices.removeAt(0);
          } else {
            // adapt entry position
            await (update(playlistEntries)
                  ..where((tbl) => tbl.position.equals(index) & tbl.playlistId.equals(playlistId)))
                .write(PlaylistEntriesCompanion(position: Value(index - removedCount)));
          }

          await (update(playlists)..where((tbl) => tbl.id.equals(playlistId)))
              .write(PlaylistsCompanion(timeChanged: Value(DateTime.now())));
        }
      });
    }
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
