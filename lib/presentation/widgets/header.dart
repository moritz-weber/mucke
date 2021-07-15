import 'package:flutter/material.dart';

import '../theming.dart';

class Header extends StatelessWidget {
  const Header({Key? key, required this.title, this.onPressed}) : super(key: key);

  final String title;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(title, style: TEXT_HEADER),
        if (onPressed != null)
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => onPressed!(),
          ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
