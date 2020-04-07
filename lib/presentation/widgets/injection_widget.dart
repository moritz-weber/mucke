import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:mosh/presentation/state/music_data_store.dart';
import 'package:mosh/system/datasources/audio_manager.dart';
import 'package:mosh/system/datasources/local_music_fetcher.dart';
import 'package:mosh/system/datasources/moor_music_data_source.dart';
import 'package:mosh/system/repositories/audio_repository_impl.dart';
import 'package:mosh/system/repositories/music_data_repository_impl.dart';
import 'package:provider/provider.dart';

class InjectionWidget extends StatelessWidget {
  const InjectionWidget({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Provider<MusicDataStore>(
      child: child,
      create: (BuildContext context) => MusicDataStore(
        musicDataRepository: MusicDataRepositoryImpl(
          localMusicFetcher: LocalMusicFetcherImpl(FlutterAudioQuery()),
          musicDataSource: MoorMusicDataSource(),
        ),
        audioRepository: AudioRepositoryImpl(AudioManagerImpl()),
      ),
    );
  }
}
