import 'package:mobx/mobx.dart';

import '../../domain/entities/playlist.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';
import 'selection_store.dart';

part 'play_list_page_store.g.dart';

class PlaylistPageStore extends _PlaylistPageStore with _$PlaylistPageStore {
  PlaylistPageStore({
    required Playlist playlist,
    required MusicDataInfoRepository musicDataInfoRepository,
  }) : super(playlist, musicDataInfoRepository);
}

abstract class _PlaylistPageStore with Store {
  _PlaylistPageStore(this._playlist, this._musicDataInfoRepository);

  final Playlist _playlist;

  final MusicDataInfoRepository _musicDataInfoRepository;

  final selection = SelectionStore();
  late List<ReactionDisposer> _disposers;

  @observable
  late ObservableStream<Playlist> playlistStream =
      _musicDataInfoRepository.getPlaylistStream(_playlist.id).asObservable();

  @observable
  late ObservableStream<List<Song>> playlistSongStream =
      _musicDataInfoRepository.getPlaylistSongStream(_playlist).asObservable(initialValue: []);

  void setupReactions() {
    _disposers = [
      autorun((_) => selection.setItemCount(playlistSongStream.value?.length ?? 0)),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
