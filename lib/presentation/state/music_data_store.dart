import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
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
  ObservableList<Artist> artists = <Artist>[].asObservable();
  @observable
  bool isFetchingArtists = false;

  @observable
  ObservableList<Album> albums = <Album>[].asObservable();
  @observable
  bool isFetchingAlbums = false;

  @observable
  ObservableList<Song> songs = <Song>[].asObservable();
  @observable
  bool isFetchingSongs = false;

  @observable
  bool isUpdatingDatabase = false;

  @observable
  ObservableList<Song> albumSongs = <Song>[].asObservable();

  void init() {
    if (!_initialized) {
      fetchArtists();
      fetchAlbums();
      fetchSongs();
    }
    _initialized = true;
  }

  @action
  Future<void> updateDatabase() async {
    isUpdatingDatabase = true;
    await _musicDataRepository.updateDatabase();
    await Future.wait([
      fetchArtists(),
      fetchAlbums(),
      fetchSongs(),
    ]);
    isUpdatingDatabase = false;
  }

  @action
  Future<void> fetchArtists() async {
    isFetchingArtists = true;
    final result = await _musicDataRepository.getArtists();

    result.fold(
      (_) => artists = <Artist>[].asObservable(),
      (artistList) {
        artists.clear();
        artists.addAll(artistList);
      },
    );

    isFetchingArtists = false;
  }

  @action
  Future<void> fetchAlbums() async {
    isFetchingAlbums = true;
    final result = await _musicDataRepository.getAlbums();

    result.fold(
      (_) => albums = <Album>[].asObservable(),
      (albumList) {
        albums.clear();
        albums.addAll(albumList);
      },
    );

    isFetchingAlbums = false;
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

  Future<void> setSongBlocked(Song song, bool blocked) async {
    await _musicDataRepository.setSongBlocked(song, blocked);
  }

  Future<void> toggleNextSongLink(Song song) async {
    await _musicDataRepository.toggleNextSongLink(song);
  }
}
