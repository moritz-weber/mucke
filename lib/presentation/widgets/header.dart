import 'package:flutter/material.dart';

import '../theming.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text('Home', style: TEXT_HEADER),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => null,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
