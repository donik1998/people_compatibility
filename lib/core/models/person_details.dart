class PersonDetails {
  final DateTime dateOfBirth;
  final String name;
  final String country;
  final String city;

  PersonDetails({
    required this.dateOfBirth,
    required this.name,
    required this.country,
    required this.city,
  });

  PersonDetails copyWith({
    DateTime? dateOfBirth,
    String? name,
    String? country,
    String? city,
  }) =>
      PersonDetails(
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        name: name ?? this.name,
        country: country ?? this.country,
        city: city ?? this.city,
      );
}
