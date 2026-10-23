import 'package:flutter/material.dart';
import 'package:mucke/l10n/localizations.dart';

import '../../domain/entities/home_widgets/whats_new.dart';
import 'forms/whats_new_form_page.dart';
import 'home_widget_repr.dart';
import 'widgets/whats_new_widget.dart';

class WhatsNewRepr with HomeWidgetVisibility implements HomeWidgetRepr {
  WhatsNewRepr(this.homeWidgetEntity);

  factory WhatsNewRepr.fromPosition(int position) {
    return WhatsNewRepr(HomeWhatsNew(position: position));
  }

  @override
  Widget? formPage() => WhatsNewFormPage(whatsNew: homeWidgetEntity);

  @override
  final HomeWhatsNew homeWidgetEntity;

  @override
  bool get hasParameters => true;

  @override
  bool get isVisible => !homeWidgetEntity.dismissed;

  @override
  IconData get icon => Icons.new_releases_rounded;

  @override
  String title(BuildContext context) => L10n.of(context)!.whatsNew;

  @override
  Widget widget() => const WhatsNewWidget();
}
