import 'dart:collection';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

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

/// Try to find an appropriate background color for the image
/// colors are ranked by their colorfulness (saturation) 
/// and by how much they appear in the image
Color getBackgroundColor(img.Image image) {
  image = img.quantize(image,
      numberOfColors: 8, method: img.QuantizeMethod.octree);
  image = image.convert(format: img.Format.uint8, numChannels: 4);
  final data = image.getBytes(order: img.ChannelOrder.rgba);
  final counts = HashMap<int, int>();
  for (var i = 0; i < data.length; i += 4) {
    final argb = data[i] + (data[i+1] << 8) + (data[i+2] << 16) + (data[i+3] << 24);
    counts[argb] = (counts[argb] ?? 0) + 1;
  }

  final sortedColors = counts.keys.toList()..sort(
    (a, b) => 
      colorWeight(b, counts[b]!)
        .compareTo(colorWeight(a, counts[a]!))
  );
  return Color(sortedColors.first);
}


double colorWeight(int color, int count) {
  final saturation = HSLColor.fromColor(Color(color)).saturation;
  return saturation * count;
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
