// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsPageStore on _SettingsPageStore, Store {
  final _$isBlockSkippedSongsEnabledAtom =
      Atom(name: '_SettingsPageStore.isBlockSkippedSongsEnabled');

  @override
  bool get isBlockSkippedSongsEnabled {
    _$isBlockSkippedSongsEnabledAtom.reportRead();
    return super.isBlockSkippedSongsEnabled;
  }

  @override
  set isBlockSkippedSongsEnabled(bool value) {
    _$isBlockSkippedSongsEnabledAtom
        .reportWrite(value, super.isBlockSkippedSongsEnabled, () {
      super.isBlockSkippedSongsEnabled = value;
    });
  }

  final _$blockSkippedSongsThresholdAtom =
      Atom(name: '_SettingsPageStore.blockSkippedSongsThreshold');

  @override
  String get blockSkippedSongsThreshold {
    _$blockSkippedSongsThresholdAtom.reportRead();
    return super.blockSkippedSongsThreshold;
  }

  @override
  set blockSkippedSongsThreshold(String value) {
    _$blockSkippedSongsThresholdAtom
        .reportWrite(value, super.blockSkippedSongsThreshold, () {
      super.blockSkippedSongsThreshold = value;
    });
  }

  final _$initAsyncAction = AsyncAction('_SettingsPageStore.init');

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  @override
  String toString() {
    return '''
isBlockSkippedSongsEnabled: ${isBlockSkippedSongsEnabled},
blockSkippedSongsThreshold: ${blockSkippedSongsThreshold}
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

  final _$skipCountThresholdAtom =
      Atom(name: '_FormErrorState.skipCountThreshold');

  @override
  String? get skipCountThreshold {
    _$skipCountThresholdAtom.reportRead();
    return super.skipCountThreshold;
  }

  @override
  set skipCountThreshold(String? value) {
    _$skipCountThresholdAtom.reportWrite(value, super.skipCountThreshold, () {
      super.skipCountThreshold = value;
    });
  }

  @override
  String toString() {
    return '''
skipCountThreshold: ${skipCountThreshold},
hasErrors: ${hasErrors}
    ''';
  }
}
