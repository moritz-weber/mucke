import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/album.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../../domain/usecases/get_albums.dart';
import '../../domain/usecases/get_songs.dart';
import '../../domain/usecases/update_database.dart';

part 'music_data_store.g.dart';

class MusicDataStore extends _MusicDataStore with _$MusicDataStore {
  MusicDataStore({@required MusicDataRepository musicDataRepository})
      : super(musicDataRepository);
}

abstract class _MusicDataStore with Store {
  _MusicDataStore(MusicDataRepository _musicDataRepository)
      : _updateDatabase = UpdateDatabase(_musicDataRepository),
        _getAlbums = GetAlbums(_musicDataRepository),
        _getSongs = GetSongs(_musicDataRepository);

  final UpdateDatabase _updateDatabase;
  final GetAlbums _getAlbums;
  final GetSongs _getSongs;

  @observable
  ObservableFuture<List<Album>> albumsFuture;

  @observable
  ObservableList<Song> songs = <Song>[].asObservable();

  @observable
  bool isFetchingSongs = false;

  @observable
  bool isUpdatingDatabase = false;

  @action
  Future<void> updateDatabase() async {
    isUpdatingDatabase = true;
    await _updateDatabase();
    await Future.wait([
      fetchAlbums(),
      fetchSongs(),
    ]);
    isUpdatingDatabase = false;
  }

  @action
  Future<void> fetchAlbums() async {
    albumsFuture = ObservableFuture<List<Album>>(
      _getAlbums().then(
        (Either<Failure, List<Album>> either) => either.fold(
          (_) => [],
          (List<Album> a) => a,
        ),
      ),
    );
  }

  @action
  Future<void> fetchSongs() async {
    isFetchingSongs = true;
    final result = await _getSongs();

    result.fold(
      (_) => songs = <Song>[].asObservable(),
      (songList) {
        songs.clear();
        songs.addAll(songList);
      },
    );

    isFetchingSongs = false;
  }
}
