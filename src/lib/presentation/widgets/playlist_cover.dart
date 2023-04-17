import 'package:flutter/material.dart';

class PlaylistCover extends StatelessWidget {
  const PlaylistCover({
    Key? key,
    required this.size,
    required this.gradient,
    required this.icon,
    this.shadows = const <BoxShadow>[],
    this.circle = false,
  }) : super(key: key);

  final double size;
  final Gradient gradient;
  final IconData icon;
  final List<BoxShadow> shadows;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    BoxDecoration deco;

    if (circle) {
      deco = BoxDecoration(
        gradient: gradient,
        shape: BoxShape.circle,
        boxShadow: shadows,
      );
    } else {
      deco = BoxDecoration(
        gradient: gradient,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: shadows,
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: Container(
        clipBehavior: Clip.antiAlias,
        child: Center(
          child: Icon(
            icon,
            size: size / 2.0,
            color: Colors.white,
          ),
        ),
        decoration: deco,
      ),
    );
  }
}
