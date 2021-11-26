// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AudioStore on _AudioStore, Store {
  final _$currentSongStreamAtom = Atom(name: '_AudioStore.currentSongStream');

  @override
  ObservableStream<Song> get currentSongStream {
    _$currentSongStreamAtom.reportRead();
    return super.currentSongStream;
  }

  @override
  set currentSongStream(ObservableStream<Song> value) {
    _$currentSongStreamAtom.reportWrite(value, super.currentSongStream, () {
      super.currentSongStream = value;
    });
  }

  final _$playingStreamAtom = Atom(name: '_AudioStore.playingStream');

  @override
  ObservableStream<bool> get playingStream {
    _$playingStreamAtom.reportRead();
    return super.playingStream;
  }

  @override
  set playingStream(ObservableStream<bool> value) {
    _$playingStreamAtom.reportWrite(value, super.playingStream, () {
      super.playingStream = value;
    });
  }

  final _$currentPositionStreamAtom =
      Atom(name: '_AudioStore.currentPositionStream');

  @override
  ObservableStream<Duration> get currentPositionStream {
    _$currentPositionStreamAtom.reportRead();
    return super.currentPositionStream;
  }

  @override
  set currentPositionStream(ObservableStream<Duration> value) {
    _$currentPositionStreamAtom.reportWrite(value, super.currentPositionStream,
        () {
      super.currentPositionStream = value;
    });
  }

  final _$queueStreamAtom = Atom(name: '_AudioStore.queueStream');

  @override
  ObservableStream<List<Song>> get queueStream {
    _$queueStreamAtom.reportRead();
    return super.queueStream;
  }

  @override
  set queueStream(ObservableStream<List<Song>> value) {
    _$queueStreamAtom.reportWrite(value, super.queueStream, () {
      super.queueStream = value;
    });
  }

  final _$queueIndexStreamAtom = Atom(name: '_AudioStore.queueIndexStream');

  @override
  ObservableStream<int> get queueIndexStream {
    _$queueIndexStreamAtom.reportRead();
    return super.queueIndexStream;
  }

  @override
  set queueIndexStream(ObservableStream<int> value) {
    _$queueIndexStreamAtom.reportWrite(value, super.queueIndexStream, () {
      super.queueIndexStream = value;
    });
  }

  final _$shuffleModeStreamAtom = Atom(name: '_AudioStore.shuffleModeStream');

  @override
  ObservableStream<ShuffleMode> get shuffleModeStream {
    _$shuffleModeStreamAtom.reportRead();
    return super.shuffleModeStream;
  }

  @override
  set shuffleModeStream(ObservableStream<ShuffleMode> value) {
    _$shuffleModeStreamAtom.reportWrite(value, super.shuffleModeStream, () {
      super.shuffleModeStream = value;
    });
  }

  final _$loopModeStreamAtom = Atom(name: '_AudioStore.loopModeStream');

  @override
  ObservableStream<LoopMode> get loopModeStream {
    _$loopModeStreamAtom.reportRead();
    return super.loopModeStream;
  }

  @override
  set loopModeStream(ObservableStream<LoopMode> value) {
    _$loopModeStreamAtom.reportWrite(value, super.loopModeStream, () {
      super.loopModeStream = value;
    });
  }

  final _$excludeBlockedStreamAtom =
      Atom(name: '_AudioStore.excludeBlockedStream');

  @override
  ObservableStream<bool> get excludeBlockedStream {
    _$excludeBlockedStreamAtom.reportRead();
    return super.excludeBlockedStream;
  }

  @override
  set excludeBlockedStream(ObservableStream<bool> value) {
    _$excludeBlockedStreamAtom.reportWrite(value, super.excludeBlockedStream,
        () {
      super.excludeBlockedStream = value;
    });
  }

  final _$excludeSkippedStreamAtom =
      Atom(name: '_AudioStore.excludeSkippedStream');

  @override
  ObservableStream<bool> get excludeSkippedStream {
    _$excludeSkippedStreamAtom.reportRead();
    return super.excludeSkippedStream;
  }

  @override
  set excludeSkippedStream(ObservableStream<bool> value) {
    _$excludeSkippedStreamAtom.reportWrite(value, super.excludeSkippedStream,
        () {
      super.excludeSkippedStream = value;
    });
  }

  final _$respectSongLinksStreamAtom =
      Atom(name: '_AudioStore.respectSongLinksStream');

  @override
  ObservableStream<bool> get respectSongLinksStream {
    _$respectSongLinksStreamAtom.reportRead();
    return super.respectSongLinksStream;
  }

  @override
  set respectSongLinksStream(ObservableStream<bool> value) {
    _$respectSongLinksStreamAtom
        .reportWrite(value, super.respectSongLinksStream, () {
      super.respectSongLinksStream = value;
    });
  }

  @override
  String toString() {
    return '''
currentSongStream: ${currentSongStream},
playingStream: ${playingStream},
currentPositionStream: ${currentPositionStream},
queueStream: ${queueStream},
queueIndexStream: ${queueIndexStream},
shuffleModeStream: ${shuffleModeStream},
loopModeStream: ${loopModeStream},
excludeBlockedStream: ${excludeBlockedStream},
excludeSkippedStream: ${excludeSkippedStream},
respectSongLinksStream: ${respectSongLinksStream}
    ''';
  }
}
