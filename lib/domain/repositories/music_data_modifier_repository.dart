import '../entities/song.dart';

abstract class MusicDataModifierRepository {
  Future<void> setSongBlocked(Song song, bool blocked);
  Future<void> toggleNextSongLink(Song song);

  Future<void> incrementSkipCount(Song song);
  Future<void> resetSkipCount(Song song);

  Future<void> incrementLikeCount(Song song);
  Future<void> decrementLikeCount(Song song);
  Future<void> resetLikeCount(Song song);

  Future<void> incrementPlayCount(Song song);
  Future<void> resetPlayCount(Song song);
}
