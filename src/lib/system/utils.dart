import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

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
Color getBackgroundColor(img.Image image) {
  image = img.quantize(image,
      numberOfColors: 16, method: img.QuantizeMethod.octree);
  image = image.convert(format: img.Format.uint8, numChannels: 4);
  final data = image.getBytes(order: img.ChannelOrder.rgba);
  final counts = HashMap<Color, int>();
  for (var i = 0; i < data.length; i += 4) {
    final argb = Color.fromARGB(data[i + 3], data[i], data[i+1], data[i+2]);
    counts[argb] = (counts[argb] ?? 0) + 1;
  }

  final sortedColors = counts.keys.toList()..sort(
    (a, b) => 
      colorWeight(b, counts[b]!)
        .compareTo(colorWeight(a, counts[a]!))
  );
  return sortedColors.first;
}

/// This function weighs colors and gives them a rating.
/// The higher the rating the better it works as an accent color
/// It prefers colors that are contained a lot in the image.
/// Colors that are really colorful (i.e. have a lot of saturation)
/// are weighted more than grayscale colors and colors that are too light
/// or too dark are weighted down.
num colorWeight(Color color, int count) {
  final hslColor = HSLColor.fromColor(color);
  return count * pow(hslColor.saturation, 2) * (0.55 - (hslColor.lightness - 0.55).abs());
}