import 'package:flutter/cupertino.dart';
import 'package:people_compatibility/core/models/compatibility_response.dart';
import 'package:people_compatibility/data/database_repository.dart';
import 'package:people_compatibility/presentation/provider/base_notifier.dart';

class CalculateCompatibilityPageState extends BaseNotifier {
  CompatibilityResponse? calculationResponse;

  bool hasError = false;

  int? selectedIndex;

  final List<String> compatibilityLevelTitles = [
    'Единство взглядов',
    'Совместный комфорт',
    'Взаимопонимание',
    'Забота друг о друге',
    'Эротизм, сексуальная совместимость',
    'Готовность к совместной деятельности, сотрудничество',
    'Общность интересов и увлечений',
    'Острота чувств',
    'Уровень открытости отношений',
    'Практичность',
    'Свобода и доверие в отношениях',
    'Романтичность в отношениях',
  ];

  final List<String> compatibilityDescriptions = [
    'Идеологическая и мировоззренческая совместимость',
    'Уровень психологического комфорта, не основанный на чувственности. Заинтересованность в перспективных отношениях',
    'Доверие и гармония в отношениях. Настрой «на одну волну» без сознательных усилий',
    'Деятельно-заинтересованное отношение друг к другу, вызванное осознанием значимости этой связи',
    'Чувственный резонанс. Сила и яркость чувственных переживаний. Желание отдавать себя партеру и владеть им',
    'Осознание общих целей. Успешная совместная деятельность ради общего блага. Взаимная помощь и поддержка',
    'Наличие общих взглядов на самореализацию и способы ее достижения. Необходимость ощущать наполненность жизни, расширяя сферы своей деятельности',
    'Способность партнера питать ваши чувства, быть постоянно привлекательным',
    'Способность принимать партнера таким, какой он есть. Взаимная искренность, уважение',
    'Способность находить компромиссы. Готовность соответствовать потребностям партнера',
    'Готовность принимать свободу партнера, не диктовать своих условий. Убежденность в искренности и добросовестности партнера',
    'Возвышенно-эмоциональное отношение к партнеру, подчеркивающие альтруизм и другие нематериальные ценности. Умение уходить от будничных шаблонов в отношениях',
  ];

  ScrollController scrollController = ScrollController();

  void setCalculationResponse({required CompatibilityResponse response, required String maleName, required String femaleName}) {
    calculationResponse = response;
    DatabaseService.instance.saveData(
      maleName: maleName,
      femaleName: femaleName,
      date: DateTime.now(),
      response: response,
    );
    notifyListeners();
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
