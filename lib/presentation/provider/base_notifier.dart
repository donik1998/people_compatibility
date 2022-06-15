import 'package:flutter/cupertino.dart';

abstract class BaseNotifier extends ChangeNotifier {
  bool inProgress = false;

  void setInProgress(bool value) {
    inProgress = value;
    notifyListeners();
  }
}
