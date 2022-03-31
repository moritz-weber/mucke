// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AudioStore on _AudioStore, Store {
  Computed<int>? _$queueLengthComputed;

  @override
  int get queueLength =>
      (_$queueLengthComputed ??= Computed<int>(() => super.queueLength,
              name: '_AudioStore.queueLength'))
          .value;
  Computed<int>? _$numAvailableSongsComputed;

  @override
  int get numAvailableSongs => (_$numAvailableSongsComputed ??= Computed<int>(
          () => super.numAvailableSongs,
          name: '_AudioStore.numAvailableSongs'))
      .value;
  Computed<bool>? _$hasNextComputed;

  @override
  bool get hasNext => (_$hasNextComputed ??=
          Computed<bool>(() => super.hasNext, name: '_AudioStore.hasNext'))
      .value;

  final _$currentSongStreamAtom = Atom(name: '_AudioStore.currentSongStream');

  @override
  ObservableStream<Song?> get currentSongStream {
    _$currentSongStreamAtom.reportRead();
    return super.currentSongStream;
  }

  @override
  set currentSongStream(ObservableStream<Song?> value) {
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

  final _$_queueAtom = Atom(name: '_AudioStore._queue');

  List<QueueItem> get queue {
    _$_queueAtom.reportRead();
    return super._queue;
  }

  @override
  List<QueueItem> get _queue => queue;

  @override
  set _queue(List<QueueItem> value) {
    _$_queueAtom.reportWrite(value, super._queue, () {
      super._queue = value;
    });
  }

  final _$_availableSongsAtom = Atom(name: '_AudioStore._availableSongs');

  @override
  List<QueueItem> get _availableSongs {
    _$_availableSongsAtom.reportRead();
    return super._availableSongs;
  }

  @override
  set _availableSongs(List<QueueItem> value) {
    _$_availableSongsAtom.reportWrite(value, super._availableSongs, () {
      super._availableSongs = value;
    });
  }

  final _$playableStreamAtom = Atom(name: '_AudioStore.playableStream');

  @override
  ObservableStream<Playable> get playableStream {
    _$playableStreamAtom.reportRead();
    return super.playableStream;
  }

  @override
  set playableStream(ObservableStream<Playable> value) {
    _$playableStreamAtom.reportWrite(value, super.playableStream, () {
      super.playableStream = value;
    });
  }

  final _$queueIndexStreamAtom = Atom(name: '_AudioStore.queueIndexStream');

  @override
  ObservableStream<int?> get queueIndexStream {
    _$queueIndexStreamAtom.reportRead();
    return super.queueIndexStream;
  }

  @override
  set queueIndexStream(ObservableStream<int?> value) {
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

  final _$_AudioStoreActionController = ActionController(name: '_AudioStore');

  @override
  void _setQueue(List<QueueItem> queue) {
    final _$actionInfo = _$_AudioStoreActionController.startAction(
        name: '_AudioStore._setQueue');
    try {
      return super._setQueue(queue);
    } finally {
      _$_AudioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setAvSongs() {
    final _$actionInfo = _$_AudioStoreActionController.startAction(
        name: '_AudioStore._setAvSongs');
    try {
      return super._setAvSongs();
    } finally {
      _$_AudioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentSongStream: ${currentSongStream},
playingStream: ${playingStream},
currentPositionStream: ${currentPositionStream},
playableStream: ${playableStream},
queueIndexStream: ${queueIndexStream},
shuffleModeStream: ${shuffleModeStream},
loopModeStream: ${loopModeStream},
queueLength: ${queueLength},
numAvailableSongs: ${numAvailableSongs},
hasNext: ${hasNext}
    ''';
  }
}
