import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:mobx/mobx.dart';

part 'navigation_store.g.dart';

class NavigationStore extends _NavigationStore with _$NavigationStore {
  NavigationStore() : super();
}

abstract class _NavigationStore with Store {
  _NavigationStore();

  GlobalKey<NavigatorState>? libraryNavKey;
  GlobalKey<NavigatorState>? homeNavKey;

  static final _log = FimberLog('NavigationStore');

  @observable
  ObservableList<int> navIndexHistory = [0].asObservable();

  @computed
  int get navIndex => navIndexHistory.last;

  final List<_NavState> _navTypeHistory = [];

  @action
  bool setNavIndex(int i, {bool updateTypeHistory = true}) {
    _log.d('setNavIndex');
    _log.d(
        'history: ${_navTypeHistory.length} (${_navTypeHistory.isEmpty ? "-" : _navTypeHistory.last})');
    if (i != navIndex) {
      if (updateTypeHistory) _navTypeHistory.add(_NavState(_NavType.tab, navIndex, i));
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
    _log.d('push');
    _log.d(
        'history: ${_navTypeHistory.length} (${_navTypeHistory.isEmpty ? "-" : _navTypeHistory.last})');
    _navTypeHistory.add(_NavState(_NavType.route, navIndex, navIndex));
    return Navigator.of(context).push(route);
  }

  void pop<T extends Object?>(BuildContext context) {
    _log.d('pop');
    _log.d(
      'history: ${_navTypeHistory.length} (${_navTypeHistory.isEmpty ? "-" : _navTypeHistory.last})',
    );

    switch (_navTypeHistory.last.type) {
      case _NavType.tab:
        _log.d('deviate from history!');
        // back button should now go down the stack of the active tab
        // only when this stack is empty, go back to previous tab
        // => move all route actions from this tab to the end of the history
        final localRoute = <_NavState>[];
        final other = <_NavState>[];

        for (final n in _navTypeHistory) {
          if (n.type == _NavType.route && n.origin == navIndex) {
            localRoute.add(n);
          } else {
            other.add(n);
          }
        }

        _navTypeHistory.clear();
        _navTypeHistory.addAll(other);
        _navTypeHistory.addAll(localRoute);
        _navTypeHistory.removeLast();

        break;
      case _NavType.route:
        _navTypeHistory.removeLast();
        break;
      case _NavType.both:
        _log.d('change both to tab!');
        // change last action to tab (not too late to get on the right track)
        final last = _navTypeHistory.removeLast();
        _navTypeHistory.add(_NavState(_NavType.tab, last.origin, last.target));
        break;
    }

    return Navigator.of(context).pop();
  }

  void pushOnLibrary(Route route) {
    _log.d('pushOnLibrary');
    _log.d(
      'history: ${_navTypeHistory.length} (${_navTypeHistory.isEmpty ? "-" : _navTypeHistory.last})',
    );
    final _navIndex = navIndex;

    libraryNavKey!.currentState?.push(route);
    final indexChanged = setNavIndex(1, updateTypeHistory: false);
    if (indexChanged) {
      _navTypeHistory.add(_NavState(_NavType.both, _navIndex, navIndex));
    } else {
      _navTypeHistory.add(_NavState(_NavType.route, _navIndex, navIndex));
    }
  }

  /// This function is triggered when pressing the Android back button.
  Future<bool> onWillPop() async {
    _log.d('onWillPop');
    _log.d(
      'history: ${_navTypeHistory.length} (${_navTypeHistory.isEmpty ? "-" : _navTypeHistory.last})',
    );
    if (_navTypeHistory.isEmpty) {
      return Future.value(true);
    }

    final navState = _navTypeHistory.removeLast();
    if (navState.type == _NavType.both) {
      bool result = false;
      if (navIndex == 1) {
        result = !await libraryNavKey!.currentState!.maybePop();
      }
      popNavIndex();
      return Future.value(result);
    } else if (navState.type == _NavType.tab) {
      popNavIndex();
      return Future.value(false);
    } else {
      if (navIndex == 1) {
        final result = !await libraryNavKey!.currentState!.maybePop();
        return result;
      } else if (navIndex == 0) {
        final result = !await homeNavKey!.currentState!.maybePop();
        return result;
      }
    }
    return Future.value(false);
  }
}

enum _NavType { tab, route, both }

class _NavState {
  _NavState(this.type, this.origin, this.target);

  final _NavType type;
  final int origin;
  final int target;

  @override
  String toString() {
    return 'action: $type, o: $origin, t: $target';
  }
}
