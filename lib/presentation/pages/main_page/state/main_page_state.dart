import 'dart:convert';

import 'package:people_compatibility/core/models/comparison.dart';
import 'package:people_compatibility/presentation/provider/base_notifier.dart';
import 'package:people_compatibility/presentation/utils/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPageState extends BaseNotifier {
  MainPageState() {
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
      notifyListeners();
    });
  }

  SharedPreferences? sharedPreferences;

  bool fullSizedMode = false;

  bool get historyIsNotEmpty =>
      sharedPreferences != null &&
      (sharedPreferences?.containsKey(SharedPreferencesKeys.history) ?? false) &&
      (sharedPreferences?.getString(SharedPreferencesKeys.history)?.isNotEmpty ?? false);

  List<Comparison> get history =>
      jsonDecode(sharedPreferences!.getString(SharedPreferencesKeys.history)!).map<Comparison>((e) => Comparison.fromJson(e)).toList();

  void setFullSized(bool value) {
    fullSizedMode = value;
    notifyListeners();
  }
}
