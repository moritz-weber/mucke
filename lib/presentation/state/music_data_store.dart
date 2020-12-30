import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../../domain/repositories/settings_repository.dart';

part 'music_data_store.g.dart';

class MusicDataStore extends _MusicDataStore with _$MusicDataStore {
  MusicDataStore({
    @required MusicDataRepository musicDataRepository,
    @required SettingsRepository settingsRepository,
  }) : super(musicDataRepository, settingsRepository);
}

abstract class _MusicDataStore with Store {
  _MusicDataStore(this._musicDataRepository, this._settingsRepository) {
    songStream = _musicDataRepository.songStream.asObservable(initialValue: []);
  }

  final MusicDataRepository _musicDataRepository;
  final SettingsRepository _settingsRepository;

  bool _initialized = false;

  @observable
  ObservableStream<List<Song>> songStream;

  @observable
  ObservableStream<List<Song>> albumSongStream;

  @observable
  ObservableStream<List<Album>> artistAlbumStream;

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
    artists.clear();
    artists.addAll(result);

    isFetchingArtists = false;
  }

  @action
  Future<void> fetchAlbums() async {
    isFetchingAlbums = true;
    final result = await _musicDataRepository.getAlbums();
    albums.clear();
    albums.addAll(result);

    isFetchingAlbums = false;
  }

  @action
  Future<void> fetchSongs() async {
    isFetchingSongs = true;
    final result = await _musicDataRepository.getSongs();
    songs.clear();
    songs.addAll(result);

    isFetchingSongs = false;
  }

  @action
  Future<void> fetchSongsFromAlbum(Album album) async {
    albumSongStream = _musicDataRepository.getAlbumSongStream(album).asObservable(initialValue: []);
  }

  @action
  Future<void> fetchAlbumsFromArtist(Artist artist) async {
    artistAlbumStream =
        _musicDataRepository.getArtistAlbumStream(artist).asObservable(initialValue: []);
  }

  Future<void> setSongBlocked(Song song, bool blocked) async {
    await _musicDataRepository.setSongBlocked(song, blocked);
  }

  Future<void> toggleNextSongLink(Song song) async {
    await _musicDataRepository.toggleNextSongLink(song);
  }

  Future<void> addLibraryFolder(String path) async {
    await _settingsRepository.addLibraryFolder(path);
  }
}
