import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

import '../../domain/entities/home_widgets/history.dart';
import 'forms/history_form_page.dart';
import 'home_widget_repr.dart';
import 'widgets/history_widget.dart';

class HistoryRepr implements HomeWidgetRepr {
  HistoryRepr(this.homeWidgetEntity);

  factory HistoryRepr.fromPosition(int position) {
    return HistoryRepr(HomeHistory(position: position));
  }

  @override
  Widget? formPage() => HistoryFormPage(history: homeWidgetEntity);

  @override
  final HomeHistory homeWidgetEntity;

  @override
  bool get hasParameters => true;

  @override
  IconData get icon => Icons.history_rounded;

  @override
  String title(BuildContext context) => L10n.of(context)!.history;
  
  @override
  Widget widget() => HistoryWidget(history: homeWidgetEntity);
}
