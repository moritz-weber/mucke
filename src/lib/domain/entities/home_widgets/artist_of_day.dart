import '../shuffle_mode.dart';
import 'home_widget.dart';

class HomeArtistOfDay implements HomeWidget {
  HomeArtistOfDay({required this.position, this.shuffleMode = ShuffleMode.plus});

  @override
  HomeWidgetType get type => HomeWidgetType.artist_of_day;

  @override
  int position;

  final ShuffleMode shuffleMode;
}
