import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui' as ui;

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

// TODO: quantize colors and pick a colorful one (not graypace)
Color getBackgroundColor(Uint8List data) {
  final counts = HashMap<int, int>();
  for (var i = 0; i < data.length; i += 4) {
    final argb = data[i] + (data[i+1] << 8) + (data[i+2] << 16) + (data[i+3] << 24);
    counts[argb] = (counts[argb] ?? 0) + 1;
  }

  final sortedColors = counts.keys.toList()
    ..sort((a, b) => counts[b]!.compareTo(counts[a]!));
  final top10colors = sortedColors.take(10).map((argb) => Color(argb));
  final brightestColor = top10colors.sorted((a, b) => ((a.computeLuminance() - b.computeLuminance()) * 100.0).round()).last;
  return brightestColor;
}

Future<Color?> _getBackgroundColor(ui.Image image) async {
  final paletteGenerator = await PaletteGenerator.fromImage(
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
