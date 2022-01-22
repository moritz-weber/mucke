import 'package:flutter/material.dart';

import '../theming.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({Key? key, required this.widgets}) : super(key: key);

  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    final int count = 2 * widgets.length - 1;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: DARK3,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 1)),
          ],
        ),
        child: Column(
          // TODO: evaluate list view here
          mainAxisSize: MainAxisSize.min,
          children: List.generate(count, (index) {
            if (index.isEven) {
              return widgets[(index / 2).round()];
            } else {
              return Container(
                height: 1,
                color: Colors.white10,
              );
            }
          }),
        ),
      ),
    );
  }
}

class CustomModalBottomSheet {
  void call(BuildContext context, List<Widget> widgets) {
    final int count = 2 * widgets.length - 1;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: DARK3,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 1)),
              ],
            ),
            child: Column(
              // TODO: evaluate list view here
              mainAxisSize: MainAxisSize.min,
              children: List.generate(count, (index) {
                if (index.isEven) {
                  return widgets[(index / 2).round()];
                } else {
                  return Container(
                    height: 1,
                    color: Colors.white10,
                  );
                }
              }),
            ),
          ),
        );
      },
    );
  }
}
