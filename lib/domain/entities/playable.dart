// TODO: vielleicht soll Playable immer mit einer Songliste kommen?
// dann müsste man eventuell neue Klassen definieren, die bspw. Album/Artist beinhalten
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
