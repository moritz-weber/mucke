import 'home_widget.dart';

class HomeWhatsNew implements HomeWidget {
  HomeWhatsNew({
    required this.position,
    this.dismissed = false,
    this.autoDismiss = true,
  });

  @override
  HomeWidgetType get type => HomeWidgetType.whats_new;

  @override
  int position;

  /// Whether the user dismissed the widget.
  bool dismissed;

  /// Whether the widget is dismissed automatically when the release notes are viewed.
  bool autoDismiss;
}
