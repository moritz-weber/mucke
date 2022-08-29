import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../presentation/gradients.dart';
import '../../presentation/icons.dart';
import 'playable.dart';
import 'shuffle_mode.dart';
import 'song.dart';

class Playlist extends Equatable implements Playable {
  const Playlist({
    required this.id,
    required this.name,
    required this.songs,
    required this.iconString,
    required this.gradientString,
    this.shuffleMode,
  });

  final int id;
  final String name;
  final List<Song> songs;
  final ShuffleMode? shuffleMode;
  final String iconString;
  final String gradientString;
  IconData get icon => CUSTOM_ICONS[iconString]!;
  Gradient get gradient => CUSTOM_GRADIENTS[gradientString]!;

  @override
  List<Object?> get props => [id, name, iconString, gradientString];

  @override
  PlayableType get type => PlayableType.playlist;
}
