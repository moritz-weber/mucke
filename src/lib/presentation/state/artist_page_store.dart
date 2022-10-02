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
  _ArtistPageStore(this._musicDataInfoRepository, this.artist);

  final MusicDataInfoRepository _musicDataInfoRepository;

  final Artist artist;

  @observable
  late ObservableStream<List<Album>> artistAlbumStream =
      _musicDataInfoRepository.getArtistAlbumStream(artist).asObservable(initialValue: []);

  @observable
  late ObservableStream<List<Song>> artistHighlightedSongStream = _musicDataInfoRepository
      .getArtistHighlightedSongStream(artist)
      .asObservable(initialValue: []);

  void dispose() {}
}
