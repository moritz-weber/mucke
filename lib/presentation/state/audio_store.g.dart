// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AudioStore on _AudioStore, Store {
  final _$currentSongAtom = Atom(name: '_AudioStore.currentSong');

  @override
  ObservableStream<Song> get currentSong {
    _$currentSongAtom.reportRead();
    return super.currentSong;
  }

  @override
  set currentSong(ObservableStream<Song> value) {
    _$currentSongAtom.reportWrite(value, super.currentSong, () {
      super.currentSong = value;
    });
  }

  final _$songAtom = Atom(name: '_AudioStore.song');

  @override
  Song get song {
    _$songAtom.reportRead();
    return super.song;
  }

  @override
  set song(Song value) {
    _$songAtom.reportWrite(value, super.song, () {
      super.song = value;
    });
  }

  final _$playbackStateStreamAtom =
      Atom(name: '_AudioStore.playbackStateStream');

  @override
  ObservableStream<PlaybackState> get playbackStateStream {
    _$playbackStateStreamAtom.reportRead();
    return super.playbackStateStream;
  }

  @override
  set playbackStateStream(ObservableStream<PlaybackState> value) {
    _$playbackStateStreamAtom.reportWrite(value, super.playbackStateStream, () {
      super.playbackStateStream = value;
    });
  }

  final _$currentPositionStreamAtom =
      Atom(name: '_AudioStore.currentPositionStream');

  @override
  ObservableStream<int> get currentPositionStream {
    _$currentPositionStreamAtom.reportRead();
    return super.currentPositionStream;
  }

  @override
  set currentPositionStream(ObservableStream<int> value) {
    _$currentPositionStreamAtom.reportWrite(value, super.currentPositionStream,
        () {
      super.currentPositionStream = value;
    });
  }

  final _$playSongAsyncAction = AsyncAction('_AudioStore.playSong');

  @override
  Future<void> playSong(int index, List<Song> songList) {
    return _$playSongAsyncAction.run(() => super.playSong(index, songList));
  }

  final _$playAsyncAction = AsyncAction('_AudioStore.play');

  @override
  Future<void> play() {
    return _$playAsyncAction.run(() => super.play());
  }

  final _$pauseAsyncAction = AsyncAction('_AudioStore.pause');

  @override
  Future<void> pause() {
    return _$pauseAsyncAction.run(() => super.pause());
  }

  final _$updateSongAsyncAction = AsyncAction('_AudioStore.updateSong');

  @override
  Future<void> updateSong(Song streamValue) {
    return _$updateSongAsyncAction.run(() => super.updateSong(streamValue));
  }

  final _$_AudioStoreActionController = ActionController(name: '_AudioStore');

  @override
  void init() {
    final _$actionInfo =
        _$_AudioStoreActionController.startAction(name: '_AudioStore.init');
    try {
      return super.init();
    } finally {
      _$_AudioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentSong: ${currentSong},
song: ${song},
playbackStateStream: ${playbackStateStream},
currentPositionStream: ${currentPositionStream}
    ''';
  }
}
