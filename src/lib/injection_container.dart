import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mucke/domain/usecases/play_album_from_index.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'domain/actors/audio_player_actor.dart';
import 'domain/actors/music_data_actor.dart';
import 'domain/actors/persistence_actor.dart';
import 'domain/actors/platform_integration_actor.dart';
import 'domain/entities/album.dart';
import 'domain/entities/artist.dart';
import 'domain/entities/home_widgets/artist_of_day.dart';
import 'domain/entities/home_widgets/history.dart';
import 'domain/entities/home_widgets/playlists.dart';
import 'domain/entities/home_widgets/shuffle_all.dart';
import 'domain/entities/playlist.dart';
import 'domain/entities/smart_list.dart';
import 'domain/entities/song.dart';
import 'domain/modules/dynamic_queue.dart';
import 'domain/repositories/audio_player_repository.dart';
import 'domain/repositories/history_repository.dart';
import 'domain/repositories/home_widget_repository.dart';
import 'domain/repositories/music_data_repository.dart';
import 'domain/repositories/persistent_state_repository.dart';
import 'domain/repositories/platform_integration_repository.dart';
import 'domain/repositories/settings_repository.dart';
import 'domain/usecases/play_album.dart';
import 'domain/usecases/play_artist.dart';
import 'domain/usecases/play_playable.dart';
import 'domain/usecases/play_playlist.dart';
import 'domain/usecases/play_smart_list.dart';
import 'domain/usecases/play_songs.dart';
import 'domain/usecases/seek_to_next.dart';
import 'domain/usecases/set_song_blocked.dart';
import 'domain/usecases/shuffle_all.dart';
import 'presentation/state/album_page_store.dart';
import 'presentation/state/artist_page_store.dart';
import 'presentation/state/audio_store.dart';
import 'presentation/state/history_store.dart';
import 'presentation/state/home_page_store.dart';
import 'presentation/state/home_widget_forms/artistofday_form_store.dart';
import 'presentation/state/home_widget_forms/history_form_store.dart';
import 'presentation/state/home_widget_forms/playlists_form_store.dart';
import 'presentation/state/home_widget_forms/shuffleall_form_store.dart';
import 'presentation/state/music_data_store.dart';
import 'presentation/state/navigation_store.dart';
import 'presentation/state/play_list_page_store.dart';
import 'presentation/state/playlist_form_store.dart';
import 'presentation/state/queue_page_store.dart';
import 'presentation/state/search_page_store.dart';
import 'presentation/state/settings_store.dart';
import 'presentation/state/smart_list_form_store.dart';
import 'presentation/state/smart_list_page_store.dart';
import 'presentation/state/song_store.dart';
import 'system/datasources/audio_player_data_source.dart';
import 'system/datasources/audio_player_data_source_impl.dart';
import 'system/datasources/history_data_source.dart';
import 'system/datasources/home_widget_data_source.dart';
import 'system/datasources/local_music_fetcher.dart';
import 'system/datasources/local_music_fetcher_impl.dart';
import 'system/datasources/moor_database.dart';
import 'system/datasources/music_data_source_contract.dart';
import 'system/datasources/persistent_state_data_source.dart';
import 'system/datasources/platform_integration_data_source.dart';
import 'system/datasources/platform_integration_data_source_impl.dart';
import 'system/datasources/playlist_data_source.dart';
import 'system/datasources/settings_data_source.dart';
import 'system/repositories/audio_player_repository_impl.dart';
import 'system/repositories/history_repository_impl.dart';
import 'system/repositories/home_widget_repository_impl.dart';
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
      musicDataRepository: getIt(),
      setSongBlocked: getIt(),
    ),
  );
  getIt.registerLazySingleton<AudioStore>(
    () => AudioStore(
      audioPlayerRepository: getIt(),
      playAlbum: getIt(),
      playAlbumFromIndex: getIt(),
      playArtist: getIt(),
      playSmartList: getIt(),
      playPlayist: getIt(),
      playPlayable: getIt(),
      playSongs: getIt(),
      seekToNext: getIt(),
      shuffleAll: getIt(),
    ),
  );
  getIt.registerLazySingleton<NavigationStore>(
    () => NavigationStore(),
  );
  getIt.registerLazySingleton<HomePageStore>(
    () => HomePageStore(
      homeWidgetRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton<HistoryStore>(
    () => HistoryStore(
      historyRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton<SearchPageStore>(
    () => SearchPageStore(
      musicDataInfoRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton<SettingsStore>(
    () => SettingsStore(
      settingsRepository: getIt(),
      musicDataRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton<QueuePageStore>(
    () => QueuePageStore(
      audioStore: getIt(),
    ),
  );
  getIt.registerFactoryParam<SongStore, Song, void>(
    (Song song, _) => SongStore(song: song, musicDataInfoRepository: getIt()),
  );
  getIt.registerFactoryParam<ArtistPageStore, Artist, void>(
    (Artist artist, _) => ArtistPageStore(artist: artist, musicDataInfoRepository: getIt()),
  );
  getIt.registerFactoryParam<AlbumPageStore, Album, void>(
    (Album album, _) => AlbumPageStore(album: album, musicDataInfoRepository: getIt()),
  );
  getIt.registerFactoryParam<PlaylistFormStore, Playlist?, void>(
    (Playlist? playlist, _) => PlaylistFormStore(musicDataRepository: getIt(), playlist: playlist),
  );
  getIt.registerFactoryParam<PlaylistPageStore, Playlist, void>(
    (Playlist? playlist, _) => PlaylistPageStore(
      playlist: playlist!,
      musicDataInfoRepository: getIt(),
    ),
  );
  getIt.registerFactoryParam<SmartListFormStore, SmartList?, void>(
    (SmartList? smartList, _) =>
        SmartListFormStore(musicDataRepository: getIt(), smartList: smartList),
  );
  getIt.registerFactoryParam<SmartListPageStore, SmartList, void>(
    (SmartList? smartList, _) => SmartListPageStore(
      smartList: smartList!,
      musicDataInfoRepository: getIt(),
    ),
  );
  getIt.registerFactoryParam<PlaylistsFormStore, HomePlaylists, void>(
    (HomePlaylists playlists, _) => PlaylistsFormStore(
      homeWidgetRepository: getIt(),
      homePlaylists: playlists,
    ),
  );
  getIt.registerFactoryParam<ShuffleAllFormStore, HomeShuffleAll, void>(
    (HomeShuffleAll shuffleAll, _) => ShuffleAllFormStore(
      homeWidgetRepository: getIt(),
      homeShuffleAll: shuffleAll,
    ),
  );
  getIt.registerFactoryParam<ArtistOfDayFormStore, HomeArtistOfDay, void>(
    (HomeArtistOfDay artistOfDay, _) => ArtistOfDayFormStore(
      homeWidgetRepository: getIt(),
      homeArtistOfDay: artistOfDay,
    ),
  );
  getIt.registerFactoryParam<HistoryFormStore, HomeHistory, void>(
    (HomeHistory history, _) => HistoryFormStore(
      homeWidgetRepository: getIt(),
      homeHistory: history,
    ),
  );

  // use cases
  getIt.registerLazySingleton<PlayAlbum>(
    () => PlayAlbum(
      getIt(),
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<PlayAlbumFromIndex>(
    () => PlayAlbumFromIndex(
      getIt(),
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
      getIt(),
    ),
  );
  getIt.registerLazySingleton<PlayPlaylist>(
    () => PlayPlaylist(
      getIt(),
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<PlaySongs>(
    () => PlaySongs(
      getIt(),
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<PlayPlayable>(
    () => PlayPlayable(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<SeekToNext>(
    () => SeekToNext(
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<SetSongsBlocked>(
    () => SetSongsBlocked(
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

  // modules
  getIt.registerLazySingleton<DynamicQueue>(
    () => DynamicQueue(
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
  getIt.registerLazySingleton<HomeWidgetRepository>(
    () => HomeWidgetRepositoryImpl(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(
      getIt(),
    ),
  );

  // data sources
  final MoorDatabase moorDatabase = MoorDatabase();
  getIt.registerLazySingleton<MusicDataSource>(() => moorDatabase.musicDataDao);
  getIt.registerLazySingleton<PersistentStateDataSource>(() => moorDatabase.persistentStateDao);
  getIt.registerLazySingleton<SettingsDataSource>(() => moorDatabase.settingsDao);
  getIt.registerLazySingleton<PlaylistDataSource>(() => moorDatabase.playlistDao);
  getIt.registerLazySingleton<HomeWidgetDataSource>(() => moorDatabase.homeWidgetDao);
  getIt.registerLazySingleton<HistoryDataSource>(() => moorDatabase.historyDao);
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
    config: const AudioServiceConfig(
      androidNotificationChannelName: 'mucke',
      androidNotificationIcon: 'drawable/ic_stat',
    ),
  );
  getIt.registerLazySingleton<AudioHandler>(() => _audioHandler);

  getIt.registerFactory<AudioPlayer>(() => AudioPlayer());

  getIt.registerLazySingleton<OnAudioQuery>(() => OnAudioQuery());

  // actors
  getIt.registerSingleton<PlatformIntegrationActor>(
    PlatformIntegrationActor(
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
    ),
  );

  getIt.registerSingleton<MusicDataActor>(
    MusicDataActor(
      getIt(),
      getIt(),
    ),
  );

  getIt.registerSingleton<PersistenceActor>(
    PersistenceActor(
      getIt(),
      getIt(),
    ),
  );
}
