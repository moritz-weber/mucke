import 'home_widget.dart';

class HomePlaylists implements HomeWidget {
  HomePlaylists(this.position);

  @override
  HomeWidgetType get type => HomeWidgetType.playlists;

  @override
  int position;
}
