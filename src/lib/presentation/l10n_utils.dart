import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

import '../domain/entities/playable.dart';
import '../domain/entities/shuffle_mode.dart';

extension PlayableTextExtension on PlayableType {
  String toText(BuildContext context) {
    switch (this) {
      case PlayableType.all:
        return L10n.of(context)!.allSongs;
      case PlayableType.album:
        return L10n.of(context)!.album;
      case PlayableType.artist:
        return L10n.of(context)!.artist;
      case PlayableType.playlist:
        return L10n.of(context)!.playlist;
      case PlayableType.smartlist:
        return L10n.of(context)!.smartlist;
      case PlayableType.search:
        return L10n.of(context)!.search;
    }
  }
}

extension ShuffleTextExtension on ShuffleMode {
  String toText(BuildContext context) {
    switch (this) {
      case ShuffleMode.none:
        return L10n.of(context)!.normalMode;
      case ShuffleMode.standard:
        return L10n.of(context)!.shuffleMode;
      case ShuffleMode.plus:
        return L10n.of(context)!.favShuffleMode;
    }
  }
}
