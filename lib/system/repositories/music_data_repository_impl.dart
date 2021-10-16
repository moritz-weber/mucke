import 'dart:math';

import 'package:fimber/fimber.dart';
import 'package:rxdart/rxdart.dart';
import 'package:string_similarity/string_similarity.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/smart_list.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../datasources/local_music_fetcher.dart';
import '../datasources/music_data_source_contract.dart';
import '../datasources/playlist_data_source.dart';
import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/playlist_model.dart';
import '../models/smart_list_model.dart';
import '../models/song_model.dart';

class MusicDataRepositoryImpl implements MusicDataRepository {
  MusicDataRepositoryImpl(
    this._localMusicFetcher,
    this._musicDataSource,
    this._playlistDataSource,
  ) {
    _musicDataSource.songStream.listen((event) => _songSubject.add(event));
  }

  final LocalMusicFetcher _localMusicFetcher;
  final MusicDataSource _musicDataSource;
  final PlaylistDataSource _playlistDataSource;

  final BehaviorSubject<Map<String, Song>> _songUpdateSubject = BehaviorSubject();
  final BehaviorSubject<List<Song>> _songSubject = BehaviorSubject();

  static final _log = FimberLog('MusicDataRepositoryImpl');

  @override
  Stream<Map<String, Song>> get songUpdateStream => _songUpdateSubject.stream;

  @override
  Future<Song> getSongByPath(String path) async {
    return await _musicDataSource.getSongByPath(path);
  }

  @override
  Stream<List<Song>> get songStream => _songSubject.stream;

  @override
  Stream<List<Album>> get albumStream => _musicDataSource.albumStream;

  @override
  Stream<List<Artist>> get artistStream => _musicDataSource.artistStream;

  @override
  Stream<List<Song>> getAlbumSongStream(Album album) =>
      _musicDataSource.getAlbumSongStream(album as AlbumModel);

  @override
  Stream<List<Song>> getArtistSongStream(Artist artist) =>
      _musicDataSource.getArtistSongStream(artist as ArtistModel);

  @override
  Stream<List<Song>> getArtistHighlightedSongStream(Artist artist) {
    return _musicDataSource
        .getArtistSongStream(artist as ArtistModel)
        .map((event) => _sortHighlightedSongs(event));
  }

  @override
  Stream<List<Album>> getArtistAlbumStream(Artist artist) => _musicDataSource
      .getArtistAlbumStream(artist as ArtistModel)
      .map((albums) => _sortArtistAlbums(albums));

  @override
  Stream<List<Song>> getSmartListSongStream(SmartList smartList) =>
      _playlistDataSource.getSmartListSongStream(smartList as SmartListModel);

  @override
  Future<void> updateDatabase() async {
    _log.d('updateDatabase called');

    final localMusic = await _localMusicFetcher.getLocalMusic();

    await _updateArtists(localMusic['ARTISTS'] as List<ArtistModel>);
    await _updateAlbums(localMusic['ALBUMS'] as List<AlbumModel>);
    await _updateSongs(localMusic['SONGS'] as List<SongModel>);

    _log.d('updateDatabase finished');
  }

  @override
  Future<void> incrementLikeCount(Song song) async {
    if (song.likeCount < 5) {
      final newSong = (song as SongModel).copyWith(likeCount: song.likeCount + 1);
      _songUpdateSubject.add({song.path: newSong});
      _musicDataSource.updateSong(newSong);
    }
  }

  Future<void> _updateArtists(List<ArtistModel> artists) async {
    await _musicDataSource.deleteAllArtists();
    await _musicDataSource.insertArtists(artists);
  }

  Future<void> _updateAlbums(List<AlbumModel> albums) async {
    await _musicDataSource.deleteAllAlbums();
    await _musicDataSource.insertAlbums(albums);
  }

  Future<void> _updateSongs(List<SongModel> songs) async {
    await _musicDataSource.insertSongs(songs);
  }

  @override
  Future<void> setSongBlocked(Song song, bool blocked) async {
    if (song.blocked != blocked) {
      final newSong = (song as SongModel).copyWith(blocked: blocked);
      _songUpdateSubject.add({song.path: newSong});
      _musicDataSource.updateSong(newSong);
    }
  }

  @override
  Future<void> incrementPlayCount(Song song) async {
    final newSong = (song as SongModel).copyWith(playCount: song.playCount + 1);
    _songUpdateSubject.add({song.path: newSong});
    _musicDataSource.updateSong(newSong);
  }

  @override
  Future<void> incrementSkipCount(Song song) async {
    final newSong = (song as SongModel).copyWith(skipCount: song.skipCount + 1);
    _songUpdateSubject.add({song.path: newSong});
    _musicDataSource.updateSong(newSong);
  }

  @override
  Future<void> resetLikeCount(Song song) async {
    final newSong = (song as SongModel).copyWith(likeCount: 0);
    _songUpdateSubject.add({song.path: newSong});
    _musicDataSource.updateSong(newSong);
  }

  @override
  Future<void> resetSkipCount(Song song) async {
    final newSong = (song as SongModel).copyWith(skipCount: 0);
    _songUpdateSubject.add({song.path: newSong});
    _musicDataSource.updateSong(newSong);
  }

  @override
  Future<void> toggleNextSongLink(Song song) async {
    SongModel newSong;
    if (song.next == '') {
      final successor = await _musicDataSource.getSuccessor(song as SongModel);
      newSong = song.copyWith(next: successor?.path ?? '');
    } else {
      newSong = (song as SongModel).copyWith(next: '');
    }
    _musicDataSource.updateSong(newSong);
    _songUpdateSubject.add({song.path: newSong});
  }

  @override
  Future<void> togglePreviousSongLink(Song song) async {
    SongModel newSong;
    if (song.previous == '') {
      final predecessor = await _musicDataSource.getPredecessor(song as SongModel);
      newSong = song.copyWith(previous: predecessor?.path ?? '');
    } else {
      newSong = (song as SongModel).copyWith(previous: '');
    }
    _musicDataSource.updateSong(newSong);
    _songUpdateSubject.add({song.path: newSong});
  }

  List<Song> _sortHighlightedSongs(List<Song> songs) {
    return songs
      ..sort(
        (a, b) {
          final r = -a.likeCount.compareTo(b.likeCount);
          if (r != 0) {
            return r;
          }
          return -a.playCount.compareTo(b.playCount);
        },
      );
  }

  List<Album> _sortArtistAlbums(List<Album> albums) {
    return albums
      ..sort((a, b) {
        if (b.pubYear == null) {
          return -1;
        }
        if (a.pubYear == null) {
          return 1;
        }
        return -a.pubYear!.compareTo(b.pubYear!);
      });
  }

  @override
  Future<Album?> getAlbumOfDay() async {
    final storedAlbum = await _musicDataSource.getAlbumOfDay();
    if (storedAlbum == null || !_isAlbumValid(storedAlbum)) {
      final albums = await _musicDataSource.albumStream.first;
      if (albums.isNotEmpty) {
        final rng = Random();
        final index = rng.nextInt(albums.length);
        _musicDataSource.setAlbumOfDay(AlbumOfDay(albums[index], _day(DateTime.now())));
        return albums[index];
      }
    } else {
      return storedAlbum.albumModel;
    }
  }

  bool _isAlbumValid(AlbumOfDay albumOfDay) {
    return _day(DateTime.now()).difference(_day(albumOfDay.date)).inDays < 1;
  }

  DateTime _day(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  @override
  Future<List> search(String searchText) async {
    if (searchText == '') return [];

    final searchTextLower = searchText.toLowerCase();

    // TODO: need to clean the string? sql injection?
    final dbResult = await _musicDataSource.search(_fuzzy(searchTextLower), limit: 200);

    final List<List> ratedResults = [];
    for (final x in dbResult) {
      if (x is SongModel) {
        ratedResults.add([_similarity(x.title.toLowerCase(), searchTextLower), x]);
      } else if (x is AlbumModel) {
        ratedResults.add([_similarity(x.title.toLowerCase(), searchTextLower), x]);
      } else if (x is ArtistModel) {
        ratedResults.add([_similarity(x.name.toLowerCase(), searchTextLower), x]);
      }
    }
    ratedResults.sort((List a, List b) => -(a[0] as double).compareTo(b[0] as double));

    final results = ratedResults.map((e) => e[1]);
    return results.toList();
  }

  double _similarity(String value, String searchText) {
    return value.startsWith(searchText)
        ? value.similarityTo(searchText) + 1
        : value.similarityTo(searchText);
  }

  String _fuzzy(String text) {
    final String fuzzyText = text
        .replaceAll(RegExp(r'[aáàäâã]'), '[aáàäâã]')
        .replaceAll(RegExp(r'[eéèëê]'), '[eéèëê]')
        .replaceAll(RegExp(r'[iíìî]'), '[iíìî]')
        .replaceAll(RegExp(r'[oóòöôõ]'), '[oóòöôõ]')
        .replaceAll(RegExp(r'[uúùüû]'), '[uúùüû]')
        .replaceAll('.', '\\.')
        .replaceAll('?', '\\?');
    return '.*$fuzzyText.*';
  }

  @override
  Future<void> appendSongToPlaylist(Playlist playlist, Song song) async {
    _playlistDataSource.appendSongToPlaylist(playlist as PlaylistModel, song as SongModel);
  }

  @override
  Stream<Playlist> getPlaylistStream(int playlistId) {
    return _playlistDataSource.getPlaylistStream(playlistId);
  }

  @override
  Future<void> insertPlaylist(String name) async {
    _playlistDataSource.insertPlaylist(name);
  }

  @override
  Stream<List<Playlist>> get playlistsStream => _playlistDataSource.playlistsStream;

  @override
  Future<void> removePlaylist(Playlist playlist) async {
    _playlistDataSource.removePlaylist(playlist as PlaylistModel);
  }

  @override
  Future<void> updatePlaylist(int id, String name) async {
    _playlistDataSource.updatePlaylist(id, name);
  }

  @override
  Future<void> insertSmartList({
    required String name,
    required Filter filter,
    required OrderBy orderBy,
    ShuffleMode? shuffleMode,
  }) {
    return _playlistDataSource.insertSmartList(name, filter, orderBy, shuffleMode);
  }

  @override
  Future<void> removeSmartList(SmartList smartList) =>
      _playlistDataSource.removeSmartList(smartList as SmartListModel);

  @override
  Stream<List<SmartList>> get smartListsStream => _playlistDataSource.smartListsStream;

  @override
  Stream<SmartList> getSmartListStream(int smartListId) =>
      _playlistDataSource.getSmartListStream(smartListId);

  @override
  Future<void> updateSmartList(SmartList smartList) {
    return _playlistDataSource.updateSmartList(
      SmartListModel(
        id: smartList.id,
        name: smartList.name,
        filter: smartList.filter,
        orderBy: smartList.orderBy,
        shuffleMode: smartList.shuffleMode,
      ),
    );
  }
}
