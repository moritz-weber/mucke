import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'navigation_store.g.dart';

class NavigationStore extends _NavigationStore with _$NavigationStore {
  NavigationStore() : super();
}

abstract class _NavigationStore with Store {
  _NavigationStore();

  final libraryNavKey = GlobalKey<NavigatorState>();

  @observable
  ObservableList<int> navIndexHistory = [0].asObservable();

  @computed
  int get navIndex => navIndexHistory.last;

  final List<_NavType> _navTypeHistory = [];

  @action
  void setNavIndex(int i) {
    if (i != navIndex) {
      _navTypeHistory.add(_NavType.tab);
      navIndexHistory.add(i);
    }
  }

  @action
  int popNavIndex() {
    return navIndexHistory.removeLast();
  }

  Future<T?> push<T extends Object?>(BuildContext context, Route<T> route) {
    _navTypeHistory.add(_NavType.route);
    return Navigator.of(context).push(route);
  }

  void pushOnLibrary(Route route) {
    // TODO: don't like this...
    setNavIndex(1);
    libraryNavKey.currentState?.push(route);
  }

  Future<bool> onWillPop() async {
    if (_navTypeHistory.isEmpty) {
      return Future.value(true);
    }

    final navType = _navTypeHistory.removeLast();
    if (navType == _NavType.tab) {
      popNavIndex();
      return Future.value(false);
    }
    
    if (navIndex == 1) {
      final result = !await libraryNavKey.currentState!.maybePop();
      return result;
    }
    return Future.value(false);
  }
}

enum _NavType { tab, route }
