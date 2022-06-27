import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:people_compatibility/core/models/compatibility_response.dart';
import 'package:people_compatibility/core/models/person_details.dart';
import 'package:people_compatibility/data/database_repository.dart';
import 'package:people_compatibility/presentation/provider/base_notifier.dart';

class CalculateCompatibilityPageState extends BaseNotifier {
  CompatibilityResponse? calculationResponse;

  bool hasError = false;

  int selectedIndex = 0;

  final List<String> compatibilityLevelTitles = [
    'shared_views'.tr(),
    'comfort'.tr(),
    'relationships'.tr(),
    'care'.tr(),
    'erotic_compatibility'.tr(),
    'partnership'.tr(),
    'shared_interest'.tr(),
    'feel_sharpness'.tr(),
    'openness'.tr(),
    'practicality'.tr(),
    'trust'.tr(),
    'romance'.tr(),
  ];

  final List<String> compatibilityDescriptions = [
    'shared_views_description'.tr(),
    'comfort_description'.tr(),
    'relationships_description'.tr(),
    'care_description'.tr(),
    'erotic_compatibility_description'.tr(),
    'partnership_description'.tr(),
    'shared_interest_description'.tr(),
    'feel_sharpness_description'.tr(),
    'openness_description'.tr(),
    'practicality_description'.tr(),
    'trust_description'.tr(),
    'romance_description'.tr(),
  ];

  ScrollController scrollController = ScrollController();

  void setCalculationResponse({
    required CompatibilityResponse response,
    required PersonDetails male,
    required PersonDetails female,
    required bool shouldSaveToDd,
  }) {
    calculationResponse = response;
    notifyListeners();
    if (shouldSaveToDd) {
      DatabaseService.instance.saveData(
        maleName: male,
        femaleName: female,
        date: DateTime.now(),
        response: response,
      );
    }
  }

  void setError(bool value) {
    hasError = value;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
