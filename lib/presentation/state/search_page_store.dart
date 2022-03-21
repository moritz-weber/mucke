import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/smart_list.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';

part 'search_page_store.g.dart';

class SearchPageStore extends _SearchPageStore with _$SearchPageStore {
  SearchPageStore({
    required MusicDataInfoRepository musicDataInfoRepository,
  }) : super(musicDataInfoRepository);
}

abstract class _SearchPageStore with Store {
  _SearchPageStore(
    this._musicDataInfoRepository,
  ) {
    _musicDataInfoRepository.songUpdateStream.listen((updates) { 
      for (int i = 0; i < searchResultsSongs.length; i++) {
        if (updates.keys.contains(searchResultsSongs[i].path)) {
          searchResultsSongs[i] = updates[searchResultsSongs[i].path]!;
        }
      }
    });
  }

  final MusicDataInfoRepository _musicDataInfoRepository;

  @observable
  String query = '';

  @observable
  ObservableList<Artist> searchResultsArtists = <Artist>[].asObservable();
  @observable
  ObservableList<Album> searchResultsAlbums = <Album>[].asObservable();
  @observable
  ObservableList<Song> searchResultsSongs = <Song>[].asObservable();
  @observable
  ObservableList<SmartList> searchResultsSmartLists = <SmartList>[].asObservable();
  @observable
  ObservableList<Playlist> searchResultsPlaylists = <Playlist>[].asObservable();

  @action
  Future<void> search(String searchText) async {
    query = searchText;

    int limit = 200;
    if (searchText.length == 1)
      limit = 25;
    else if (searchText.length == 2) limit = 100;

    searchResultsArtists =
        (await _musicDataInfoRepository.searchArtists(searchText, limit: limit)).asObservable();
    searchResultsAlbums =
        (await _musicDataInfoRepository.searchAlbums(searchText, limit: limit)).asObservable();
    searchResultsSongs =
        (await _musicDataInfoRepository.searchSongs(searchText, limit: limit)).asObservable();
    searchResultsSmartLists =
        (await _musicDataInfoRepository.searchSmartLists(searchText, limit: limit)).asObservable();
    searchResultsPlaylists =
        (await _musicDataInfoRepository.searchPlaylists(searchText, limit: limit)).asObservable();
  }

  @action
  void reset() {
    query = '';
    searchResultsArtists = <Artist>[].asObservable();
    searchResultsAlbums = <Album>[].asObservable();
    searchResultsSongs = <Song>[].asObservable();
    searchResultsSmartLists = <SmartList>[].asObservable();
    searchResultsPlaylists = <Playlist>[].asObservable();
  }

  void dispose() {}
}
