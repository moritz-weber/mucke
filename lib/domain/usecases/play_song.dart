import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mosh/domain/repositories/audio_repository.dart';

import '../../core/error/failures.dart';
import '../../core/usecase.dart';
import '../entities/song.dart';

class PlaySong implements UseCase<void, Params> {
  PlaySong(this.audioRepository);

  final AudioRepository audioRepository;

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return audioRepository.playSong(params.index, params.songList);
  }
}

class Params extends Equatable {
  const Params(this.index, this.songList);

  final int index;
  final List<Song> songList;

  @override
  List<Object> get props => [index, songList];
}
