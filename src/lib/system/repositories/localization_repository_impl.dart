import 'dart:ui';

import 'package:mucke/l10n/localizations.dart';

import '../../domain/repositories/localization_repository.dart';

class LocalizationRepositoryImpl implements LocalizationRepository {
  @override
  Locale get locale => _locale;

  @override
  set locale(Locale value) {
    _locale = value;
  }

  Locale _locale = const Locale('en');

  @override
  L10n get current => lookupL10n(_locale);
}
