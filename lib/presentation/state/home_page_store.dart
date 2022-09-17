import 'package:mobx/mobx.dart';

import '../../domain/entities/home_widgets/home_widget.dart';
import '../../domain/repositories/home_widget_repository.dart';

part 'home_page_store.g.dart';

class HomePageStore extends _HomePageStore with _$HomePageStore {
  HomePageStore({
    required HomeWidgetRepository homeWidgetRepository,
  }) : super(homeWidgetRepository);
}

abstract class _HomePageStore with Store {
  _HomePageStore(
    this._homeWidgetRepository,
  );

  final HomeWidgetRepository _homeWidgetRepository;

  @observable
  late ObservableStream<List<HomeWidget>> homeWidgetsStream =
      _homeWidgetRepository.homeWidgetsStream.asObservable();
}
