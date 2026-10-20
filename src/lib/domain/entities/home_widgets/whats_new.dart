import 'home_widget.dart';

class HomeWhatsNew implements HomeWidget {
  HomeWhatsNew({required this.position});

  @override
  HomeWidgetType get type => HomeWidgetType.whats_new;

  @override
  int position;
}
