import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/shuffle_mode.dart';
import '../mucke_icons.dart';
import '../state/audio_store.dart';

class ShuffleAllButton extends StatelessWidget {
  const ShuffleAllButton({
    Key? key,
    required this.shuffleMode,
  }) : super(key: key);

  final ShuffleMode shuffleMode;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return Container(
      constraints: const BoxConstraints.expand(height: 40.0),
      clipBehavior: Clip.none,
      child: ElevatedButton.icon(
        icon: Icon(
          shuffleMode == ShuffleMode.standard ? Icons.shuffle_rounded : MuckeIcons.shuffle_heart,
        ),
        label: const Text('SHUFFLE ALL'),
        onPressed: () => audioStore.shuffleAll(shuffleMode),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).highlightColor,
          elevation: 2.0,
          shape: const StadiumBorder(),
        ),
      ),
    );
  }
}
