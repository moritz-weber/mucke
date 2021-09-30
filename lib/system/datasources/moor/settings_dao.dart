import 'package:moor/moor.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/shuffle_mode.dart';
import '../../../domain/entities/smart_list.dart' as sl;
import '../../models/smart_list_model.dart';
import '../moor_database.dart';
import '../settings_data_source.dart';

part 'settings_dao.g.dart';

@UseDao(tables: [LibraryFolders, SmartLists, SmartListArtists, Artists])
class SettingsDao extends DatabaseAccessor<MoorDatabase>
    with _$SettingsDaoMixin
    implements SettingsDataSource {
  SettingsDao(MoorDatabase attachedDatabase) : super(attachedDatabase);

  @override
  Stream<List<String>> get libraryFoldersStream =>
      select(libraryFolders).watch().map((value) => value.map((e) => e.path).toList());

  @override
  Future<void> removeLibraryFolder(String path) async {
    await (delete(libraryFolders)..where((tbl) => tbl.path.equals(path))).go();
  }

  @override
  Future<void> addLibraryFolder(String path) async {
    await into(libraryFolders).insert(LibraryFoldersCompanion(path: Value(path)));
  }

  @override
  Future<void> insertSmartList(
    String name,
    int position,
    sl.Filter filter,
    sl.OrderBy orderBy,
    ShuffleMode? shuffleMode,
  ) async {
    final orderCriteria = orderBy.orderCriteria.join(',');
    final orderDirections = orderBy.orderDirections.join(',');

    int newPos = position;
    if (newPos < 0) {
      newPos = await select(smartLists).get().then((value) => value.length);
    }

    final id = await into(smartLists).insert(
      SmartListsCompanion(
        name: Value(name),
        position: Value(newPos),
        shuffleMode: Value(shuffleMode?.toString()),
        excludeArtists: Value(filter.excludeArtists),
        minPlayCount: Value(filter.minPlayCount),
        maxPlayCount: Value(filter.maxPlayCount),
        minLikeCount: Value(filter.minLikeCount),
        maxLikeCount: Value(filter.maxLikeCount),
        minYear: Value(filter.minYear),
        maxYear: Value(filter.maxYear),
        excludeBlocked: Value(filter.excludeBlocked),
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
    final slStream =
        (select(smartLists)..orderBy([(s) => OrderingTerm(expression: s.position)])).watch();

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
          smartListId: Value(smartListModel.id!),
          artistName: Value(a.name),
        ),
      );
    }
  }
}
