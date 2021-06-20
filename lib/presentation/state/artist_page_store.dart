import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';

part 'artist_page_store.g.dart';

class ArtistPageStore extends _ArtistPageStore with _$ArtistPageStore {
  ArtistPageStore({
    required MusicDataInfoRepository musicDataInfoRepository,
    required Artist artist,
  }) : super(musicDataInfoRepository, artist);
}

abstract class _ArtistPageStore with Store {
  _ArtistPageStore(this._musicDataInfoRepository, this._artist) {
    artistAlbumStream =
        _musicDataInfoRepository.getArtistAlbumStream(_artist).asObservable(initialValue: []);
    artistHighlightedSongStream = _musicDataInfoRepository
        .getArtistHighlightedSongStream(_artist)
        .asObservable(initialValue: []);
  }

  final MusicDataInfoRepository _musicDataInfoRepository;

  final Artist _artist;

  @observable
  late ObservableStream<List<Album>> artistAlbumStream;

  @observable
  late ObservableStream<List<Song>> artistHighlightedSongStream;

  void dispose() {}
}
