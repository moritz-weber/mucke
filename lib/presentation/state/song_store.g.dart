// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SongStore on _SongStore, Store {
  final _$songStreamAtom = Atom(name: '_SongStore.songStream');

  @override
  ObservableStream<Song> get songStream {
    _$songStreamAtom.reportRead();
    return super.songStream;
  }

  @override
  set songStream(ObservableStream<Song> value) {
    _$songStreamAtom.reportWrite(value, super.songStream, () {
      super.songStream = value;
    });
  }

  @override
  String toString() {
    return '''
songStream: ${songStream}
    ''';
  }
}
