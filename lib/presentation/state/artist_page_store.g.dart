// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ArtistPageStore on _ArtistPageStore, Store {
  final _$artistAlbumStreamAtom =
      Atom(name: '_ArtistPageStore.artistAlbumStream');

  @override
  ObservableStream<List<Album>> get artistAlbumStream {
    _$artistAlbumStreamAtom.reportRead();
    return super.artistAlbumStream;
  }

  @override
  set artistAlbumStream(ObservableStream<List<Album>> value) {
    _$artistAlbumStreamAtom.reportWrite(value, super.artistAlbumStream, () {
      super.artistAlbumStream = value;
    });
  }

  final _$artistHighlightedSongStreamAtom =
      Atom(name: '_ArtistPageStore.artistHighlightedSongStream');

  @override
  ObservableStream<List<Song>> get artistHighlightedSongStream {
    _$artistHighlightedSongStreamAtom.reportRead();
    return super.artistHighlightedSongStream;
  }

  @override
  set artistHighlightedSongStream(ObservableStream<List<Song>> value) {
    _$artistHighlightedSongStreamAtom
        .reportWrite(value, super.artistHighlightedSongStream, () {
      super.artistHighlightedSongStream = value;
    });
  }

  @override
  String toString() {
    return '''
artistAlbumStream: ${artistAlbumStream},
artistHighlightedSongStream: ${artistHighlightedSongStream}
    ''';
  }
}
