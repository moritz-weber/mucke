import '../../domain/entities/shuffle_mode.dart';
import 'music_data_source_contract.dart';

const String SHUFFLE_MODE = 'SHUFFLE_MODE';

class PersistenceManager {
  PersistenceManager(this.musicDataSource);

  MusicDataSource musicDataSource;

  Future<ShuffleMode> getShuffleMode() async {
    final mode = await musicDataSource
        .getValue(SHUFFLE_MODE)
        .then((value) => value?.toShuffleMode() ?? ShuffleMode.none);
    return mode;
  }

  Future<void> setShuffleMode(ShuffleMode mode) async {
    musicDataSource.setValue(SHUFFLE_MODE, mode.toString());
  }
}
