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

  bool _currentSongStreamIsInitialized = false;

  @override
  set currentSongStream(ObservableStream<Song?> value) {
    _$currentSongStreamAtom.reportWrite(
        value, _currentSongStreamIsInitialized ? super.currentSongStream : null,
        () {
      super.currentSongStream = value;
      _currentSongStreamIsInitialized = true;
    });
  }

  late final _$playingStreamAtom =
      Atom(name: '_AudioStore.playingStream', context: context);

  @override
  ObservableStream<bool> get playingStream {
    _$playingStreamAtom.reportRead();
    return super.playingStream;
  }

  bool _playingStreamIsInitialized = false;

  @override
  set playingStream(ObservableStream<bool> value) {
    _$playingStreamAtom.reportWrite(
        value, _playingStreamIsInitialized ? super.playingStream : null, () {
      super.playingStream = value;
      _playingStreamIsInitialized = true;
    });
  }

  late final _$currentPositionStreamAtom =
      Atom(name: '_AudioStore.currentPositionStream', context: context);

  @override
  ObservableStream<Duration> get currentPositionStream {
    _$currentPositionStreamAtom.reportRead();
    return super.currentPositionStream;
  }

  bool _currentPositionStreamIsInitialized = false;

  @override
  set currentPositionStream(ObservableStream<Duration> value) {
    _$currentPositionStreamAtom.reportWrite(
        value,
        _currentPositionStreamIsInitialized
            ? super.currentPositionStream
            : null, () {
      super.currentPositionStream = value;
      _currentPositionStreamIsInitialized = true;
    });
  }

  late final _$queueStreamAtom =
      Atom(name: '_AudioStore.queueStream', context: context);

  @override
  ObservableStream<List<QueueItem>> get queueStream {
    _$queueStreamAtom.reportRead();
    return super.queueStream;
  }

  bool _queueStreamIsInitialized = false;

  @override
  set queueStream(ObservableStream<List<QueueItem>> value) {
    _$queueStreamAtom.reportWrite(
        value, _queueStreamIsInitialized ? super.queueStream : null, () {
      super.queueStream = value;
      _queueStreamIsInitialized = true;
    });
  }

  late final _$_queueAtom = Atom(name: '_AudioStore._queue', context: context);

  List<QueueItem> get queue {
    _$_queueAtom.reportRead();
    return super._queue;
  }

  @override
  List<QueueItem> get _queue => queue;

  bool __queueIsInitialized = false;

  @override
  set _queue(List<QueueItem> value) {
    _$_queueAtom.reportWrite(value, __queueIsInitialized ? super._queue : null,
        () {
      super._queue = value;
      __queueIsInitialized = true;
    });
  }

  late final _$_availableSongsAtom =
      Atom(name: '_AudioStore._availableSongs', context: context);

  @override
  List<QueueItem> get _availableSongs {
    _$_availableSongsAtom.reportRead();
    return super._availableSongs;
  }

  bool __availableSongsIsInitialized = false;

  @override
  set _availableSongs(List<QueueItem> value) {
    _$_availableSongsAtom.reportWrite(
        value, __availableSongsIsInitialized ? super._availableSongs : null,
        () {
      super._availableSongs = value;
      __availableSongsIsInitialized = true;
    });
  }

  late final _$playableStreamAtom =
      Atom(name: '_AudioStore.playableStream', context: context);

  @override
  ObservableStream<Playable> get playableStream {
    _$playableStreamAtom.reportRead();
    return super.playableStream;
  }

  bool _playableStreamIsInitialized = false;

  @override
  set playableStream(ObservableStream<Playable> value) {
    _$playableStreamAtom.reportWrite(
        value, _playableStreamIsInitialized ? super.playableStream : null, () {
      super.playableStream = value;
      _playableStreamIsInitialized = true;
    });
  }

  late final _$queueIndexStreamAtom =
      Atom(name: '_AudioStore.queueIndexStream', context: context);

  @override
  ObservableStream<int?> get queueIndexStream {
    _$queueIndexStreamAtom.reportRead();
    return super.queueIndexStream;
  }

  bool _queueIndexStreamIsInitialized = false;

  @override
  set queueIndexStream(ObservableStream<int?> value) {
    _$queueIndexStreamAtom.reportWrite(
        value, _queueIndexStreamIsInitialized ? super.queueIndexStream : null,
        () {
      super.queueIndexStream = value;
      _queueIndexStreamIsInitialized = true;
    });
  }

  late final _$shuffleModeStreamAtom =
      Atom(name: '_AudioStore.shuffleModeStream', context: context);

  @override
  ObservableStream<ShuffleMode> get shuffleModeStream {
    _$shuffleModeStreamAtom.reportRead();
    return super.shuffleModeStream;
  }

  bool _shuffleModeStreamIsInitialized = false;

  @override
  set shuffleModeStream(ObservableStream<ShuffleMode> value) {
    _$shuffleModeStreamAtom.reportWrite(
        value, _shuffleModeStreamIsInitialized ? super.shuffleModeStream : null,
        () {
      super.shuffleModeStream = value;
      _shuffleModeStreamIsInitialized = true;
    });
  }

  late final _$loopModeStreamAtom =
      Atom(name: '_AudioStore.loopModeStream', context: context);

  @override
  ObservableStream<LoopMode> get loopModeStream {
    _$loopModeStreamAtom.reportRead();
    return super.loopModeStream;
  }

  bool _loopModeStreamIsInitialized = false;

  @override
  set loopModeStream(ObservableStream<LoopMode> value) {
    _$loopModeStreamAtom.reportWrite(
        value, _loopModeStreamIsInitialized ? super.loopModeStream : null, () {
      super.loopModeStream = value;
      _loopModeStreamIsInitialized = true;
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
queueStream: ${queueStream},
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
