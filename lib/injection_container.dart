import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get_it/get_it.dart';
import 'package:moor/isolate.dart';
import 'package:moor/moor.dart';

import 'domain/repositories/audio_repository.dart';
import 'domain/repositories/music_data_repository.dart';
import 'presentation/state/audio_store.dart';
import 'presentation/state/music_data_store.dart';
import 'presentation/state/navigation_store.dart';
import 'system/datasources/audio_manager.dart';
import 'system/datasources/audio_manager_contract.dart';
import 'system/datasources/local_music_fetcher.dart';
import 'system/datasources/local_music_fetcher_contract.dart';
import 'system/datasources/moor_music_data_source.dart';
import 'system/datasources/music_data_source_contract.dart';
import 'system/repositories/audio_repository_impl.dart';
import 'system/repositories/music_data_repository_impl.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  print('setupGetIt');

  // stores
  getIt.registerFactory<MusicDataStore>(
    () {
      final musicDataStore = MusicDataStore(
        musicDataRepository: getIt(),
      );
      musicDataStore.init();
      return musicDataStore;
    },
  );
  getIt.registerFactory<AudioStore>(
    () {
      final audioStore = AudioStore(
        audioRepository: getIt(),
        musicDataRepository: getIt(),
      );
      audioStore.init();
      return audioStore;
    },
  );
  getIt.registerFactory<NavigationStore>(
    () {
      final navigationStore = NavigationStore();
      navigationStore.init();
      return navigationStore;
    },
  );

  // repositories
  getIt.registerLazySingleton<MusicDataRepository>(
    () => MusicDataRepositoryImpl(
      localMusicFetcher: getIt(),
      musicDataSource: getIt(),
    ),
  );
  getIt.registerLazySingleton<AudioRepository>(
    () => AudioRepositoryImpl(
      getIt(),
    ),
  );

  // data sources
  final MoorIsolate moorIsolate = await createMoorIsolate();
  final DatabaseConnection databaseConnection = await moorIsolate.connect();
  final MoorMusicDataSource moorMusicDataSource = MoorMusicDataSource.connect(databaseConnection);
  getIt.registerLazySingleton<MusicDataSource>(() => moorMusicDataSource);
  getIt.registerLazySingleton<LocalMusicFetcher>(
    () => LocalMusicFetcherImpl(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<AudioManager>(() => AudioManagerImpl());

  // external
  getIt.registerLazySingleton<FlutterAudioQuery>(() => FlutterAudioQuery());
}
