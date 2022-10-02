import 'package:rxdart/rxdart.dart';

import '../entities/home_widgets/home_widget.dart';

abstract class HomeWidgetRepository {

  ValueStream<List<HomeWidget>> get homeWidgetsStream;

  Future<void> insertHomeWidget(HomeWidget homeWidget);
  Future<void> moveHomeWidget(int oldPosition, int newPosition);
  /// Cannot be used to change the position of a widget!
  Future<void> updateHomeWidget(HomeWidget homeWidget);
  Future<void> removeHomeWidget(HomeWidget homeWidget);
}