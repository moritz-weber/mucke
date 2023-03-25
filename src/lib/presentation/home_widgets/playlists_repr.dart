import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

import '../../domain/entities/home_widgets/playlists.dart';
import 'forms/playlists_form_page.dart';
import 'home_widget_repr.dart';
import 'widgets/playlists_widget.dart';

class PlaylistsRepr implements HomeWidgetRepr {
  const PlaylistsRepr(this.homeWidgetEntity);

  factory PlaylistsRepr.fromPosition(int position) {
    return PlaylistsRepr(HomePlaylists(position: position));
  }

  @override
  Widget? formPage() => PlaylistsFormPage(playlists: homeWidgetEntity);

  @override
  final HomePlaylists homeWidgetEntity;

  @override
  bool get hasParameters => true;

  @override
  IconData get icon => Icons.playlist_play_rounded;

  @override
  String title(BuildContext context) => L10n.of(context)!.playlists;
  
  @override
  Widget widget() => PlaylistsWidget(homePlaylists: homeWidgetEntity);
}
