import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../../domain/entities/shuffle_mode.dart';
import 'music_data_source_contract.dart';

class QueueManager {
  QueueManager(this._musicDataSource);

  final MusicDataSource _musicDataSource;

  // TODO: test
  // TODO: optimize -> too slow for whole library
  // fetching all songs together and preparing playback takes ~500ms compared to ~10.000ms individually
  Future<List<MediaItem>> getMediaItemsFromPaths(List<String> paths) async {
    final mediaItems = <MediaItem>[];
    for (final path in paths) {
      final song = await _musicDataSource.getSongByPath(path);
      mediaItems.add(song.toMediaItem());
    }

    return mediaItems;
  }

  // TODO: test
  List<int> generatePermutation(
      ShuffleMode shuffleMode, int length, int startIndex) {
    // permutation[i] = j; => song j is on the i-th position in the permutated list
    List<int> permutation;

    switch (shuffleMode) {
      case ShuffleMode.none:
        permutation = List<int>.generate(length, (i) => i);
        break;
      case ShuffleMode.standard:
        final tmp = List<int>.generate(length, (i) => i)
          ..removeAt(startIndex)
          ..shuffle();
        permutation = [startIndex] + tmp;
        break;
      case ShuffleMode.plus:
        break;
    }

    return permutation;
  }

  List<MediaItem> getPermutatedSongs(
      List<MediaItem> songs, List<int> permutation) {
    return List.generate(
        permutation.length, (index) => songs[permutation[index]]);
  }

  ConcatenatingAudioSource mediaItemsToAudioSource(List<MediaItem> mediaItems) {
    return ConcatenatingAudioSource(
        children: mediaItems
            .map((MediaItem m) => AudioSource.uri(Uri.file(m.id)))
            .toList());
  }
}
