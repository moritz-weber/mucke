import 'dart:io';

import 'package:flutter/material.dart';

import 'mucke_icons.dart';

ImageProvider getAlbumImage(String? albumArtPath) {
  // return Image.asset('assets/no_cover.png');

  if (albumArtPath == null || !File(albumArtPath).existsSync()) {
    return const AssetImage('assets/no_cover.png');
  }
  return FileImage(File(albumArtPath));
}

String msToTimeString(Duration duration) {
  String twoDigits(num n) {
    if (n >= 10) {
      return '$n';
    }
    return '0$n';
  }

  final int hours = duration.inHours;
  final int minutes = duration.inMinutes.remainder(60);

  final String twoDigitMinutes = twoDigits(minutes);
  final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

  if (hours > 0) {
    return '$hours:$twoDigitMinutes:$twoDigitSeconds';
  }
  return '$minutes:$twoDigitSeconds';
}

String? validateNumber(bool enabled, String number) {
  if (!enabled) return null;
  return int.tryParse(number) == null ? 'Error' : null;
}

IconData blockLevelIcon(int blockLevel) {
  switch (blockLevel) {
    case 1:
      return MuckeIcons.exclude_shuffle_all;
    case 2:
      return MuckeIcons.exclude_shuffle;
    case 3:
      return MuckeIcons.exclude_always;
    default:
      return MuckeIcons.exclude_never;
  }
}

const _LIKE_COUNT_ICONS = [
  Icons.favorite_border_rounded,
  MuckeIcons.favorite_1_3,
  MuckeIcons.favorite_2_3,
  Icons.favorite_rounded
];

IconData likeCountIcon(int likeCount) {
  return _LIKE_COUNT_ICONS[likeCount];
}
