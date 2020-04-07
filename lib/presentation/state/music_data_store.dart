import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:mosh/domain/usecases/play_song.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/album.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/audio_repository.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../../domain/usecases/get_albums.dart';
import '../../domain/usecases/get_songs.dart';
import '../../domain/usecases/update_database.dart';

part 'music_data_store.g.dart';

class MusicDataStore extends _MusicStore with _$MusicDataStore {
  MusicDataStore({@required MusicDataRepository musicDataRepository, @required AudioRepository audioRepository})
      : super(musicDataRepository, audioRepository);
}

abstract class _MusicStore with Store {
  _MusicStore(MusicDataRepository _musicDataRepository, AudioRepository _audioRepository)
      : _updateDatabase = UpdateDatabase(_musicDataRepository),
        _getAlbums = GetAlbums(_musicDataRepository),
        _getSongs = GetSongs(_musicDataRepository),
        _playSong = PlaySong(_audioRepository);

  final UpdateDatabase _updateDatabase;
  final GetAlbums _getAlbums;
  final GetSongs _getSongs;
  final PlaySong _playSong;

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

  @action
  Future<void> playSong(int index, List<Song> songList) async {
    await _playSong(Params(index, songList));
  }
}
