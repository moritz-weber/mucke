import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/album.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../../domain/usecases/get_albums.dart';
import '../../domain/usecases/update_database.dart';

part 'music_store.g.dart';

class MusicStore extends _MusicStore with _$MusicStore {
  MusicStore(MusicDataRepository musicDataRepository)
      : super(musicDataRepository);
}

abstract class _MusicStore with Store {
  _MusicStore(MusicDataRepository _musicDataRepository)
      : _updateDatabase = UpdateDatabase(_musicDataRepository),
        _getAlbums = GetAlbums(_musicDataRepository);

  // final MusicDataRepository _musicDataRepository;
  final UpdateDatabase _updateDatabase;
  final GetAlbums _getAlbums;

  @observable
  ObservableFuture<List<Album>> albumsFuture;

  @observable
  bool isUpdatingDatabase = false;

  @action
  Future<void> updateDatabase() async {
    isUpdatingDatabase = true;
    await _updateDatabase();
    isUpdatingDatabase = false;
    fetchAlbums();
  }

  @action
  Future<void> fetchAlbums() {
    albumsFuture = ObservableFuture<List<Album>>(_getAlbums().then(
        (Either<Failure, List<Album>> either) =>
            either.fold((_) => [], (List<Album> a) => a)));
    return null;
  }
}
