// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whats_new_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WhatsNewFormStore on _WhatsNewFormStore, Store {
  late final _$autoDismissAtom =
      Atom(name: '_WhatsNewFormStore.autoDismiss', context: context);

  @override
  bool get autoDismiss {
    _$autoDismissAtom.reportRead();
    return super.autoDismiss;
  }

  bool _autoDismissIsInitialized = false;

  @override
  set autoDismiss(bool value) {
    _$autoDismissAtom.reportWrite(
        value, _autoDismissIsInitialized ? super.autoDismiss : null, () {
      super.autoDismiss = value;
      _autoDismissIsInitialized = true;
    });
  }

  @override
  String toString() {
    return '''
autoDismiss: ${autoDismiss}
    ''';
  }
}
