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
  bool setNavIndex(int i, {bool updateTypeHistory = true}) {
    if (i != navIndex) {
      if (updateTypeHistory) _navTypeHistory.add(_NavType.tab);
      navIndexHistory.add(i);
      return true;
    }
    return false;
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
    libraryNavKey.currentState?.push(route);
    final indexChanged = setNavIndex(1, updateTypeHistory: false);
    if (indexChanged) {
      _navTypeHistory.add(_NavType.both);
    } else {
      _navTypeHistory.add(_NavType.route);
    }
  }

  Future<bool> onWillPop() async {
    if (_navTypeHistory.isEmpty) {
      return Future.value(true);
    }

    final navType = _navTypeHistory.removeLast();
    if (navType == _NavType.both) {
      bool result = false;
      if (navIndex == 1) {
        result = !await libraryNavKey.currentState!.maybePop();
      }
      popNavIndex();
      return Future.value(result);
    }

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

enum _NavType { tab, route, both }
