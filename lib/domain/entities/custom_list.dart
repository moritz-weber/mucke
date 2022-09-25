import 'package:flutter/material.dart';

import '../../presentation/gradients.dart';
import '../../presentation/icons.dart';
import 'shuffle_mode.dart';

class CustomList {
  const CustomList(
    this.name,
    this.iconString,
    this.gradientString,
    this.shuffleMode,
    this.timeCreated,
    this.timeChanged,
    this.timeLastPlayed,
  );

  final String name;
  final String iconString;
  final String gradientString;
  final ShuffleMode? shuffleMode;

  final DateTime timeCreated;
  final DateTime timeChanged;
  final DateTime timeLastPlayed;

  IconData get icon => CUSTOM_ICONS[iconString]!;
  Gradient get gradient => CUSTOM_GRADIENTS[gradientString]!;
}
