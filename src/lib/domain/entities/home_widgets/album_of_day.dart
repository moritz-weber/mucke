import 'home_widget.dart';

class HomeAlbumOfDay implements HomeWidget {
  HomeAlbumOfDay({required this.position});

  @override
  HomeWidgetType get type => HomeWidgetType.album_of_day;

  @override
  int position;
}
