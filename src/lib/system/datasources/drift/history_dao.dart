import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/playable.dart';
import '../../models/album_model.dart';
import '../../models/artist_model.dart';
import '../../models/history_entry_model.dart';
import '../../models/playlist_model.dart';
import '../../models/smart_list_model.dart';
import '../drift_database.dart';
import '../history_data_source.dart';

part 'history_dao.g.dart';

@DriftAccessor(tables: [HistoryEntries, Albums, Artists, Playlists, SmartLists, SmartListArtists])
class HistoryDao extends DatabaseAccessor<MainDatabase>
    with _$HistoryDaoMixin
    implements HistoryDataSource {
  HistoryDao(MainDatabase attachedDatabase) : super(attachedDatabase);

  @override
  Future<void> addHistoryEntry(Playable playable) async {
    await into(historyEntries).insert(
      HistoryEntriesCompanion(
        type: Value(playable.type.toString()),
        identifier: Value(playable.identifier),
      ),
    );
  }

  @override
  Stream<List<HistoryEntryModel>> historyStream(
      {int? limit, required bool unique, required bool includeSearch}) {
    // <- make a function out of this? for limit and sorting options?
    final query = select(historyEntries).join([
      leftOuterJoin(playlists, playlists.id.cast<String>().equalsExp(historyEntries.identifier)),
      leftOuterJoin(albums, albums.id.cast<String>().equalsExp(historyEntries.identifier)),
      leftOuterJoin(artists, artists.id.cast<String>().equalsExp(historyEntries.identifier)),
      leftOuterJoin(smartLists, smartLists.id.cast<String>().equalsExp(historyEntries.identifier)),
    ]);

    if (!includeSearch) {
      query.where(historyEntries.type.equals(PlayableType.search.toString()).not());
    }

    if (unique) {
      query.groupBy([historyEntries.type, historyEntries.identifier]);
      query.orderBy([OrderingTerm.desc(historyEntries.time.max())]);
    } else {
      query.orderBy([OrderingTerm.desc(historyEntries.time)]);
    }

    if (limit != null) {
      query.limit(limit);
    }

    final historyStream = query.watch();
    final slArtistStream = select(smartListArtists).join(
      [innerJoin(artists, artists.name.equalsExp(smartListArtists.artistName))],
    ).watch();

    return Rx.combineLatest2<List<TypedResult>, List<TypedResult>, List<HistoryEntryModel>>(
      historyStream,
      slArtistStream,
      (history, slArtists) {
        return history.map((e) {
          final entry = e.readTable(historyEntries);
          final etype = entry.type.toPlayableType();

          Playable playable = SearchQuery('Something went wrong here!');

          switch (etype) {
            case PlayableType.album:
              playable = AlbumModel.fromDrift(e.readTable(albums));
              break;
            case PlayableType.artist:
              playable = ArtistModel.fromDrift(e.readTable(artists));
              break;
            case PlayableType.playlist:
              playable = PlaylistModel.fromDrift(e.readTable(playlists));
              break;
            case PlayableType.smartlist:
              final driftArtists = slArtists.where((element) =>
                  element.readTable(smartListArtists).smartListId ==
                  int.parse(entry.identifier)).map((e) => e.readTable(artists)).toList();
              playable = SmartListModel.fromDrift(e.readTable(smartLists), driftArtists);
              break;
            case PlayableType.search:
              playable = SearchQuery(entry.identifier);
              break;
            case PlayableType.all:
              break;
          }
          return HistoryEntryModel.fromDrift(entry, playable);
        }).toList();
      },
    );
  }
}
