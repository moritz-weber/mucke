import '../shuffle_mode.dart';
import 'home_widget.dart';

class HomeShuffleAll implements HomeWidget {
  HomeShuffleAll({required this.position, this.shuffleMode = ShuffleMode.plus});

  @override
  HomeWidgetType get type => HomeWidgetType.shuffle_all;

  @override
  int position;

  final ShuffleMode shuffleMode;
}
