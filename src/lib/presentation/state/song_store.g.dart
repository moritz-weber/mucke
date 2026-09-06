// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SongStore on _SongStore, Store {
  late final _$songStreamAtom =
      Atom(name: '_SongStore.songStream', context: context);

  @override
  ObservableStream<Song> get songStream {
    _$songStreamAtom.reportRead();
    return super.songStream;
  }

  bool _songStreamIsInitialized = false;

  @override
  set songStream(ObservableStream<Song> value) {
    _$songStreamAtom.reportWrite(
        value, _songStreamIsInitialized ? super.songStream : null, () {
      super.songStream = value;
      _songStreamIsInitialized = true;
    });
  }

  @override
  String toString() {
    return '''
songStream: ${songStream}
    ''';
  }
}
