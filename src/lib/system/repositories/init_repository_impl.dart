import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

import '../../domain/entities/enums.dart';
import '../../domain/entities/home_widgets/playlists.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/repositories/init_repository.dart';
import '../datasources/home_widget_data_source.dart';
import '../datasources/persistent_state_data_source.dart';
import '../models/home_widgets/album_of_day_model.dart';
import '../models/home_widgets/artist_of_day_model.dart';
import '../models/home_widgets/history_model.dart';
import '../models/home_widgets/playlists_model.dart';
import '../models/home_widgets/shuffle_all_model.dart';

class InitRepositoryImpl extends InitRepository {
  InitRepositoryImpl(this._persistentStateDataSource, this._homeWidgetDataSource);

  final PersistentStateDataSource _persistentStateDataSource;
  final HomeWidgetDataSource _homeWidgetDataSource;

  @override
  Future<void> initHomePage(BuildContext context) async {
    await _homeWidgetDataSource.insertHomeWidget(HomeAlbumOfDayModel(0));
    await _homeWidgetDataSource.insertHomeWidget(HomeArtistOfDayModel(1, ShuffleMode.plus));
    await _homeWidgetDataSource.insertHomeWidget(HomeShuffleAllModel(2, ShuffleMode.plus));
    await _homeWidgetDataSource.insertHomeWidget(
      HomePlaylistsModel(
        3,
        3,
        L10n.of(context)!.yourPlaylists,
        HomePlaylistsOrder.history,
        OrderDirection.ascending,
        HomePlaylistsFilter.both,
      ),
    );
    await _homeWidgetDataSource.insertHomeWidget(HomeHistoryModel(4, 3));
  }

  @override
  Future<bool> get isInitialized async => await _persistentStateDataSource.isInitialized;

  @override
  Future<void> setInitialized() async {
    await _persistentStateDataSource.setInitialized();
  }
}
