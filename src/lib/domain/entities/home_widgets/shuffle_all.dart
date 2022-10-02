import '../shuffle_mode.dart';
import 'home_widget.dart';

class HomeShuffleAll implements HomeWidget {
  HomeShuffleAll({required this.position, required this.shuffleMode});

  @override
  HomeWidgetType get type => HomeWidgetType.shuffle_all;

  @override
  int position;

  final ShuffleMode shuffleMode;
}
