int? parseYear(String? yearString) {
  if (yearString == null || yearString == '') {
    return null;
  }

  try {
    return int.parse(yearString);
  } on FormatException {
    return int.parse(yearString.split('-')[0]);
  }
}
