// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AlbumPageStore on _AlbumPageStore, Store {
  late final _$albumSongStreamAtom =
      Atom(name: '_AlbumPageStore.albumSongStream', context: context);

  @override
  ObservableStream<List<Song>> get albumSongStream {
    _$albumSongStreamAtom.reportRead();
    return super.albumSongStream;
  }

  bool _albumSongStreamIsInitialized = false;

  @override
  set albumSongStream(ObservableStream<List<Song>> value) {
    _$albumSongStreamAtom.reportWrite(
        value, _albumSongStreamIsInitialized ? super.albumSongStream : null,
        () {
      super.albumSongStream = value;
      _albumSongStreamIsInitialized = true;
    });
  }

  @override
  String toString() {
    return '''
albumSongStream: ${albumSongStream}
    ''';
  }
}
