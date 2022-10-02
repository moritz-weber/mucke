import 'package:flutter/material.dart';

import '../../domain/entities/shuffle_mode.dart';
import '../mucke_icons.dart';
import '../theming.dart';

class PlayShuffleButton extends StatelessWidget {
  const PlayShuffleButton({
    Key? key,
    this.size = 48.0,
    required this.onPressed,
    this.shuffleMode,
  }) : super(key: key);

  /// Main icon size will be reduced by 8.
  final double size;
  final ShuffleMode? shuffleMode;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    IconData? icon;
    switch (shuffleMode) {
      case ShuffleMode.standard:
        icon = Icons.shuffle_rounded;
        break;
      case ShuffleMode.plus:
        icon = MuckeIcons.shuffle_heart;
        break;
      case ShuffleMode.none:
        icon = MuckeIcons.shuffle_none;
        break;
      default:
    }

    return Container(
      color: Colors.transparent,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: [
            Center(
              child: IconButton(
                icon: Icon(
                  Icons.play_circle_filled_rounded,
                  size: size - 8.0,
                ),
                iconSize: size - 8.0,
                onPressed: () => onPressed(),
                padding: EdgeInsets.zero,
                splashRadius: size / 2 + 2.0,
              ),
            ),
            if (icon != null) Positioned(
              right: 2.0,
              bottom: 2.0,
              child: GestureDetector(
                onTap: () => onPressed(),
                child: Container(
                  width: size / 2.5,
                  height: size / 2.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size / 5),
                    color: LIGHT1,
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: (size / 2.5) * 0.66,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
