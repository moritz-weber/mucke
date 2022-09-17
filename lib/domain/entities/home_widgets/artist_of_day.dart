import '../shuffle_mode.dart';
import 'home_widget.dart';

class HomeArtistOfDay implements HomeWidget {
  HomeArtistOfDay(this.position, this.shuffleMode);

  @override
  HomeWidgetType get type => HomeWidgetType.artist_of_day;

  @override
  int position;

  final ShuffleMode shuffleMode;
}
