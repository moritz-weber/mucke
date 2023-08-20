import 'dart:io';

import 'package:flutter/material.dart';

import '../domain/entities/album.dart';
import '../domain/entities/playable.dart';
import '../domain/entities/playlist.dart';
import '../domain/entities/smart_list.dart';
import 'gradients.dart';
import 'mucke_icons.dart';
import 'theming.dart';
import 'widgets/playlist_cover.dart';

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

Color bgColor(Color? color) => Color.lerp(DARK3, color, 0.4) ?? DARK3;

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

Color blockLevelColor(int blockLevel) {
  return blockLevel == 0 ? Colors.white24 : Colors.white;
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

Color likeCountColor(int likeCount) {
  return likeCount == 3 ? LIGHT1 : Colors.white.withOpacity(0.24 + 0.18 * likeCount);
}

IconData linkIcon(bool prev, bool next) {
  if (prev && next) {
    return MuckeIcons.link_both;
  } else if (prev) {
    return MuckeIcons.link_prev;
  } else if (next) {
    return MuckeIcons.link_next;
  }
  return Icons.link_off_rounded;
}

Color linkColor(bool prev, bool next) {
  if (next && prev) {
    return LIGHT1;
  } else if (next) {
    return Colors.red;
  } else if (prev) {
    return Colors.blue;
  }
  return Colors.white24;
}

Widget createPlayableCover(Playable playable, double size) {
  switch (playable.type) {
    case PlayableType.all:
      return PlaylistCover(
          size: size, gradient: CUSTOM_GRADIENTS['toxic']!, icon: Icons.all_inclusive_rounded);
    case PlayableType.album:
      playable as Album;
      return SizedBox(
        width: size,
        height: size,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Image(
            image: getAlbumImage(playable.albumArtPath),
            fit: BoxFit.cover,
          ),
        ),
      );
    case PlayableType.artist:
      return PlaylistCover(
        gradient: CUSTOM_GRADIENTS['kashmir']!,
        icon: Icons.person_rounded,
        size: size,
        circle: true,
      );
    case PlayableType.playlist:
      playable as Playlist;
      return PlaylistCover(size: size, gradient: playable.gradient, icon: playable.icon);
    case PlayableType.smartlist:
      playable as SmartList;
      return PlaylistCover(size: size, gradient: playable.gradient, icon: playable.icon);
    case PlayableType.search:
      return PlaylistCover(
        size: size,
        gradient: CUSTOM_GRADIENTS['cactus']!,
        icon: Icons.search_rounded,
      );
  }
}

double? getProgressOrNull(int? numerator, int? denominator) {
  if (numerator == null || denominator == null) return null;
  return numerator / denominator;
}
