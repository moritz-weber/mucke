import 'package:flutter/material.dart';

class PlaylistCover extends StatelessWidget {
  const PlaylistCover({
    Key? key,
    required this.size,
    required this.gradient,
    required this.icon,
    this.shadows = const <BoxShadow>[],
  }) : super(key: key);

  final double size;
  final Gradient gradient;
  final IconData icon;
  final List<BoxShadow> shadows;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Container(
        clipBehavior: Clip.antiAlias,
        child: Center(
          child: Icon(
            icon,
            size: size / 2.0,
          ),
        ),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          boxShadow: shadows,
        ),
      ),
    );
  }
}
