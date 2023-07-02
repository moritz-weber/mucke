import 'package:flutter/material.dart';

import '../theming.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 24.0,
        bottom: 4.0,
      ),
      child: Text(
        text,
        style: TEXT_HEADER.underlined(
          textColor: Colors.white,
          underlineColor: LIGHT1,
          thickness: 4,
          distance: 8,
        ),
      ),
    );
  }
}