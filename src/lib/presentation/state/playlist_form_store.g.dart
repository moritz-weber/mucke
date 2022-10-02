// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlaylistFormStore on _PlaylistStore, Store {
  Computed<int>? _$shuffleModeIndexComputed;

  @override
  int get shuffleModeIndex => (_$shuffleModeIndexComputed ??= Computed<int>(
          () => super.shuffleModeIndex,
          name: '_PlaylistStore.shuffleModeIndex'))
      .value;

  late final _$nameAtom = Atom(name: '_PlaylistStore.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$shuffleModeAtom =
      Atom(name: '_PlaylistStore.shuffleMode', context: context);

  @override
  ShuffleMode? get shuffleMode {
    _$shuffleModeAtom.reportRead();
    return super.shuffleMode;
  }

  @override
  set shuffleMode(ShuffleMode? value) {
    _$shuffleModeAtom.reportWrite(value, super.shuffleMode, () {
      super.shuffleMode = value;
    });
  }

  late final _$_PlaylistStoreActionController =
      ActionController(name: '_PlaylistStore', context: context);

  @override
  void setShuffleModeIndex(int index) {
    final _$actionInfo = _$_PlaylistStoreActionController.startAction(
        name: '_PlaylistStore.setShuffleModeIndex');
    try {
      return super.setShuffleModeIndex(index);
    } finally {
      _$_PlaylistStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
shuffleMode: ${shuffleMode},
shuffleModeIndex: ${shuffleModeIndex}
    ''';
  }
}

mixin _$FormErrorState on _FormErrorState, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_FormErrorState.hasErrors'))
          .value;

  late final _$nameAtom = Atom(name: '_FormErrorState.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  @override
  String toString() {
    return '''
name: ${name},
hasErrors: ${hasErrors}
    ''';
  }
}
