import 'dart:math';

import 'package:mucke/domain/entities/song.dart';

String toVarName(String text) {
  final cleanedText = text.replaceAll(RegExp(r'[^A-Za-z ]'), '').trim();
  final split = cleanedText.split(' ');
  String camelCase = split[0].toLowerCase();
  for (int i = 1; i < min(split.length, 3); i++) {
    camelCase += split[i].substring(0, 1).toUpperCase() + split[i].substring(1);
  }
  return camelCase;
}

extension ToCodeExtension on Song {
  String toCode() => """final ${toVarName(album)}$trackNumber = Song(
    album: '$album',
    albumId: $albumId,
    artist: '$artist',
    blockLevel: $blockLevel,
    duration: const Duration(milliseconds: ${duration.inMilliseconds}),
    path: '$path',
    title: '$title',
    likeCount: $likeCount,
    playCount: $playCount,
    discNumber: $discNumber,
    next: $next,
    previous: $previous,
    timeAdded: DateTime.fromMillisecondsSinceEpoch(${timeAdded.millisecondsSinceEpoch}),
    trackNumber: $trackNumber,
    albumArtPath: '$albumArtPath',
    color: const $color,
    year: $year,
  );""";
}