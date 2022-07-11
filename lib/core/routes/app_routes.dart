import 'package:people_compatibility/core/models/person_details.dart';

class AppRoutes {
  AppRoutes._();

  static const initial = '/';
  static const firstPartnerComparisonData = '/first_partner_comparison_data';
  static const secondPartnerComparisonData = '/second_partner_comparison_data';
  static const calculateCompatibility = '/calculate_compatibility';
}

class SecondPartnerDataPageArguments {
  final PersonDetails maleData;

  SecondPartnerDataPageArguments({required this.maleData});
}

class CalculateCompatibilityPageArguments {
  final PersonDetails maleData, femaleData;
  final bool shouldSaveToLocalDb;

  CalculateCompatibilityPageArguments({
    required this.maleData,
    required this.femaleData,
    this.shouldSaveToLocalDb = true,
  });
}
