import 'package:flutter/material.dart';

import '../theming.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.text,
    this.margin = const EdgeInsets.symmetric(
      horizontal: HORIZONTAL_PADDING,
      vertical: 8.0,
    ),
  });

  final String text;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(Icons.info_rounded),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
