abstract class HomeWidget {
  HomeWidgetType get type;
  late int position;
}

enum HomeWidgetType {
  shuffle_all,
  album_of_day,
  artist_of_day,
  playlists,
  history,
}

extension HomeWidgetTypeExtension on String {
  HomeWidgetType toHomeWidgetType() {
    switch (this) {
      case 'HomeWidgetType.shuffle_all':
        return HomeWidgetType.shuffle_all;
      case 'HomeWidgetType.album_of_day':
        return HomeWidgetType.album_of_day;
      case 'HomeWidgetType.artist_of_day':
        return HomeWidgetType.artist_of_day;
      case 'HomeWidgetType.playlists':
        return HomeWidgetType.playlists;
      case 'HomeWidgetType.history':
        return HomeWidgetType.history;
      default:
        throw TypeError();
    }
  }
}