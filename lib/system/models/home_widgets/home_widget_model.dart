import '../../../domain/entities/home_widgets/home_widget.dart';
import '../../datasources/moor_database.dart';

abstract class HomeWidgetModel extends HomeWidget {
  HomeWidgetsCompanion toMoor() {
    throw UnimplementedError();
  }
}
