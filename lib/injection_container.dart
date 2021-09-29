import 'package:audio_service/audio_service.dart';
import 'package:audiotagger/audiotagger.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';

import 'domain/actors/audio_player_actor.dart';
import 'domain/actors/persistence_actor.dart';
import 'domain/actors/platform_integration_actor.dart';
import 'domain/entities/album.dart';
import 'domain/entities/artist.dart';
import 'domain/entities/smart_list.dart';
import 'domain/modules/managed_queue.dart';
import 'domain/repositories/audio_player_repository.dart';
import 'domain/repositories/music_data_repository.dart';
import 'domain/repositories/persistent_state_repository.dart';
import 'domain/repositories/platform_integration_repository.dart';
import 'domain/repositories/settings_repository.dart';
import 'domain/usecases/add_to_queue.dart';
import 'domain/usecases/handle_playback_state.dart';
import 'domain/usecases/increment_play_count.dart';
import 'domain/usecases/init_queue.dart';
import 'domain/usecases/inrement_like_count.dart';
import 'domain/usecases/move_queue_item.dart';
import 'domain/usecases/pause.dart';
import 'domain/usecases/play.dart';
import 'domain/usecases/play_album.dart';
import 'domain/usecases/play_artist.dart';
import 'domain/usecases/play_next.dart';
import 'domain/usecases/play_smart_list.dart';
import 'domain/usecases/play_songs.dart';
import 'domain/usecases/remove_queue_index.dart';
import 'domain/usecases/reset_like_count.dart';
import 'domain/usecases/seek_to_index.dart';
import 'domain/usecases/seek_to_next.dart';
import 'domain/usecases/seek_to_previous.dart';
import 'domain/usecases/set_current_song.dart';
import 'domain/usecases/set_loop_mode.dart';
import 'domain/usecases/set_shuffle_mode.dart';
import 'domain/usecases/set_song_blocked.dart';
import 'domain/usecases/shuffle_all.dart';
import 'domain/usecases/toggle_next_song_link.dart';
import 'domain/usecases/toggle_previous_song_link.dart';
import 'domain/usecases/update_database.dart';
import 'presentation/state/album_page_store.dart';
import 'presentation/state/artist_page_store.dart';
import 'presentation/state/audio_store.dart';
import 'presentation/state/music_data_store.dart';
import 'presentation/state/navigation_store.dart';
import 'presentation/state/search_page_store.dart';
import 'presentation/state/settings_store.dart';
import 'presentation/state/smart_list_form_store.dart';
import 'presentation/state/smart_list_page_store.dart';
import 'system/datasources/audio_player_data_source.dart';
import 'system/datasources/audio_player_data_source_impl.dart';
import 'system/datasources/local_music_fetcher.dart';
import 'system/datasources/local_music_fetcher_impl.dart';
import 'system/datasources/moor_database.dart';
import 'system/datasources/music_data_source_contract.dart';
import 'system/datasources/persistent_state_data_source.dart';
import 'system/datasources/platform_integration_data_source.dart';
import 'system/datasources/platform_integration_data_source_impl.dart';
import 'system/datasources/settings_data_source.dart';
import 'system/repositories/audio_player_repository_impl.dart';
import 'system/repositories/music_data_repository_impl.dart';
import 'system/repositories/persistent_state_repository_impl.dart';
import 'system/repositories/platform_integration_repository_impl.dart';
import 'system/repositories/settings_repository_impl.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  print('setupGetIt');

  // stores
  getIt.registerLazySingleton<MusicDataStore>(
    () => MusicDataStore(
      musicDataInfoRepository: getIt(),
      incrementLikeCount: getIt(),
      resetLikeCount: getIt(),
      setSongBlocked: getIt(),
      updateDatabase: getIt(),
      toggleNextSongLink: getIt(),
      togglePreviousSongLink: getIt(),
    ),
  );
  getIt.registerLazySingleton<AudioStore>(
    () => AudioStore(
      audioPlayerInfoRepository: getIt(),
      addToQueue: getIt(),
      moveQueueItem: getIt(),
      pause: getIt(),
      play: getIt(),
      playAlbum: getIt(),
      playArtist: getIt(),
      playNext: getIt(),
      playSmartList: getIt(),
      playSongs: getIt(),
      removeQueueIndex: getIt(),
      seekToIndex: getIt(),
      seekToNext: getIt(),
      seekToPrevious: getIt(),
      setLoopMode: getIt(),
      setShuffleMode: getIt(),
      shuffleAll: getIt(),
    ),
  );
  getIt.registerLazySingleton<NavigationStore>(
    () => NavigationStore(),
  );
  getIt.registerLazySingleton<SearchPageStore>(
    () => SearchPageStore(
      musicDataInfoRepository: getIt(),
    ),
  );
  getIt.registerFactoryParam<ArtistPageStore, Artist, void>(
    (Artist? artist, _) => ArtistPageStore(artist: artist!, musicDataInfoRepository: getIt()),
  );
  getIt.registerFactoryParam<AlbumPageStore, Album, void>(
    (Album? album, _) => AlbumPageStore(album: album!, musicDataInfoRepository: getIt()),
  );
  getIt.registerFactory<SettingsStore>(
    () => SettingsStore(settingsRepository: getIt()),
  );
  getIt.registerFactoryParam<SmartListFormStore, SmartList, void>(
    (SmartList? smartList, _) =>
        SmartListFormStore(settingsRepository: getIt(), smartList: smartList),
  );
  getIt.registerFactoryParam<SmartListPageStore, SmartList, void>(
    (SmartList? smartList, _) => SmartListPageStore(
      smartList: smartList!,
      musicDataInfoRepository: getIt(),
      settingsRepository: getIt(),
    ),
  );

  // use cases
  getIt.registerLazySingleton<AddToQueue>(
    () => AddToQueue(
      getIt<AudioPlayerRepository>(),
      getIt<PlatformIntegrationRepository>(),
    ),
  );
  getIt.registerLazySingleton<HandlePlaybackEvent>(
    () => HandlePlaybackEvent(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<IncrementLikeCount>(
    () => IncrementLikeCount(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<IncrementPlayCount>(
    () => IncrementPlayCount(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<InitQueue>(
    () => InitQueue(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<MoveQueueItem>(
    () => MoveQueueItem(
      getIt(),
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
  getIt.registerLazySingleton<PlayAlbum>(
    () => PlayAlbum(
      getIt(),
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<PlayArtist>(
    () => PlayArtist(
      getIt(),
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<PlaySmartList>(
    () => PlaySmartList(
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<PlayNext>(
    () => PlayNext(
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<PlaySongs>(
    () => PlaySongs(
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<RemoveQueueIndex>(
    () => RemoveQueueIndex(
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<ResetLikeCount>(
    () => ResetLikeCount(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<SeekToIndex>(
    () => SeekToIndex(
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
  getIt.registerLazySingleton<SetShuffleMode>(
    () => SetShuffleMode(
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<SetSongBlocked>(
    () => SetSongBlocked(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<ShuffleAll>(
    () => ShuffleAll(
      getIt(),
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<ToggleNextSongLink>(
    () => ToggleNextSongLink(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<TogglePreviousSongLink>(
    () => TogglePreviousSongLink(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<UpdateDatabase>(
    () => UpdateDatabase(
      getIt(),
    ),
  );

  // modules
  getIt.registerLazySingleton<ManagedQueue>(
    () => ManagedQueue(
      getIt(),
    ),
  );

  // repositories
  getIt.registerLazySingleton<AudioPlayerRepository>(
    () => AudioPlayerRepositoryImpl(
      getIt(),
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

  getIt.registerLazySingleton<PersistentStateRepository>(
    () => PersistentStateRepositoryImpl(
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
  getIt.registerLazySingleton<PersistentStateDataSource>(() => moorDatabase.persistentStateDao);
  getIt.registerLazySingleton<SettingsDataSource>(() => moorDatabase.settingsDao);
  getIt.registerLazySingleton<LocalMusicFetcher>(
    () => LocalMusicFetcherImpl(
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
    config: const AudioServiceConfig(
      androidNotificationChannelName: 'mucke',
    ),
  );
  getIt.registerLazySingleton<AudioHandler>(() => _audioHandler);

  getIt.registerFactory<AudioPlayer>(() => AudioPlayer());

  getIt.registerLazySingleton<Audiotagger>(() => Audiotagger());

  // actors
  getIt.registerSingleton<PlatformIntegrationActor>(
    PlatformIntegrationActor(
      getIt(),
      getIt(),
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
      getIt(),
      getIt(),
    ),
  );

  getIt.registerSingleton<PersistenceActor>(
    PersistenceActor(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );
}
