abstract class Playable {
  PlayableType get type;
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
}

class SearchQuery implements Playable {
  SearchQuery(this.query);

  final String query;

  @override
  PlayableType get type => PlayableType.search;
}
