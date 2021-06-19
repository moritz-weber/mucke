import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'navigation_store.g.dart';

class NavigationStore extends _NavigationStore with _$NavigationStore {
  NavigationStore() : super();
}

abstract class _NavigationStore with Store {
  _NavigationStore();

  final libraryNavKey = GlobalKey<NavigatorState>();

  @observable int navIndex = 0;

  @action
  void setNavIndex(int i) {
    navIndex = i;
  }

  void pushOnLibrary(Route route) {
    // TODO: don't like this... 
    setNavIndex(1);
    libraryNavKey.currentState.push(route);
  }
}