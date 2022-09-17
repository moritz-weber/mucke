import '../models/home_widgets/home_widget_model.dart';

abstract class HomeWidgetDataSource {
  Stream<List<HomeWidgetModel>> get homeWidgetsStream;

  Future<void> insertHomeWidget(HomeWidgetModel homeWidget);
  Future<void> moveHomeWidget(int oldPosition, int newPosition);
  Future<void> updateHomeWidget(HomeWidgetModel homeWidget);
  Future<void> removeHomeWidget(HomeWidgetModel homeWidget);
}
