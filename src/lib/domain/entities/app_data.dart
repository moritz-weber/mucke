class AppData {
  AppData(
      {required this.appVersion,
      required this.buildNumber,
      required this.dbVersion,
      this.generalSettings});

  final String appVersion;
  final int buildNumber;
  final int dbVersion;

  final Map<String, dynamic>? generalSettings;
}

class DataSelection {
  DataSelection({
    required this.generalSettings,
  });

  final bool generalSettings;
}
