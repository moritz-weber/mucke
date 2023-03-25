import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

import '../../domain/entities/home_widgets/shuffle_all.dart';
import 'forms/shuffle_all_form_page.dart';
import 'home_widget_repr.dart';
import 'widgets/shuffle_all_button.dart';

class ShuffleAllRepr implements HomeWidgetRepr {
  const ShuffleAllRepr(this.homeWidgetEntity);

  factory ShuffleAllRepr.fromPosition(int position) {
    return ShuffleAllRepr(HomeShuffleAll(position: position));
  }

  @override
  Widget? formPage() => ShuffleAllFormPage(shuffleAll: homeWidgetEntity);

  @override
  final HomeShuffleAll homeWidgetEntity;

  @override
  bool get hasParameters => true;

  @override
  IconData get icon => Icons.shuffle_rounded;

  @override
  String title(BuildContext context) => L10n.of(context)!.shuffleAll;

  @override
  Widget widget() {
    return ShuffleAllButton(shuffleMode: homeWidgetEntity.shuffleMode);
  }
}
