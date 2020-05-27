import 'package:mobx/mobx.dart';

part 'navigation_store.g.dart';

class NavigationStore extends _NavigationStore with _$NavigationStore {
  NavigationStore() : super();
}

abstract class _NavigationStore with Store {
  _NavigationStore();

  bool _initialized = false;

  @observable int navIndex = 1;

  @action
  void init() {
    if (!_initialized) {
      print('NavigationStore.init');
      _initialized = true;
    }
  }

  @action
  void setNavIndex(int i) {
    navIndex = i;
  }
}