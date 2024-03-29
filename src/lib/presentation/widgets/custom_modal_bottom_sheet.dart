import 'package:flutter/material.dart';

import '../theming.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({Key? key, required this.widgets}) : super(key: key);

  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    final int count = 2 * widgets.length - 1;

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Material(
          color: DARK25,
          child: ListView(
            // TODO: evaluate list view here
            // mainAxisSize: MainAxisSize.min,
            shrinkWrap: true,
            children: List.generate(count, (index) {
              if (index.isEven) {
                return widgets[index ~/ 2];
              } else {
                return Container(
                  height: 1,
                  color: DARK2,
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
