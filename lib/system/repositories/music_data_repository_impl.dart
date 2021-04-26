import 'package:logging/logging.dart';
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

  static final _log = Logger('MusicDataRepository');

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
  Stream<List<Album>> getArtistAlbumStream(Artist artist) =>
      _musicDataSource.getArtistAlbumStream(artist as ArtistModel);

  @override
  Future<void> updateDatabase() async {
    _log.info('updateDatabase called');

    final localMusic = await _localMusicFetcher.getLocalMusic();

    await _updateArtists(localMusic['ARTISTS'] as List<ArtistModel>);
    await _updateAlbums(localMusic['ALBUMS'] as List<AlbumModel>);
    await _updateSongs(localMusic['SONGS'] as List<SongModel>);

    _log.info('updateDatabase finished');
  }

  @override
  Future<void> incrementLikeCount(Song song) async {
    if (song.likeCount < 5) {
      final newSong = (song as SongModel).copyWith(likeCount: song.likeCount + 1);
      _songUpdateSubject.add({song.path: newSong});
      _musicDataSource.incrementLikeCount(song as SongModel);
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
}
