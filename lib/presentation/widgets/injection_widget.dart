import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';

import '../../domain/repositories/audio_repository.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../../system/datasources/audio_manager.dart';
import '../../system/datasources/local_music_fetcher.dart';
import '../../system/datasources/moor_music_data_source.dart';
import '../../system/repositories/audio_repository_impl.dart';
import '../../system/repositories/music_data_repository_impl.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';

class InjectionWidget extends StatelessWidget {
  const InjectionWidget({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    print('InjectionWidget.build');
    // TODO: this does not dispose correctly! use ProxyProvider

    final MusicDataRepository musicDataRepository = MusicDataRepositoryImpl(
      localMusicFetcher: LocalMusicFetcherImpl(FlutterAudioQuery()),
      musicDataSource: MoorMusicDataSource(),
    );

    final AudioRepository audioRepository =
        AudioRepositoryImpl(AudioManagerImpl());

    return MultiProvider(
      child: child,
      providers: [
        Provider<MusicDataStore>(
          create: (BuildContext context) => MusicDataStore(
            musicDataRepository: musicDataRepository,
          ),
        ),
        Provider<AudioStore>(
          create: (BuildContext context) => AudioStore(
            musicDataRepository: musicDataRepository,
            audioRepository: audioRepository,
          ),
        ),
        Provider<NavigationStore>(
          create: (BuildContext context) => NavigationStore(),
        ),
      ],
    );
  }
}
