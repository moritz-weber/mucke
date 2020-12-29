import 'package:audio_service/audio_service.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart' as ja;

import 'domain/repositories/audio_repository.dart';
import 'domain/repositories/music_data_repository.dart';
import 'domain/repositories/persistent_player_state_repository.dart';
import 'domain/repositories/settings_repository.dart';
import 'presentation/state/audio_store.dart';
import 'presentation/state/music_data_store.dart';
import 'presentation/state/navigation_store.dart';
import 'system/audio/audio_handler.dart';
import 'system/audio/audio_manager.dart';
import 'system/audio/audio_manager_contract.dart';
import 'system/audio/audio_player_contract.dart';
import 'system/audio/audio_player_impl.dart';
import 'system/audio/queue_generator.dart';
import 'system/datasources/local_music_fetcher.dart';
import 'system/datasources/local_music_fetcher_contract.dart';
import 'system/datasources/moor_music_data_source.dart';
import 'system/datasources/music_data_source_contract.dart';
import 'system/datasources/player_state_data_source.dart';
import 'system/datasources/settings_data_source.dart';
import 'system/repositories/audio_repository_impl.dart';
import 'system/repositories/music_data_repository_impl.dart';
import 'system/repositories/persistent_player_state_repository_impl.dart';
import 'system/repositories/settings_repository_impl.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  print('setupGetIt');

  // stores
  getIt.registerFactory<MusicDataStore>(
    () {
      final musicDataStore = MusicDataStore(
        musicDataRepository: getIt(),
        settingsRepository: getIt(),
      );
      musicDataStore.init();
      return musicDataStore;
    },
  );
  getIt.registerFactory<AudioStore>(
    () {
      final audioStore = AudioStore(
        audioRepository: getIt(),
        persistentPlayerStateRepository: getIt(),
      );
      return audioStore;
    },
  );
  getIt.registerFactory<NavigationStore>(
    () {
      final navigationStore = NavigationStore();
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
  getIt.registerLazySingleton<PlayerStateRepository>(
    () => PlayerStateRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(getIt()));

  // data sources
  final MoorMusicDataSource moorMusicDataSource = MoorMusicDataSource();
  getIt.registerLazySingleton<MusicDataSource>(() => moorMusicDataSource);
  getIt.registerLazySingleton<PlayerStateDataSource>(() => moorMusicDataSource.playerStateDao);
  getIt.registerLazySingleton<SettingsDataSource>(() => moorMusicDataSource.settingsDao);
  getIt.registerLazySingleton<LocalMusicFetcher>(
    () => LocalMusicFetcherImpl(
      getIt(),
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<AudioManager>(() => AudioManagerImpl(getIt()));

  final AudioPlayer audioPlayer = AudioPlayerImpl(
    ja.AudioPlayer(),
    QueueGenerator(getIt()),
  );
  getIt.registerLazySingleton<AudioPlayer>(() => audioPlayer);

  final _audioHandler = await AudioService.init(
    builder: () => MyAudioHandler(getIt(), getIt(), getIt()),
    config: AudioServiceConfig(
      androidNotificationChannelName: 'mucke',
      androidEnableQueue: true,
    ),
  );
  getIt.registerLazySingleton<AudioHandler>(() => _audioHandler);

  getIt.registerLazySingleton<QueueGenerator>(() => QueueGenerator(getIt()));

  // external
  getIt.registerFactory<ja.AudioPlayer>(() => ja.AudioPlayer());

  getIt.registerLazySingleton<FlutterAudioQuery>(() => FlutterAudioQuery());

  getIt.registerLazySingleton<DeviceInfoPlugin>(() => DeviceInfoPlugin());
}
