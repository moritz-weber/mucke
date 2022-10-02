import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../gradients.dart';
import '../icons.dart';

part 'cover_customization_store.g.dart';

class CoverCustomizationStore extends _CoverCustomizationStore with _$CoverCustomizationStore {
  CoverCustomizationStore({
    required String iconString,
    required String gradientString,
  }) : super(iconString, gradientString);
}

abstract class _CoverCustomizationStore with Store {
  _CoverCustomizationStore(
    this.iconString,
    this.gradientString,
  ) {
    initialGradientString = gradientString;
    initialIconString = iconString;
  }

  late String initialIconString;
  late String initialGradientString;

  @observable
  String iconString;

  @observable
  String gradientString;

  @computed
  IconData get icon => CUSTOM_ICONS[iconString]!;

  @computed
  Gradient get gradient => CUSTOM_GRADIENTS[gradientString]!;

  @action
  void setIconString(String iconString) {
    this.iconString = iconString;
  }

  @action
  void setGradient(String gradientString) {
    this.gradientString = gradientString;
  }
}
