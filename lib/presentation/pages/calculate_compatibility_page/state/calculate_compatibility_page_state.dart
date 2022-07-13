import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:people_compatibility/core/models/compatibility_response.dart';
import 'package:people_compatibility/core/models/person_details.dart';
import 'package:people_compatibility/data/database_repository.dart';
import 'package:people_compatibility/presentation/provider/base_notifier.dart';

class CalculateCompatibilityPageState extends BaseNotifier {
  CompatibilityResponse? calculationResponse;

  bool hasError = false;

  int selectedBarIndex = 0;

  int expandedIndex = 0;

  final List<String> compatibilityLevelTitles = [
    'erotic_compatibility'.tr(),
    'comfort'.tr(),
    'relationships'.tr(),
    'care'.tr(),
    'shared_views'.tr(),
    'partnership'.tr(),
    'shared_interest'.tr(),
    'feel_sharpness'.tr(),
    'openness'.tr(),
    'practicality'.tr(),
    'trust'.tr(),
    'romance'.tr(),
  ];

  final List<String> compatibilityDescriptions = [
    'erotic_compatibility_description'.tr(),
    'comfort_description'.tr(),
    'relationships_description'.tr(),
    'care_description'.tr(),
    'shared_views_description'.tr(),
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
    setExpandedIndexFromKoeff(response.koeffSum ?? -1);
  }

  void setExpandedIndexFromKoeff(int koeff) {
    if (koeff > 400 && expandedIndex != 0) {
      setExpandedIndex(0);
    }
    if (koeff >= 300 && koeff < 400 && expandedIndex != 1) {
      setExpandedIndex(1);
    }
    if (koeff >= 200 && koeff < 300 && expandedIndex != 2) {
      setExpandedIndex(2);
    }
    if (koeff >= 100 && koeff < 200 && expandedIndex != 3) {
      setExpandedIndex(3);
    }
    if (koeff >= 50 && koeff < 100 && expandedIndex != 4) {
      setExpandedIndex(4);
    }
    if (koeff >= 0 && koeff < 50 && expandedIndex != 5) {
      setExpandedIndex(5);
    }
  }

  void setError(bool value) {
    hasError = value;
    notifyListeners();
  }

  void setSelectedBarIndex(int index) {
    selectedBarIndex = index;
    notifyListeners();
  }

  void setExpandedIndex(int value) {
    if (expandedIndex == value) {
      expandedIndex = -1;
    } else {
      expandedIndex = value;
    }
    notifyListeners();
  }
}
