import 'home_widget.dart';

class HomeHistory implements HomeWidget {
  HomeHistory({required this.position, required this.maxEntries});

  @override
  HomeWidgetType get type => HomeWidgetType.history;

  @override
  int position;

  final int maxEntries;
}
