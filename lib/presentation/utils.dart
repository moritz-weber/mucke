import 'dart:io';

import 'package:flutter/material.dart';

ImageProvider getAlbumImage(String albumArtPath) {
  // return Image.asset('assets/no_cover.png');

  if (albumArtPath == null || !File(albumArtPath).existsSync()) {
    return const AssetImage('assets/no_cover.png');
  }
  return FileImage(File(albumArtPath));
}

String msToTimeString(int milliseconds) {
  String twoDigits(num n) {
    if (n >= 10) {
      return '$n';
    }
    return '0$n';
  }

  final Duration duration = Duration(seconds: (milliseconds / 1000).round());

  final int hours = duration.inHours;
  final int minutes = duration.inMinutes.remainder(60) as int;
  
  final String twoDigitMinutes = twoDigits(minutes);
  final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

  if (hours > 0) {
    return '$hours:$twoDigitMinutes:$twoDigitSeconds';
  }
  return '$minutes:$twoDigitSeconds';
}
