import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

import '../../domain/entities/home_widgets/artist_of_day.dart';
import 'forms/artistofday_form_page.dart';
import 'home_widget_repr.dart';
import 'widgets/artist_of_day_widget.dart';

class ArtistOfDayRepr implements HomeWidgetRepr {
  ArtistOfDayRepr(this.homeWidgetEntity);

  factory ArtistOfDayRepr.fromPosition(int position) {
    return ArtistOfDayRepr(HomeArtistOfDay(position: position));
  }

  @override
  Widget? formPage() => ArtistOfDayFormPage(artistOfDay: homeWidgetEntity);

  @override
  final HomeArtistOfDay homeWidgetEntity;

  @override
  bool get hasParameters => true;

  @override
  IconData get icon => Icons.person_rounded;

  @override
  String title(BuildContext context) => L10n.of(context)!.artistOfTheDay;

  @override
  Widget widget() {
    return ArtistOfDayWidget(shuffleMode: homeWidgetEntity.shuffleMode);
  }
}
