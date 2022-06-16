import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:people_compatibility/core/models/birthday_data.dart';
import 'package:people_compatibility/core/models/city_geocode_response.dart';
import 'package:people_compatibility/core/models/city_search_response.dart';
import 'package:people_compatibility/core/models/person_details.dart';
import 'package:people_compatibility/domain/remote/search_place_repository.dart';
import 'package:people_compatibility/presentation/provider/base_notifier.dart';
import 'package:people_compatibility/presentation/utils/async_debouncer.dart';
import 'package:people_compatibility/presentation/utils/enums.dart';

class ComparisonDataPageState extends BaseNotifier {
  late final TextEditingController nameController = TextEditingController(text: male.name);
  late final TextEditingController countryController = TextEditingController(text: male.country);
  late final TextEditingController cityController = TextEditingController(text: male.city.title);
  Completer completer = Completer();
  CitySearchResponse? searchResponse;
  bool searchError = false;
  CityGeocodeResponse? cityLocationResponse;
  final Debouncer callDebouncer = Debouncer(milliseconds: 250);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String errorMessage = '';

  PersonDetails male = PersonDetails(
    exactTimeKnown: false,
    dateOfBirth: DateTime.now().subtract(const Duration(days: 365 * 18)),
    name: '',
    country: '',
    city: BirthLocation(title: '', lat: 0, lon: 0),
  );

  PersonDetails female = PersonDetails(
    exactTimeKnown: false,
    dateOfBirth: DateTime.now().subtract(const Duration(days: 365 * 18)),
    name: '',
    country: '',
    city: BirthLocation(title: '', lat: 0, lon: 0),
  );

  GenderSwitcherState genderSwitcherState = GenderSwitcherState.male;

  PlaceSearchMode searchMode = PlaceSearchMode.country;

  bool get canShowCountryResults => searchResponse != null && countryController.text.isNotEmpty && !countryIsChosen && !inProgress;

  bool get canShowCityResults => searchResponse != null && cityController.text.isNotEmpty && !cityIsChosen && !inProgress;

  bool get canSearchForCity => genderSwitcherState == GenderSwitcherState.male ? male.country.isNotEmpty : female.country.isNotEmpty;

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

  void setSearchResults(CitySearchResponse response) {
    searchResponse = response;
    setInProgress(false);
  }

  void onSearchRequested(String input, String type) {
    setSearchError(false);
    setInProgress(true);
    if (type == 'country') {
      setCountry('');
      setSearchMode(PlaceSearchMode.country);
    }
    if (type == 'cities') {
      setSearchMode(PlaceSearchMode.city);
    }
    Future.delayed(
      const Duration(milliseconds: 250),
      () {
        callDebouncer.run(() async {
          final result = await SearchPlaceService.instance.searchPlaceByInput(
            input: input,
            type: type,
          );
          result.fold(
            (failure) {
              setSearchError(true);
              setErrorMessage(failure.message);
            },
            (searchResponse) => setSearchResults(searchResponse),
          );
        });
      },
    );
  }

  void setGenderSwitcherState(GenderSwitcherState value) {
    genderSwitcherState = value;
    if (genderSwitcherState == GenderSwitcherState.male) {
      female = female.copyWith(
        name: nameController.text,
        country: countryController.text,
      );
      nameController.text = male.name;
      countryController.text = male.country;
      cityController.text = male.city.title;
      notifyListeners();
    }
    if (genderSwitcherState == GenderSwitcherState.female) {
      male = male.copyWith(
        name: nameController.text,
        country: countryController.text,
      );
      nameController.text = female.name;
      countryController.text = female.country;
      cityController.text = female.city.title;
      notifyListeners();
    }
  }

  void resetData() {
    if (genderSwitcherState == GenderSwitcherState.male) {
      male = male.copyWith(
        dateOfBirth: DateTime.now().subtract(const Duration(days: 365 * 18)),
        name: '',
        country: '',
        city: BirthLocation(title: '', lat: 0, lon: 0),
      );
    }
    if (genderSwitcherState == GenderSwitcherState.female) {
      female = female.copyWith(
        dateOfBirth: DateTime.now().subtract(const Duration(days: 365 * 18)),
        name: '',
        country: '',
        city: BirthLocation(title: '', lat: 0, lon: 0),
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
    super.dispose();
  }

  void updateBirthday(BirthdayData value) {
    if (genderSwitcherState == GenderSwitcherState.male) {
      male = male.copyWith(dateOfBirth: value.date, exactTimeKnown: value.exactTimeKnown);
      notifyListeners();
    }
    if (genderSwitcherState == GenderSwitcherState.female) {
      female = female.copyWith(dateOfBirth: value.date, exactTimeKnown: value.exactTimeKnown);
      notifyListeners();
    }
  }

  String get selectedPersonBirthday => genderSwitcherState == GenderSwitcherState.male
      ? DateFormat('dd.MM.yyyy').format(male.dateOfBirth)
      : DateFormat('dd.MM.yyyy').format(female.dateOfBirth);

  bool get countryIsChosen => genderSwitcherState == GenderSwitcherState.male ? male.country.isNotEmpty : female.country.isNotEmpty;
  bool get cityIsChosen => genderSwitcherState == GenderSwitcherState.male ? male.city.title.isNotEmpty : female.city.title.isNotEmpty;

  void setCountry(String country) {
    if (genderSwitcherState == GenderSwitcherState.male) {
      male = male.copyWith(country: country);
      if (country.isNotEmpty) countryController.text = male.country;
    }
    if (genderSwitcherState == GenderSwitcherState.female) {
      female = female.copyWith(country: country);
      if (country.isNotEmpty) countryController.text = female.country;
    }
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
}
