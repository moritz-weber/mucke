import '../enums.dart';
import 'home_widget.dart';

class HomePlaylists implements HomeWidget {
  HomePlaylists({
    required this.position,
    this.maxEntries = 3,
    this.title = 'Your Playlists',
    this.orderCriterion = HomePlaylistsOrder.name,
    this.orderDirection = OrderDirection.ascending,
    this.filter = HomePlaylistsFilter.both,
  });

  @override
  HomeWidgetType get type => HomeWidgetType.playlists;

  @override
  int position;

  final String title;

  final int maxEntries;

  final HomePlaylistsOrder orderCriterion;

  final OrderDirection orderDirection;

  final HomePlaylistsFilter filter;
}

enum HomePlaylistsOrder {
  name,
  creationDate,
  changeDate,
  history,
}

extension HomePlaylistsOrderExtension on String {
  HomePlaylistsOrder? toHomePlaylistsOrder() {
    switch (this) {
      case 'HomePlaylistsOrder.name':
        return HomePlaylistsOrder.name;
      case 'HomePlaylistsOrder.creationDate':
        return HomePlaylistsOrder.creationDate;
      case 'HomePlaylistsOrder.changeDate':
        return HomePlaylistsOrder.changeDate;
      case 'HomePlaylistsOrder.history':
        return HomePlaylistsOrder.history;
      default:
        return null;
    }
  }
}

enum HomePlaylistsFilter {
  both,
  playlists,
  smartlists,
}

extension HomePlaylistsFilterExtension on String {
  HomePlaylistsFilter? toHomePlaylistsFilter() {
    switch (this) {
      case 'HomePlaylistsFilter.both':
        return HomePlaylistsFilter.both;
      case 'HomePlaylistsFilter.playlists':
        return HomePlaylistsFilter.playlists;
      case 'HomePlaylistsFilter.smartlists':
        return HomePlaylistsFilter.smartlists;
      default:
        return null;
    }
  }
}