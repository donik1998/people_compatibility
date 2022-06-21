import 'package:people_compatibility/core/models/comparison.dart';
import 'package:people_compatibility/data/database_repository.dart';
import 'package:people_compatibility/presentation/provider/base_notifier.dart';

class MainPageState extends BaseNotifier {
  MainPageState() {
    DatabaseService.instance.getComparisons().then((value) {
      history = value;
      notifyListeners();
    });
  }

  List<CompatibilityData>? history;

  bool fullSizedMode = false;

  void setFullSized(bool value) {
    fullSizedMode = value;
    notifyListeners();
  }
}
