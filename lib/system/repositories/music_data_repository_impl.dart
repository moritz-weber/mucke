import 'dart:math';

import 'package:fimber/fimber.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../datasources/local_music_fetcher.dart';
import '../datasources/music_data_source_contract.dart';
import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/song_model.dart';

class MusicDataRepositoryImpl implements MusicDataRepository {
  MusicDataRepositoryImpl(
    this._localMusicFetcher,
    this._musicDataSource,
  ) {
    _musicDataSource.songStream.listen((event) => _songSubject.add(event));
  }

  final LocalMusicFetcher _localMusicFetcher;
  final MusicDataSource _musicDataSource;

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
      _musicDataSource.incrementLikeCount(song);
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
      _musicDataSource.setSongBlocked(song, blocked);
    }
  }

  @override
  Future<void> decrementLikeCount(Song song) {
    // TODO: implement decrementLikeCount
    throw UnimplementedError();
  }

  @override
  Future<void> incrementPlayCount(Song song) async {
    final newSong = (song as SongModel).copyWith(playCount: song.playCount + 1);
    _songUpdateSubject.add({song.path: newSong});
    _musicDataSource.incrementPlayCount(song);
  }

  @override
  Future<void> incrementSkipCount(Song song) {
    // TODO: implement incrementSkipCount
    throw UnimplementedError();
  }

  @override
  Future<void> resetLikeCount(Song song) async {
    final newSong = (song as SongModel).copyWith(likeCount: 0);
    _songUpdateSubject.add({song.path: newSong});
    _musicDataSource.resetLikeCount(song);
  }

  @override
  Future<void> resetPlayCount(Song song) {
    // TODO: implement resetPlayCount
    throw UnimplementedError();
  }

  @override
  Future<void> resetSkipCount(Song song) {
    // TODO: implement resetSkipCount
    throw UnimplementedError();
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
      final albums = await _musicDataSource.getAlbums();
      if (albums.isNotEmpty) {
        final rng = Random();
        final index = rng.nextInt(albums.length);
        _musicDataSource.setAlbumOfDay(AlbumOfDay(albums[index], DateTime.now()));
        return albums[index];
      }
    } else {
      return storedAlbum.albumModel;
    }
  }

  bool _isAlbumValid(AlbumOfDay albumOfDay) {
    return albumOfDay.date.difference(DateTime.now()).inDays < 1;
  }
}
