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

  ZodiacData zodiacName() {
    /// Aries (March 21 – April 19)
    final aries = (dateOfBirth.month == DateTime.march && dateOfBirth.day >= 21) ||
        (dateOfBirth.month == DateTime.april && dateOfBirth.day <= 19);

    /// Taurus (April 20 – May 20)
    final taurus =
        (dateOfBirth.month == DateTime.april && dateOfBirth.day >= 20) || (dateOfBirth.month == DateTime.may && dateOfBirth.day <= 20);

    /// Gemini (May 21 – June 20)
    final gemini =
        (dateOfBirth.month == DateTime.may && dateOfBirth.day >= 21) || (dateOfBirth.month == DateTime.june && dateOfBirth.day <= 20);

    /// Cancer (June 21 – July 22)
    final cancer =
        (dateOfBirth.month == DateTime.june && dateOfBirth.day >= 21) || (dateOfBirth.month == DateTime.july && dateOfBirth.day <= 21);

    /// Leo (July 23 – August 22)
    final leo = (dateOfBirth.month == DateTime.july && dateOfBirth.day >= 23) ||
        (dateOfBirth.month == DateTime.august && dateOfBirth.day <= 22);

    /// Virgo (August 23 – September 22)
    final virgo = (dateOfBirth.month == DateTime.august && dateOfBirth.day >= 23) ||
        (dateOfBirth.month == DateTime.september && dateOfBirth.day <= 22);

    /// Libra (September 23 – October 22)
    final libra = (dateOfBirth.month == DateTime.september && dateOfBirth.day >= 23) ||
        (dateOfBirth.month == DateTime.october && dateOfBirth.day <= 22);

    /// Scorpio (October 23 – November 21)
    final scorpio = (dateOfBirth.month == DateTime.october && dateOfBirth.day >= 23) ||
        (dateOfBirth.month == DateTime.november && dateOfBirth.day <= 21);

    /// Sagittarius (November 22 – December 21)
    final sagittarius = (dateOfBirth.month == DateTime.november && dateOfBirth.day >= 22) ||
        (dateOfBirth.month == DateTime.december && dateOfBirth.day <= 21);

    /// Capricorn (December 22 – January 19)
    final capricorn = (dateOfBirth.month == DateTime.december && dateOfBirth.day >= 22) ||
        (dateOfBirth.month == DateTime.january && dateOfBirth.day <= 19);

    /// Aquarius (January 20 – February 18)
    final aquarius = (dateOfBirth.month == DateTime.january && dateOfBirth.day >= 20) ||
        (dateOfBirth.month == DateTime.february && dateOfBirth.day <= 18);

    /// Pisces (February 19 – March 20)
    final pisces = (dateOfBirth.month == DateTime.february && dateOfBirth.day >= 19) ||
        (dateOfBirth.month == DateTime.march && dateOfBirth.day <= 20);
    if (aries) {
      return ZodiacData(title: 'Овен', pathName: 'aries');
    } else if (taurus) {
      return ZodiacData(title: 'Телец', pathName: 'taurus');
    } else if (gemini) {
      return ZodiacData(title: 'Близнецы', pathName: 'gemini');
    } else if (cancer) {
      return ZodiacData(title: 'Рак', pathName: 'cancer');
    } else if (leo) {
      return ZodiacData(title: 'Лев', pathName: 'leo');
    } else if (virgo) {
      return ZodiacData(title: 'Дева', pathName: 'virgo');
    } else if (libra) {
      return ZodiacData(title: 'Весы', pathName: 'libra');
    } else if (scorpio) {
      return ZodiacData(title: 'Скорпион', pathName: 'scorpio');
    } else if (sagittarius) {
      return ZodiacData(title: 'Стрелец', pathName: 'sagittarius');
    } else if (capricorn) {
      return ZodiacData(title: 'Козерог', pathName: 'capricorn');
    } else if (aquarius) {
      return ZodiacData(title: 'Водолей', pathName: 'aquarius');
    } else if (pisces) {
      return ZodiacData(title: 'Рыбы', pathName: 'pisces');
    } else {
      return ZodiacData(title: '', pathName: '');
    }
  }
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

class ZodiacData {
  final String title;
  final String pathName;

  ZodiacData({
    required this.title,
    required this.pathName,
  });
}
