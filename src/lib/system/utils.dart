import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

int? parseYear(String? yearString) {
  if (yearString == null || yearString == '') {
    return null;
  }

  try {
    return int.parse(yearString);
  } on FormatException {
    return int.parse(yearString.split('-')[0]);
  }
}

Future<Color?> getBackgroundColor(ImageProvider image) async {
  return const Color(0xff141216);

  final paletteGenerator = await PaletteGenerator.fromImageProvider(
    image,
    targets: PaletteTarget.baseTargets,
  );
  
  final colors = <Color?>[
    paletteGenerator.vibrantColor?.color,
    paletteGenerator.lightVibrantColor?.color,
    paletteGenerator.mutedColor?.color,
    paletteGenerator.darkVibrantColor?.color,
    paletteGenerator.lightMutedColor?.color,
    paletteGenerator.dominantColor?.color
  ];

  return colors.firstWhereOrNull((c) => c != null);
}
