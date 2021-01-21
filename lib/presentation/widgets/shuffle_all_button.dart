import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/audio_store.dart';

class ShuffleAllButton extends StatelessWidget {
  const ShuffleAllButton({Key key, this.verticalPad, this.horizontalPad}) : super(key: key);

  final double verticalPad;
  final double horizontalPad;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Container(
      constraints: BoxConstraints.expand(height: 40.0 + verticalPad * 2),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPad,
          horizontal: horizontalPad,
        ),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.shuffle),
          label: const Text('SHUFFLE ALL'),
          onPressed: () => audioStore.shuffleAll(),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
