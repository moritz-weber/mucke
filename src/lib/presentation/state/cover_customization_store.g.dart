// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cover_customization_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CoverCustomizationStore on _CoverCustomizationStore, Store {
  Computed<IconData>? _$iconComputed;

  @override
  IconData get icon => (_$iconComputed ??= Computed<IconData>(() => super.icon,
          name: '_CoverCustomizationStore.icon'))
      .value;
  Computed<Gradient>? _$gradientComputed;

  @override
  Gradient get gradient =>
      (_$gradientComputed ??= Computed<Gradient>(() => super.gradient,
              name: '_CoverCustomizationStore.gradient'))
          .value;

  late final _$iconStringAtom =
      Atom(name: '_CoverCustomizationStore.iconString', context: context);

  @override
  String get iconString {
    _$iconStringAtom.reportRead();
    return super.iconString;
  }

  @override
  set iconString(String value) {
    _$iconStringAtom.reportWrite(value, super.iconString, () {
      super.iconString = value;
    });
  }

  late final _$gradientStringAtom =
      Atom(name: '_CoverCustomizationStore.gradientString', context: context);

  @override
  String get gradientString {
    _$gradientStringAtom.reportRead();
    return super.gradientString;
  }

  @override
  set gradientString(String value) {
    _$gradientStringAtom.reportWrite(value, super.gradientString, () {
      super.gradientString = value;
    });
  }

  late final _$_CoverCustomizationStoreActionController =
      ActionController(name: '_CoverCustomizationStore', context: context);

  @override
  void setIconString(String iconString) {
    final _$actionInfo = _$_CoverCustomizationStoreActionController.startAction(
        name: '_CoverCustomizationStore.setIconString');
    try {
      return super.setIconString(iconString);
    } finally {
      _$_CoverCustomizationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGradient(String gradientString) {
    final _$actionInfo = _$_CoverCustomizationStoreActionController.startAction(
        name: '_CoverCustomizationStore.setGradient');
    try {
      return super.setGradient(gradientString);
    } finally {
      _$_CoverCustomizationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
iconString: ${iconString},
gradientString: ${gradientString},
icon: ${icon},
gradient: ${gradient}
    ''';
  }
}
