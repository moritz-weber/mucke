import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/album.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';

part 'music_data_store.g.dart';

class MusicDataStore extends _MusicDataStore with _$MusicDataStore {
  MusicDataStore({@required MusicDataRepository musicDataRepository})
      : super(musicDataRepository);
}

abstract class _MusicDataStore with Store {
  _MusicDataStore(this._musicDataRepository);

  final MusicDataRepository _musicDataRepository;
  
  bool _initialized = false;


  @observable
  ObservableFuture<List<Album>> albumsFuture;

  @observable
  ObservableList<Song> songs = <Song>[].asObservable();

  @observable
  bool isFetchingSongs = false;

  @observable
  bool isUpdatingDatabase = false;

  @observable
  ObservableList<Song> albumSongs = <Song>[].asObservable();

  @action
  void init() {
    if (!_initialized) {
      print('MusicDataStore.init');
      fetchAlbums();
      fetchSongs();

      _initialized = true;
    }
  }

  @action
  Future<void> updateDatabase() async {
    isUpdatingDatabase = true;
    await _musicDataRepository.updateDatabase();
    await Future.wait([
      fetchAlbums(),
      fetchSongs(),
    ]);
    isUpdatingDatabase = false;
  }

  @action
  Future<void> fetchAlbums() async {
    albumsFuture = ObservableFuture<List<Album>>(
      _musicDataRepository.getAlbums().then(
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
    final result = await _musicDataRepository.getSongs();

    result.fold(
      (_) => songs = <Song>[].asObservable(),
      (songList) {
        songs.clear();
        songs.addAll(songList);
      },
    );

    isFetchingSongs = false;
  }

  @action
  Future<void> fetchSongsFromAlbum(Album album) async {
    final result = await _musicDataRepository.getSongsFromAlbum(album);
    albumSongs.clear();
    result.fold(
      (_) => albumSongs = <Song>[].asObservable(),
      (songList) => albumSongs.addAll(songList),
    );
  }
}
