import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_modifier_repository.dart';
import '../datasources/music_data_source_contract.dart';
import '../models/song_model.dart';

class MusicDataModifierRepositoryImpl implements MusicDataModifierRepository {
  MusicDataModifierRepositoryImpl(this._musicDataSource);

  final MusicDataSource _musicDataSource;

  @override
  Future<void> setSongBlocked(Song song, bool blocked) =>
      _musicDataSource.setSongBlocked(song as SongModel, blocked);

  @override
  Future<void> toggleNextSongLink(Song song) =>
      _musicDataSource.toggleNextSongLink(song as SongModel);

    @override
  Future<void> togglePreviousSongLink(Song song) =>
      _musicDataSource.togglePreviousSongLink(song as SongModel);

  @override
  Future<void> decrementLikeCount(Song song) =>
      _musicDataSource.decrementLikeCount(song as SongModel);

  @override
  Future<void> incrementLikeCount(Song song) =>
      _musicDataSource.incrementLikeCount(song as SongModel);

  @override
  Future<void> incrementPlayCount(Song song) =>
      _musicDataSource.incrementPlayCount(song as SongModel);

  @override
  Future<void> incrementSkipCount(Song song) =>
      _musicDataSource.incrementSkipCount(song as SongModel);

  @override
  Future<void> resetLikeCount(Song song) => _musicDataSource.resetLikeCount(song as SongModel);

  @override
  Future<void> resetPlayCount(Song song) => _musicDataSource.resetPlayCount(song as SongModel);

  @override
  Future<void> resetSkipCount(Song song) => _musicDataSource.resetSkipCount(song as SongModel);
}
