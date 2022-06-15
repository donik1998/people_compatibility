class Comparison {
  final String femaleName;
  final String maleName;
  final DateTime date;

  Comparison({
    required this.femaleName,
    required this.maleName,
    required this.date,
  });

  factory Comparison.fromJson(Map<String, dynamic> json) => Comparison(
        femaleName: json['female_name'],
        maleName: json['male_name'],
        date: DateTime.parse(json['date']),
      );

  Map<String, dynamic> get toMap => {
        'female_name': femaleName,
        'male_name': maleName,
        'date': date.toIso8601String(),
      };
}
