import 'dart:io';

import 'package:flutter/material.dart';

import '../domain/entities/album.dart';
import '../domain/entities/playable.dart';
import '../domain/entities/playlist.dart';
import '../domain/entities/smart_list.dart';
import '../domain/entities/song.dart';
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
  return likeCount == 3 ? LIGHT2 : Colors.white.withOpacity(0.24 + 0.18 * likeCount);
}

Color linkColor(Song song) {
  if (song.next && song.previous) {
    return LIGHT2;
  } else if (song.next) {
    return Colors.red;
  } else if (song.previous) {
    return Colors.blue;
  }
  return Colors.white24;
}

extension PlayableReprExt on Playable {
  String repr() {
    switch (type) {
      case PlayableType.all:
        return 'All songs';
      case PlayableType.album:
        return 'Album: $title';
      case PlayableType.artist:
        return 'Artist: $title';
      case PlayableType.playlist:
        return 'Playlist: $title';
      case PlayableType.smartlist:
        return 'Smartlist: $title';
      case PlayableType.search:
        return 'Search results: $title';
    }
  }
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