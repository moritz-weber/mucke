import 'home_widget.dart';

class HomeHistory implements HomeWidget {
  HomeHistory({required this.position, this.maxEntries = 3});

  @override
  HomeWidgetType get type => HomeWidgetType.history;

  @override
  int position;

  final int maxEntries;
}
