import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/song_model.dart';
import 'local_music_fetcher_contract.dart';

class LocalMusicFetcherImpl implements LocalMusicFetcher {
  LocalMusicFetcherImpl(this.flutterAudioQuery);

  final FlutterAudioQuery flutterAudioQuery;

  @override
  Future<List<ArtistModel>> getArtists() async {
    final List<ArtistInfo> artistInfoList =
        await flutterAudioQuery.getArtists();
    return artistInfoList
        .map((ArtistInfo artistInfo) => ArtistModel.fromArtistInfo(artistInfo))
        .toSet()
        .toList();
  }

  @override
  Future<List<AlbumModel>> getAlbums() async {
    final List<AlbumInfo> albumInfoList = await flutterAudioQuery.getAlbums();
    return albumInfoList
        .map((AlbumInfo albumInfo) => AlbumModel.fromAlbumInfo(albumInfo))
        .toList();
  }

  @override
  Future<List<SongModel>> getSongs() async {
    final List<SongInfo> songInfoList = await flutterAudioQuery.getSongs();
    return songInfoList
        .where((songInfo) => songInfo.isMusic)
        .map((SongInfo songInfo) => SongModel.fromSongInfo(songInfo))
        .toList();
  }
}
