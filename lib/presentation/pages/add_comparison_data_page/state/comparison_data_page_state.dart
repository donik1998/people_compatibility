import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:people_compatibility/core/models/birthday_data.dart';
import 'package:people_compatibility/core/models/city_geocode_response.dart';
import 'package:people_compatibility/core/models/city_search_response.dart';
import 'package:people_compatibility/core/models/person_details.dart';
import 'package:people_compatibility/core/models/place_search_response.dart';
import 'package:people_compatibility/domain/remote/search_place_repository.dart';
import 'package:people_compatibility/presentation/provider/base_notifier.dart';
import 'package:people_compatibility/presentation/utils/async_debouncer.dart';
import 'package:people_compatibility/presentation/utils/enums.dart';
import 'package:people_compatibility/presentation/utils/extensions.dart';

class ComparisonDataPageState extends BaseNotifier {
  final ScrollController scrollController = ScrollController();
  late final TextEditingController nameController = TextEditingController(text: male.name);
  late final TextEditingController countryController = TextEditingController(text: male.country);
  late final TextEditingController cityController = TextEditingController(text: male.city.title);
  Completer completer = Completer();
  PlaceSearchResponse? searchResponse;
  List<SearchPrediction> filteredCities = List.empty(growable: true);
  bool searchError = false;
  CityGeocodeResponse? cityLocationResponse;
  final Debouncer callDebouncer = Debouncer(milliseconds: 250);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String errorMessage = '';

  PersonDetails male = PersonDetails(
    exactTimeUnknown: false,
    dateOfBirth: DateTime.now(),
    name: '',
    country: '',
    city: BirthLocation(),
  );

  PersonDetails female = PersonDetails(
    exactTimeUnknown: false,
    dateOfBirth: DateTime.now(),
    name: '',
    country: '',
    city: BirthLocation(),
  );

  String maleValidationErrorMessage = '';

  String femaleValidationErrorMessage = '';

  String countryCode = '';

  GenderSwitcherState genderSwitcherState = GenderSwitcherState.male;

  PlaceSearchMode searchMode = PlaceSearchMode.country;

  bool get hasValidationError => !maleDataIsValid || !femaleDataIsValid;

  bool maleDataIsValid = false;

  bool femaleDataIsValid = false;

  bool get canShowCountryResults => searchResponse != null && countryController.text.isNotEmpty && !countryIsChosen && !inProgress;

  bool get canShowCityResults => filteredCities.isNotEmpty && cityController.text.isNotEmpty && !cityIsChosen && !inProgress;

  bool get canSearchForCity => genderSwitcherState == GenderSwitcherState.male ? male.country.isNotEmpty : female.country.isNotEmpty;

  bool get selectedPersonExactTimeKnown =>
      genderSwitcherState == GenderSwitcherState.male ? male.exactTimeUnknown : female.exactTimeUnknown;

  void setCountryCode(String code) {
    countryCode = code;
    notifyListeners();
  }

  void setMaleValidationError(String error) {
    maleValidationErrorMessage = error;
    notifyListeners();
  }

  void setFemaleValidationError(String error) {
    femaleValidationErrorMessage = error;
    notifyListeners();
  }

  void setCityLocationResponse(CityGeocodeResponse response) {
    cityLocationResponse = response;
    notifyListeners();
  }

  void setErrorMessage(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void setSearchError(bool value) {
    searchError = value;
    setInProgress(false);
  }

  void setSearchMode(PlaceSearchMode mode) {
    searchMode = mode;
    notifyListeners();
  }

  void setSearchResults(PlaceSearchResponse response) {
    searchResponse = response;
    setInProgress(false);
  }

  void setFilteredCities(CitySearchResponse response) {
    filteredCities = response.predictions ?? [];
    notifyListeners();
  }

  void onSearchRequested({
    required String input,
    required String type,
    required String lang,
    required double offset,
  }) {
    setSearchError(false);
    setInProgress(true);
    scrollController.animateTo(
      offset + 48,
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
    );
    if (type == 'country') {
      setCountry('', lang: lang);
      setSearchMode(PlaceSearchMode.country);
      Future.delayed(
        const Duration(milliseconds: 250),
        () {
          callDebouncer.run(() async {
            final result = await SearchPlaceService.instance.searchPlaceByInput(
              input: input,
              type: type,
              lang: lang,
            );
            result.fold(
              (failure) {
                setSearchError(true);
                setErrorMessage(failure.message);
              },
              (searchResponse) => setSearchResults(searchResponse),
            );
            if (searchResponse!.predictions!.length >= 2) {
              await scrollController.animateTo(
                48.0 * searchResponse!.predictions!.length,
                duration: const Duration(milliseconds: 250),
                curve: Curves.decelerate,
              );
            }
          });
        },
      );
    }
    if (type == 'cities') {
      setSearchMode(PlaceSearchMode.city);
      Future.delayed(
        const Duration(milliseconds: 250),
        () {
          callDebouncer.run(() async {
            final result = await SearchPlaceService.instance.getCityWithinCountry(
              input: input,
              countryCode: 'country:$countryCode',
              lang: lang,
            );
            result.fold(
              (failure) {
                setSearchError(true);
                setErrorMessage(failure.message);
              },
              (searchResponse) => setFilteredCities(searchResponse),
            );
            setInProgress(false);
            if (filteredCities.length >= 2) {
              await scrollController.animateTo(
                48.0 * filteredCities.length,
                duration: const Duration(milliseconds: 250),
                curve: Curves.decelerate,
              );
            }
          });
        },
      );
    }
  }

  void setGenderSwitcherState(GenderSwitcherState value) {
    genderSwitcherState = value;
    if (genderSwitcherState == GenderSwitcherState.male) {
      switchData(male);
    } else {
      switchData(female);
    }
    notifyListeners();
  }

  void switchData(PersonDetails data) {
    nameController.text = data.name;
    countryController.text = data.country;
    cityController.text = data.city.title;
  }

  void saveFemaleData() {
    female = female.copyWith(
      name: nameController.text,
      country: countryController.text,
    );
    notifyListeners();
  }

  void saveMaleData() {
    male = male.copyWith(
      name: nameController.text,
      country: countryController.text,
    );
    notifyListeners();
  }

  void resetData() {
    if (genderSwitcherState == GenderSwitcherState.male) {
      male = male.copyWith(
        dateOfBirth: DateTime.now().subtract(const Duration(days: 365 * 18)),
        name: '',
        country: '',
        city: BirthLocation(),
      );
    }
    if (genderSwitcherState == GenderSwitcherState.female) {
      female = female.copyWith(
        dateOfBirth: DateTime.now().subtract(const Duration(days: 365 * 18)),
        name: '',
        country: '',
        city: BirthLocation(),
      );
    }
    nameController.clear();
    countryController.clear();
    cityController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    cityController.dispose();
    countryController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void updateBirthday(BirthdayData value) {
    if (genderSwitcherState == GenderSwitcherState.male) {
      male = male.copyWith(dateOfBirth: value.date, exactTimeUnknown: value.exactTimeUnknown);
      notifyListeners();
    }
    if (genderSwitcherState == GenderSwitcherState.female) {
      female = female.copyWith(dateOfBirth: value.date, exactTimeUnknown: value.exactTimeUnknown);
      notifyListeners();
    }
  }

  String get selectedPersonBirthday => genderSwitcherState == GenderSwitcherState.male
      ? male.exactTimeUnknown
          ? DateFormat('dd.MM.yyyy').format(male.dateOfBirth)
          : DateFormat('dd.MM.yyyy, HH:mm').format(male.dateOfBirth)
      : female.exactTimeUnknown
          ? DateFormat('dd.MM.yyyy').format(female.dateOfBirth)
          : DateFormat('dd.MM.yyyy, HH:mm').format(female.dateOfBirth);

  DateTime get selectedPersonDateOfBirth => genderSwitcherState == GenderSwitcherState.male ? male.dateOfBirth : female.dateOfBirth;

  bool get countryIsChosen => genderSwitcherState == GenderSwitcherState.male ? male.country.isNotEmpty : female.country.isNotEmpty;
  bool get cityIsChosen => genderSwitcherState == GenderSwitcherState.male ? male.city.title.isNotEmpty : female.city.title.isNotEmpty;

  void setCountry(String country, {String? placeId, required String lang}) async {
    if (genderSwitcherState == GenderSwitcherState.male) {
      male = male.copyWith(country: country);
      if (country.isNotEmpty) countryController.text = male.country;
    }
    if (genderSwitcherState == GenderSwitcherState.female) {
      female = female.copyWith(country: country);
      if (country.isNotEmpty) countryController.text = female.country;
    }
    if (placeId != null) {
      if (placeId.isNotEmpty) {
        setInProgress(true);
        final countryDetails = await SearchPlaceService.instance.getPlaceDetails(
          placeId: placeId,
          lang: lang,
        );
        countryDetails.fold(
          (failure) {
            print(failure.message);
            setSearchError(true);
            setErrorMessage(failure.message);
          },
          (details) => setCountryCode(
            details.result?.addressComponents?.first.shortName ?? '',
          ),
        );
      }
    }
    setInProgress(false);
    searchResponse = null;
    notifyListeners();
  }

  void setCity({
    required String placeId,
    required String cityTitle,
  }) async {
    final city = await SearchPlaceService.instance.getCityLocationById(placeId);
    city.fold(
      (err) {
        setSearchError(true);
        setErrorMessage(err.message);
      },
      (r) => setCityLocationResponse(r),
    );
    final lat = cityLocationResponse!.results!.first.geometry?.location?.lat ?? 0;
    final lon = cityLocationResponse!.results!.first.geometry?.location?.lng ?? 0;
    if (genderSwitcherState == GenderSwitcherState.male) {
      male = male.copyWith(city: BirthLocation(title: cityTitle, lat: lat, lon: lon));
      cityController.text = male.city.title;
      notifyListeners();
    }
    if (genderSwitcherState == GenderSwitcherState.female) {
      female = female.copyWith(city: BirthLocation(title: cityTitle, lat: lat, lon: lon));
      cityController.text = female.city.title;
      notifyListeners();
    }
  }

  void validateMaleData() {
    final maleLocationIsValid = male.city.isValidLocation && male.country.isNotEmpty;
    final maleNameValid = male.name.isNotEmpty;
    final maleBirthdayIsValid = male.dateOfBirth.isBefore(DateTime.now()) && !male.dateOfBirth.isSameDay(DateTime.now());
    maleDataIsValid = maleLocationIsValid && maleNameValid && maleBirthdayIsValid;
    notifyListeners();
    if (!maleLocationIsValid) {
      setMaleValidationError('male_partner_location_invalid'.tr());
    }
    if (!maleNameValid) {
      setMaleValidationError('male_partner_name_invalid'.tr());
    }
    if (!maleBirthdayIsValid) {
      setMaleValidationError('male_partner_birthday_invalid'.tr());
    }
  }

  void validateFemaleData() {
    final femaleLocationIsValid = female.city.isValidLocation && female.country.isNotEmpty;
    final femaleNameValid = female.name.isNotEmpty;
    final femaleBirthdayIsValid = female.dateOfBirth.isBefore(DateTime.now()) && !female.dateOfBirth.isSameDay(DateTime.now());
    femaleDataIsValid = femaleLocationIsValid && femaleNameValid && femaleBirthdayIsValid;
    notifyListeners();
    if (!femaleLocationIsValid) {
      setFemaleValidationError('female_partner_location_invalid'.tr());
      print('female_partner_location_invalid');
    }
    if (!femaleNameValid) {
      setFemaleValidationError('female_partner_name_invalid'.tr());
      print('female_partner_name_invalid');
    }
    if (!femaleBirthdayIsValid) {
      setFemaleValidationError('female_partner_birthday_invalid'.tr());
      print('female_partner_birthday_invalid');
    }
  }

  void changePartnerName(String value) {
    if (genderSwitcherState == GenderSwitcherState.male) {
      male = male.copyWith(name: value);
      notifyListeners();
    }
    if (genderSwitcherState == GenderSwitcherState.female) {
      female = female.copyWith(name: value);
      notifyListeners();
    }
  }
}
