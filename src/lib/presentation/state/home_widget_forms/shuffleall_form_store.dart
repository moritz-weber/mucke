import 'package:mobx/mobx.dart';

import '../../../domain/entities/home_widgets/shuffle_all.dart';
import '../../../domain/entities/shuffle_mode.dart';
import '../../../domain/repositories/home_widget_repository.dart';

part 'shuffleall_form_store.g.dart';

class ShuffleAllFormStore extends _ShuffleAllFormStore with _$ShuffleAllFormStore {
  ShuffleAllFormStore({
    required HomeWidgetRepository homeWidgetRepository,
    required HomeShuffleAll homeShuffleAll,
  }) : super(homeWidgetRepository, homeShuffleAll);
}

abstract class _ShuffleAllFormStore with Store {
  _ShuffleAllFormStore(
    this._homeWidgetRepository,
    this._shuffleAll,
  );

  final HomeWidgetRepository _homeWidgetRepository;

  final HomeShuffleAll _shuffleAll;

  @observable
  late ShuffleMode shuffleMode = _shuffleAll.shuffleMode;

  Future<void> save() async {
    _homeWidgetRepository.updateHomeWidget(
      HomeShuffleAll(
        position: _shuffleAll.position,
        shuffleMode: shuffleMode,
      ),
    );
  }
}
