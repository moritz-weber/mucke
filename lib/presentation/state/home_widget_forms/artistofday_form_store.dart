import 'package:mobx/mobx.dart';

import '../../../domain/entities/home_widgets/artist_of_day.dart';
import '../../../domain/entities/shuffle_mode.dart';
import '../../../domain/repositories/home_widget_repository.dart';

part 'artistofday_form_store.g.dart';

class ArtistOfDayFormStore extends _ArtistOfDayFormStore with _$ArtistOfDayFormStore {
  ArtistOfDayFormStore({
    required HomeWidgetRepository homeWidgetRepository,
    required HomeArtistOfDay homeArtistOfDay,
  }) : super(homeWidgetRepository, homeArtistOfDay);
}

abstract class _ArtistOfDayFormStore with Store {
  _ArtistOfDayFormStore(
    this._homeWidgetRepository,
    this._shuffleAll,
  );

  final HomeWidgetRepository _homeWidgetRepository;

  final HomeArtistOfDay _shuffleAll;

  @observable
  late ShuffleMode shuffleMode = _shuffleAll.shuffleMode;

  Future<void> save() async {
    _homeWidgetRepository.updateHomeWidget(
      HomeArtistOfDay(
        position: _shuffleAll.position,
        shuffleMode: shuffleMode,
      ),
    );
  }
}
