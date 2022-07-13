import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class SecondPartnerDataState extends BaseNotifier {
  final PersonDetails firstPartnerData;
  final PersonDetails? oldData;
  final ScrollController scrollController = ScrollController();
  late final TextEditingController nameController = TextEditingController(text: partnerData.name);
  late final TextEditingController countryController = TextEditingController(text: partnerData.country);
  late final TextEditingController cityController = TextEditingController(text: partnerData.city.title);
  Completer completer = Completer();
  PlaceSearchResponse? searchResponse;
  List<SearchPrediction> filteredCities = List.empty(growable: true);
  bool searchError = false;
  CityGeocodeResponse? cityLocationResponse;
  final Debouncer callDebouncer = Debouncer(milliseconds: 250);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  PersonDetails partnerData = PersonDetails(
    exactTimeUnknown: false,
    gender: 'M',
    dateOfBirth: DateTime.now(),
    name: '',
    country: '',
    city: BirthLocation(),
  );

  String partnerValidationErrorMessage = '';

  String countryCode = '';

  late GenderSwitcherState genderSwitcherState;

  PlaceSearchMode searchMode = PlaceSearchMode.country;

  bool partnerDataIsValid = false;

  SecondPartnerDataState({required this.firstPartnerData, this.oldData}) {
    genderSwitcherState = firstPartnerData.gender == 'M' ? GenderSwitcherState.female : GenderSwitcherState.male;
    if (oldData != null) {
      partnerData = oldData!;
      countryController.text = partnerData.country;
      cityController.text = partnerData.city.title;
      updateBirthday(
        BirthdayData(
          date: partnerData.dateOfBirth,
          exactTimeUnknown: partnerData.exactTimeUnknown,
        ),
      );
      notifyListeners();
    }
  }

  void setCountryCode(String code) {
    countryCode = code;
    notifyListeners();
  }

  void setPartnerDataValidationError(String error) {
    partnerValidationErrorMessage = error;
    notifyListeners();
  }

  void setCityLocationResponse(CityGeocodeResponse response) {
    cityLocationResponse = response;
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
    if (value == GenderSwitcherState.male) {
      partnerData = partnerData.copyWith(gender: 'M');
    } else {
      partnerData = partnerData.copyWith(gender: 'F');
    }
    notifyListeners();
  }

  void resetData() {
    partnerData = partnerData.copyWith(
      dateOfBirth: DateTime.now().subtract(const Duration(days: 365 * 18)),
      name: '',
      country: '',
      city: BirthLocation(),
      gender: 'M',
    );
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
    partnerData = partnerData.copyWith(dateOfBirth: value.date, exactTimeUnknown: value.exactTimeUnknown);
    notifyListeners();
  }

  void setCountry(String country, {String? placeId, required String lang}) async {
    partnerData = partnerData.copyWith(country: country);
    if (country.isNotEmpty) countryController.text = partnerData.country;
    if (placeId != null) {
      if (placeId.isNotEmpty) {
        setInProgress(true);
        final countryDetails = await SearchPlaceService.instance.getPlaceDetails(
          placeId: placeId,
          lang: lang,
        );
        countryDetails.fold(
          (failure) {
            setSearchError(true);
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
      },
      (r) => setCityLocationResponse(r),
    );
    final lat = cityLocationResponse!.results!.first.geometry?.location?.lat ?? 0;
    final lon = cityLocationResponse!.results!.first.geometry?.location?.lng ?? 0;
    partnerData = partnerData.copyWith(city: BirthLocation(title: cityTitle, lat: lat, lon: lon));
    cityController.text = partnerData.city.title;
    notifyListeners();
  }

  void validatePartnerData() {
    final maleLocationIsValid = partnerData.city.isValidLocation && partnerData.country.isNotEmpty;
    final maleNameValid = partnerData.name.isNotEmpty;
    final maleBirthdayIsValid = partnerData.dateOfBirth.isBefore(DateTime.now()) && !partnerData.dateOfBirth.isSameDay(DateTime.now());
    partnerDataIsValid = maleLocationIsValid && maleNameValid && maleBirthdayIsValid;
    notifyListeners();
    if (!maleLocationIsValid) {
      setPartnerDataValidationError('partner_location_invalid'.tr());
    }
    if (!maleNameValid) {
      setPartnerDataValidationError('partner_name_invalid'.tr());
    }
    if (!maleBirthdayIsValid) {
      setPartnerDataValidationError('partner_birthday_invalid'.tr());
    }
  }

  void changePartnerName(String value) {
    partnerData = partnerData.copyWith(name: value);
    notifyListeners();
  }

  String get selectedPersonBirthday => partnerData.exactTimeUnknown
      ? DateFormat('dd.MM.yyyy').format(partnerData.dateOfBirth)
      : DateFormat('dd.MM.yyyy, HH:mm').format(partnerData.dateOfBirth);

  bool get countryIsChosen => partnerData.country.isNotEmpty;

  bool get cityIsChosen => partnerData.city.title.isNotEmpty;

  bool get canShowCountryResults => searchResponse != null && countryController.text.isNotEmpty && !countryIsChosen && !inProgress;

  bool get canShowCityResults => filteredCities.isNotEmpty && cityController.text.isNotEmpty && !cityIsChosen && !inProgress;

  bool get canSearchForCity => partnerData.country.isNotEmpty;
}
