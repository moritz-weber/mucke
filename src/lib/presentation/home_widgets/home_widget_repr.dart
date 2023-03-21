
import 'package:flutter/material.dart';

import '../../domain/entities/home_widgets/home_widget.dart';

abstract class HomeWidgetRepr {
  HomeWidgetRepr(this.homeWidgetEntity, this.icon, this.hasParameters);

  final HomeWidget homeWidgetEntity;
  final bool hasParameters;
  final IconData icon;
  
  String title(BuildContext context);
  Widget widget();
  Widget? formPage();
}