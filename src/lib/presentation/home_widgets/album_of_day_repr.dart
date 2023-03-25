import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

import '../../domain/entities/home_widgets/album_of_day.dart';
import 'home_widget_repr.dart';
import 'widgets/album_of_day_widget.dart';

class AlbumOfDayRepr implements HomeWidgetRepr {
  AlbumOfDayRepr(this.homeWidgetEntity);

  factory AlbumOfDayRepr.fromPosition(int position) {
    return AlbumOfDayRepr(HomeAlbumOfDay(position: position));
  }

  @override
  Widget? formPage() => null;

  @override
  final HomeAlbumOfDay homeWidgetEntity;

  @override
  bool get hasParameters => false;

  @override
  IconData get icon => Icons.album_rounded;

  @override
  String title(BuildContext context) => L10n.of(context)!.albumOfTheDay;
  
  @override
  Widget widget() {
    return const AlbumOfDayWidget();
  }
}
