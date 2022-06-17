class PersonDetails {
  final DateTime dateOfBirth;
  final String name;
  final String country;
  final BirthLocation city;
  final bool exactTimeKnown;

  PersonDetails({
    required this.dateOfBirth,
    required this.name,
    required this.country,
    required this.exactTimeKnown,
    required this.city,
  });

  PersonDetails copyWith({
    DateTime? dateOfBirth,
    String? name,
    String? country,
    BirthLocation? city,
    bool? exactTimeKnown,
  }) =>
      PersonDetails(
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        name: name ?? this.name,
        country: country ?? this.country,
        city: city ?? this.city,
        exactTimeKnown: exactTimeKnown ?? this.exactTimeKnown,
      );
}

class BirthLocation {
  final String title;
  final double lat, lon;

  BirthLocation({
    this.title = '',
    this.lat = 0,
    this.lon = 0,
  });

  bool get isValidLocation => title != '' && lat != 0 && lon != 0;
}
