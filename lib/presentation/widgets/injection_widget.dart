import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../injection_container.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';

class InjectionWidget extends StatelessWidget {
  const InjectionWidget({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    print('InjectionWidget.build');
    
    return MultiProvider(
      child: child,
      providers: [
        Provider<MusicDataStore>(
          create: (_) => getIt<MusicDataStore>(),
        ),
        Provider<AudioStore>(
          create: (_) => getIt<AudioStore>(),
        ),
        Provider<NavigationStore>(
          create: (_) => getIt<NavigationStore>(),
        ),
      ],
    );
  }
}
