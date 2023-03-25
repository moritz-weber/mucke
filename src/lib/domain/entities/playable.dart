import 'playlist.dart';
import 'shuffle_mode.dart';
import 'smart_list.dart';

abstract class Playable {
  String get identifier;
  PlayableType get type;
  String get title;
}

extension ShuffleModeExtension on Playable {
  ShuffleMode? getShuffleMode() {
    switch (type) {
      case PlayableType.all:
        return ShuffleMode.plus;
      case PlayableType.album:
        return ShuffleMode.none;
      case PlayableType.artist:
        return ShuffleMode.plus;
      case PlayableType.playlist:
        return (this as Playlist).shuffleMode;
      case PlayableType.smartlist:
        return (this as SmartList).shuffleMode;
      case PlayableType.search:
        return ShuffleMode.none;
    }
  }
}

enum PlayableType {
  all,
  album,
  artist,
  playlist,
  smartlist,
  search,
}

extension PlayableTypeExtension on String {
  PlayableType toPlayableType() {
    switch (this) {
      case 'PlayableType.all':
        return PlayableType.all;
      case 'PlayableType.album':
        return PlayableType.album;
      case 'PlayableType.artist':
        return PlayableType.artist;
      case 'PlayableType.playlist':
        return PlayableType.playlist;
      case 'PlayableType.smartlist':
        return PlayableType.smartlist;
      case 'PlayableType.search':
        return PlayableType.search;
      default:
        throw TypeError();
    }
  }
}

class AllSongs implements Playable {
  @override
  PlayableType get type => PlayableType.all;

  @override
  String get identifier => 'ALL_SONGS';

  @override
  String get title => 'All Songs';
}

class SearchQuery implements Playable {
  SearchQuery(this.query);

  final String query;

  @override
  PlayableType get type => PlayableType.search;

  @override
  String get identifier => query;

  @override
  String get title => query;
}
