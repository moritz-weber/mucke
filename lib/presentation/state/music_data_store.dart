import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_modifier_repository.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../../domain/repositories/settings_repository.dart';

part 'music_data_store.g.dart';

class MusicDataStore extends _MusicDataStore with _$MusicDataStore {
  MusicDataStore({
    @required MusicDataRepository musicDataRepository,
    @required SettingsRepository settingsRepository,
    @required MusicDataModifierRepository musicDataModifierRepository,
  }) : super(musicDataRepository, settingsRepository, musicDataModifierRepository);
}

abstract class _MusicDataStore with Store {
  _MusicDataStore(
      this._musicDataRepository, this._settingsRepository, this._musicDataModifierRepository) {
    songStream = _musicDataRepository.songStream.asObservable(initialValue: []);
    albumStream = _musicDataRepository.albumStream.asObservable(initialValue: []);
    artistStream = _musicDataRepository.artistStream.asObservable(initialValue: []);
  }

  final MusicDataRepository _musicDataRepository;
  final MusicDataModifierRepository _musicDataModifierRepository;
  final SettingsRepository _settingsRepository;

  @observable
  ObservableStream<List<Song>> songStream;

  @observable
  ObservableStream<List<Album>> albumStream;

  @observable
  ObservableStream<List<Artist>> artistStream;

  @observable
  ObservableStream<List<Song>> albumSongStream;

  @observable
  ObservableStream<List<Album>> artistAlbumStream;

  @observable
  bool isUpdatingDatabase = false;

  @action
  Future<void> updateDatabase() async {
    isUpdatingDatabase = true;
    await _musicDataRepository.updateDatabase();
    isUpdatingDatabase = false;
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
    await _musicDataModifierRepository.setSongBlocked(song, blocked);
  }

  Future<void> toggleNextSongLink(Song song) async {
    await _musicDataModifierRepository.toggleNextSongLink(song);
  }

  Future<void> incrementLikeCount(Song song) =>
      _musicDataModifierRepository.incrementLikeCount(song);

  Future<void> resetLikeCount(Song song) => _musicDataModifierRepository.resetLikeCount(song);

  Future<void> addLibraryFolder(String path) async {
    await _settingsRepository.addLibraryFolder(path);
  }
}
