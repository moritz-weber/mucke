import 'package:drift/drift.dart';

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
  Stream<List<HistoryEntryModel>> historyStream({int? limit, required bool unique, required bool includeSearch}) {
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

    return query.watch().map((results) => results.map((e) {
          final entry = e.readTable(historyEntries);
          final etype = entry.type.toPlayableType();

          switch (etype) {
            case PlayableType.album:
              return HistoryEntryModel.fromDrift(entry, AlbumModel.fromDrift(e.readTable(albums)));
            case PlayableType.artist:
              return HistoryEntryModel.fromDrift(entry, ArtistModel.fromDrift(e.readTable(artists)));
            case PlayableType.playlist:
              return HistoryEntryModel.fromDrift(
                  entry, PlaylistModel.fromDrift(e.readTable(playlists)));
            case PlayableType.smartlist:
              return HistoryEntryModel.fromDrift(
                entry,
                SmartListModel.fromDrift(
                  e.readTable(smartLists),
                  null, // TODO: how do we open a SmartListPage with an incomplete SmartListModel?
                ),
              );
            case PlayableType.search:
              return HistoryEntryModel.fromDrift(entry, SearchQuery(entry.identifier));
            default:
              return HistoryEntryModel.fromDrift(entry, SearchQuery('Something went wrong here!'));
          }
        }).toList());
  }
}
