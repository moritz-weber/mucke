import 'package:dartz/dartz.dart';
import 'package:mosh/system/models/song_model.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/audio_repository.dart';
import '../datasources/audio_manager_contract.dart';

class AudioRepositoryImpl implements AudioRepository {
  AudioRepositoryImpl(this._audioManager);

  final AudioManager _audioManager;

  @override
  Future<Either<Failure, void>> playSong(int index, List<Song> songList) async {   
    final List<SongModel> songModelList = songList.map((song) => song as SongModel).toList();
    
    if (0 <= index && index < songList.length) {
      await _audioManager.playSong(index, songModelList);
    return Right(null);
    }
    return Left(IndexFailure());
  }
}
