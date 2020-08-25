import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/audio_store.dart';

class ShuffleAllButton extends StatelessWidget {
  const ShuffleAllButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return RaisedButton(
      child: const Text('Shuffle All'),
      onPressed: () => audioStore.shuffleAll(),
      color: Theme.of(context).accentColor,
    );
  }
}
