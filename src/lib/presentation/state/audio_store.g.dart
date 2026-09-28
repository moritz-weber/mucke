// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AudioStore on _AudioStore, Store {
  Computed<Song?>? _$currentSongComputed;

  @override
  Song? get currentSong =>
      (_$currentSongComputed ??= Computed<Song?>(() => super.currentSong,
              name: '_AudioStore.currentSong'))
          .value;
  Computed<int?>? _$currentIndexComputed;

  @override
  int? get currentIndex =>
      (_$currentIndexComputed ??= Computed<int?>(() => super.currentIndex,
              name: '_AudioStore.currentIndex'))
          .value;
  Computed<List<QueueItem>>? _$queueComputed;

  @override
  List<QueueItem> get queue =>
      (_$queueComputed ??= Computed<List<QueueItem>>(() => super.queue,
              name: '_AudioStore.queue'))
          .value;
  Computed<int>? _$queueLengthComputed;

  @override
  int get queueLength =>
      (_$queueLengthComputed ??= Computed<int>(() => super.queueLength,
              name: '_AudioStore.queueLength'))
          .value;
  Computed<ShuffleMode>? _$shuffleModeComputed;

  @override
  ShuffleMode get shuffleMode =>
      (_$shuffleModeComputed ??= Computed<ShuffleMode>(() => super.shuffleMode,
              name: '_AudioStore.shuffleMode'))
          .value;
  Computed<LoopMode>? _$loopModeComputed;

  @override
  LoopMode get loopMode =>
      (_$loopModeComputed ??= Computed<LoopMode>(() => super.loopMode,
              name: '_AudioStore.loopMode'))
          .value;
  Computed<Playable?>? _$playableComputed;

  @override
  Playable? get playable =>
      (_$playableComputed ??= Computed<Playable?>(() => super.playable,
              name: '_AudioStore.playable'))
          .value;
  Computed<String>? _$positionStringComputed;

  @override
  String get positionString =>
      (_$positionStringComputed ??= Computed<String>(() => super.positionString,
              name: '_AudioStore.positionString'))
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

  late final _$stateAtom = Atom(name: '_AudioStore.state', context: context);

  @override
  AudioPlayerState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AudioPlayerState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
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

  late final _$showLyricsAtom =
      Atom(name: '_AudioStore.showLyrics', context: context);

  @override
  bool get showLyrics {
    _$showLyricsAtom.reportRead();
    return super.showLyrics;
  }

  @override
  set showLyrics(bool value) {
    _$showLyricsAtom.reportWrite(value, super.showLyrics, () {
      super.showLyrics = value;
    });
  }

  late final _$_AudioStoreActionController =
      ActionController(name: '_AudioStore', context: context);

  @override
  void _onState(AudioPlayerState next) {
    final _$actionInfo =
        _$_AudioStoreActionController.startAction(name: '_AudioStore._onState');
    try {
      return super._onState(next);
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
  void toggleShowLyrics() {
    final _$actionInfo = _$_AudioStoreActionController.startAction(
        name: '_AudioStore.toggleShowLyrics');
    try {
      return super.toggleShowLyrics();
    } finally {
      _$_AudioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
playingStream: ${playingStream},
currentPositionStream: ${currentPositionStream},
showLyrics: ${showLyrics},
currentSong: ${currentSong},
currentIndex: ${currentIndex},
queue: ${queue},
queueLength: ${queueLength},
shuffleMode: ${shuffleMode},
loopMode: ${loopMode},
playable: ${playable},
positionString: ${positionString},
numAvailableSongs: ${numAvailableSongs},
hasNext: ${hasNext},
hasPrevious: ${hasPrevious}
    ''';
  }
}
