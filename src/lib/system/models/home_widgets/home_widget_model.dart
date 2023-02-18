import '../../../domain/entities/home_widgets/home_widget.dart';
import '../../datasources/drift_database.dart';

abstract class HomeWidgetModel extends HomeWidget {
  HomeWidgetsCompanion toDrift() {
    throw UnimplementedError();
  }
}
