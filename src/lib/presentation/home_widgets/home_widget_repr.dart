import 'package:flutter/material.dart';

import '../../domain/entities/home_widgets/home_widget.dart';

abstract class HomeWidgetRepr {
  HomeWidgetRepr(this.homeWidgetEntity, this.icon, this.hasParameters);

  final HomeWidget homeWidgetEntity;
  final bool hasParameters;
  final IconData icon;

  /// Whether the widget is displayed on the home page.
  ///
  /// Widgets that are not visible still appear in the home customization list.
  bool get isVisible;

  String title(BuildContext context);
  Widget widget();
  Widget? formPage();
}

/// Default visibility behaviour for home widgets: always visible.
mixin HomeWidgetVisibility implements HomeWidgetRepr {
  @override
  bool get isVisible => true;
}
