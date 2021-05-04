import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_modifier_repository.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/usecases/inrement_like_count.dart';
import '../../domain/usecases/set_song_blocked.dart';
import '../../domain/usecases/update_database.dart';

part 'music_data_store.g.dart';

class MusicDataStore extends _MusicDataStore with _$MusicDataStore {
  MusicDataStore({
    @required MusicDataInfoRepository musicDataInfoRepository,
    @required MusicDataModifierRepository musicDataModifierRepository,
    @required SettingsRepository settingsRepository,
    @required UpdateDatabase updateDatabase,
    @required IncrementLikeCount incrementLikeCount,
    @required SetSongBlocked setSongBlocked,
  }) : super(
          musicDataInfoRepository,
          settingsRepository,
          musicDataModifierRepository,
          updateDatabase,
          incrementLikeCount,
          setSongBlocked,
        );
}

abstract class _MusicDataStore with Store {
  _MusicDataStore(
    this._musicDataInfoRepository,
    this._settingsRepository,
    this._musicDataModifierRepository,
    this._updateDatabase,
    this._incrementLikeCount,
    this._setSongBlocked,
  ) {
    songStream = _musicDataInfoRepository.songStream.asObservable(initialValue: []);
    albumStream = _musicDataInfoRepository.albumStream.asObservable(initialValue: []);
    artistStream = _musicDataInfoRepository.artistStream.asObservable(initialValue: []);
  }

  final IncrementLikeCount _incrementLikeCount;
  final SetSongBlocked _setSongBlocked;
  final UpdateDatabase _updateDatabase;

  final MusicDataInfoRepository _musicDataInfoRepository;
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
  ObservableStream<List<Song>> artistHighlightedSongStream;

  @observable
  bool isUpdatingDatabase = false;

  @computed
  List<Album> get sortedArtistAlbums => artistAlbumStream.value.toList()
    ..sort((a, b) {
      if (b.pubYear == null) return -1;
      if (a.pubYear == null) return 1;
      return -a.pubYear.compareTo(b.pubYear);
    });

  @action
  Future<void> updateDatabase() async {
    isUpdatingDatabase = true;
    await _updateDatabase();
    isUpdatingDatabase = false;
  }

  @action
  Future<void> fetchSongsFromAlbum(Album album) async {
    albumSongStream =
        _musicDataInfoRepository.getAlbumSongStream(album).asObservable(initialValue: []);
  }

  // TODO: das hier ist komplett bescheuert... brauchen einen eigenen Store für die ArtistDetailsPage
  @action
  Future<void> fetchAlbumsFromArtist(Artist artist) async {
    artistAlbumStream =
        _musicDataInfoRepository.getArtistAlbumStream(artist).asObservable(initialValue: []);
  }

  @action
  Future<void> fetchHighlightedSongsFromArtist(Artist artist) async {
    artistHighlightedSongStream = _musicDataInfoRepository
        .getArtistHighlightedSongStream(artist)
        .asObservable(initialValue: []);
  }

  Future<void> setSongBlocked(Song song, bool blocked) => _setSongBlocked(song, blocked);

  Future<void> toggleNextSongLink(Song song) async {
    await _musicDataModifierRepository.toggleNextSongLink(song);
  }

  Future<void> incrementLikeCount(Song song) => _incrementLikeCount(song);

  Future<void> resetLikeCount(Song song) => _musicDataModifierRepository.resetLikeCount(song);

  Future<void> addLibraryFolder(String path) async {
    await _settingsRepository.addLibraryFolder(path);
  }
}
