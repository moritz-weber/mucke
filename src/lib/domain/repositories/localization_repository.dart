import 'dart:ui';

import '../../l10n/localizations.dart';

abstract class LocalizationRepository {
  Locale get locale;
  set locale(Locale value);

  L10n get current;
}