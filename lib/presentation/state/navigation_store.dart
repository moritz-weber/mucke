import 'package:mobx/mobx.dart';

part 'navigation_store.g.dart';

class NavigationStore extends _NavigationStore with _$NavigationStore {
  NavigationStore() : super();
}

abstract class _NavigationStore with Store {
  _NavigationStore();

  @observable int navIndex = 0;

  @action
  void setNavIndex(int i) {
    navIndex = i;
  }
}