// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AudioStore on _AudioStore, Store {
  Computed<String>? _$positionStringComputed;

  @override
  String get positionString =>
      (_$positionStringComputed ??= Computed<String>(() => super.positionString,
              name: '_AudioStore.positionString'))
          .value;
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
  Computed<bool>? _$hasPreviousComputed;

  @override
  bool get hasPrevious =>
      (_$hasPreviousComputed ??= Computed<bool>(() => super.hasPrevious,
              name: '_AudioStore.hasPrevious'))
          .value;

  late final _$currentSongStreamAtom =
      Atom(name: '_AudioStore.currentSongStream', context: context);

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

  late final _$playingStreamAtom =
      Atom(name: '_AudioStore.playingStream', context: context);

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

  late final _$currentPositionStreamAtom =
      Atom(name: '_AudioStore.currentPositionStream', context: context);

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

  late final _$_queueAtom = Atom(name: '_AudioStore._queue', context: context);

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

  late final _$_availableSongsAtom =
      Atom(name: '_AudioStore._availableSongs', context: context);

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

  late final _$playableStreamAtom =
      Atom(name: '_AudioStore.playableStream', context: context);

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

  late final _$queueIndexStreamAtom =
      Atom(name: '_AudioStore.queueIndexStream', context: context);

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

  late final _$shuffleModeStreamAtom =
      Atom(name: '_AudioStore.shuffleModeStream', context: context);

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

  late final _$loopModeStreamAtom =
      Atom(name: '_AudioStore.loopModeStream', context: context);

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

  late final _$_AudioStoreActionController =
      ActionController(name: '_AudioStore', context: context);

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
positionString: ${positionString},
queueLength: ${queueLength},
numAvailableSongs: ${numAvailableSongs},
hasNext: ${hasNext},
hasPrevious: ${hasPrevious}
    ''';
  }
}
