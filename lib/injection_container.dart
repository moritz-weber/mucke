import 'package:audio_service/audio_service.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';

import 'domain/actors/audio_player_actor.dart';
import 'domain/actors/platform_integration_actor.dart';
import 'domain/modules/queue_generator.dart';
import 'domain/repositories/audio_player_repository.dart';
import 'domain/repositories/music_data_modifier_repository.dart';
import 'domain/repositories/music_data_repository.dart';
import 'domain/repositories/persistent_player_state_repository.dart';
import 'domain/repositories/platform_integration_repository.dart';
import 'domain/repositories/settings_repository.dart';
import 'domain/usecases/handle_playback_state.dart';
import 'domain/usecases/pause.dart';
import 'domain/usecases/play.dart';
import 'domain/usecases/play_songs.dart';
import 'domain/usecases/seek_to_next.dart';
import 'domain/usecases/seek_to_previous.dart';
import 'domain/usecases/set_current_song.dart';
import 'domain/usecases/set_loop_mode.dart';
import 'domain/usecases/shuffle_all.dart';
import 'domain/usecases/update_database.dart';
import 'presentation/state/audio_store.dart';
import 'presentation/state/music_data_store.dart';
import 'presentation/state/navigation_store.dart';
import 'system/datasources/audio_player_data_source.dart';
import 'system/datasources/audio_player_data_source_impl.dart';
import 'system/datasources/local_music_fetcher.dart';
import 'system/datasources/local_music_fetcher_impl.dart';
import 'system/datasources/moor_database.dart';
import 'system/datasources/music_data_source_contract.dart';
import 'system/datasources/platform_integration_data_source.dart';
import 'system/datasources/platform_integration_data_source_impl.dart';
import 'system/datasources/player_state_data_source.dart';
import 'system/datasources/settings_data_source.dart';
import 'system/repositories/audio_player_repository_impl.dart';
import 'system/repositories/music_data_modifier_repository_impl.dart';
import 'system/repositories/music_data_repository_impl.dart';
import 'system/repositories/persistent_player_state_repository_impl.dart';
import 'system/repositories/platform_integration_repository_impl.dart';
import 'system/repositories/settings_repository_impl.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  print('setupGetIt');

  // stores
  getIt.registerFactory<MusicDataStore>(
    () {
      final musicDataStore = MusicDataStore(
        musicDataInfoRepository: getIt(),
        settingsRepository: getIt(),
        musicDataModifierRepository: getIt(),
        updateDatabase: getIt(),
      );
      return musicDataStore;
    },
  );
  getIt.registerFactory<AudioStore>(
    () {
      final audioStore = AudioStore(
        audioPlayerInfoRepository: getIt(),
        pause: getIt(),
        play: getIt(),
        playSongs: getIt(),
        seekToNext: getIt(),
        seekToPrevious: getIt(),
        setLoopMode: getIt(),
        shuffleAll: getIt(),
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

  // use cases
  getIt.registerLazySingleton<HandlePlaybackEvent>(
    () => HandlePlaybackEvent(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<Pause>(
    () => Pause(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<Play>(
    () => Play(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<PlaySongs>(
    () => PlaySongs(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<SeekToNext>(
    () => SeekToNext(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<SeekToPrevious>(
    () => SeekToPrevious(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<SetCurrentSong>(
    () => SetCurrentSong(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<SetLoopMode>(
    () => SetLoopMode(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<ShuffleAll>(
    () => ShuffleAll(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<UpdateDatabase>(
    () => UpdateDatabase(
      getIt(),
    ),
  );

  // modules
  getIt.registerLazySingleton<QueueGenerationModule>(
    () => QueueGenerationModule(
      getIt(),
    ),
  );

  // repositories
  getIt.registerLazySingleton<AudioPlayerRepository>(
    () => AudioPlayerRepositoryImpl(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<AudioPlayerInfoRepository>(
    () => getIt<AudioPlayerRepository>(),
  );

  getIt.registerLazySingleton<MusicDataRepository>(
    () => MusicDataRepositoryImpl(
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<MusicDataInfoRepository>(
    () => getIt<MusicDataRepository>(),
  );
  getIt.registerLazySingleton<MusicDataModifierRepository>(
    () => MusicDataModifierRepositoryImpl(
      getIt(),
    ),
  );

  getIt.registerLazySingleton<PlayerStateRepository>(
    () => PlayerStateRepositoryImpl(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<PlatformIntegrationRepository>(
    () => PlatformIntegrationRepositoryImpl(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<PlatformIntegrationInfoRepository>(
    () => getIt<PlatformIntegrationRepository>(),
  );

  // data sources
  final MoorDatabase moorDatabase = MoorDatabase();
  getIt.registerLazySingleton<MusicDataSource>(() => moorDatabase.musicDataDao);
  getIt.registerLazySingleton<PlayerStateDataSource>(() => moorDatabase.playerStateDao);
  getIt.registerLazySingleton<SettingsDataSource>(() => moorDatabase.settingsDao);
  getIt.registerLazySingleton<LocalMusicFetcher>(
    () => LocalMusicFetcherImpl(
      getIt(),
      getIt(),
      getIt(),
    ),
  );

  final AudioPlayerDataSource audioPlayer = AudioPlayerDataSourceImpl(
    AudioPlayer(),
  );
  getIt.registerLazySingleton<AudioPlayerDataSource>(() => audioPlayer);

  final PlatformIntegrationDataSource _platformIntegrationDataSource =
      PlatformIntegrationDataSourceImpl();
  getIt.registerLazySingleton<PlatformIntegrationDataSource>(
    () => _platformIntegrationDataSource,
  );

  // external
  final _audioHandler = await AudioService.init(
    builder: () => _platformIntegrationDataSource as AudioHandler,
    config: AudioServiceConfig(
      androidNotificationChannelName: 'mucke',
      androidEnableQueue: true,
    ),
  );
  getIt.registerLazySingleton<AudioHandler>(() => _audioHandler);

  getIt.registerFactory<AudioPlayer>(() => AudioPlayer());

  getIt.registerLazySingleton<FlutterAudioQuery>(() => FlutterAudioQuery());

  getIt.registerLazySingleton<DeviceInfoPlugin>(() => DeviceInfoPlugin());

  // actors
  getIt.registerSingleton<PlatformIntegrationActor>(
    PlatformIntegrationActor(
      getIt(),
      getIt(),
      getIt(),
    ),
  );

  getIt.registerSingleton<AudioPlayerActor>(
    AudioPlayerActor(
      getIt(),
      getIt(),
      getIt(),
    ),
  );
}
