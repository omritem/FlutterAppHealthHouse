String convertToUtcIsoString(DateTime? dateTime) {
  if (dateTime == null) return '';
  return dateTime.toUtc().toIso8601String();
}
