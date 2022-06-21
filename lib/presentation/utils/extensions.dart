extension ComparableDateTime on DateTime {
  bool isSameDay(DateTime other) => day == other.day && month == other.month && year == other.year;

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? sec,
  }) =>
      DateTime(
        year ?? this.year,
        month ?? this.month,
        day ?? this.day,
        hour ?? this.hour,
        minute ?? this.minute,
        sec ?? second,
      );
}
