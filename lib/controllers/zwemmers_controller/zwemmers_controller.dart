import 'package:zovo2/models/database_models/zwemmer.dart';

import '../../test_data/zwemmer_test_data.dart';

class ZwemmersController {
  final _zwemmers = zwemmerTestData;

  List<Zwemmer> getSearchResults(String query) {
    return _zwemmers.where((element) => element.naam.toLowerCase().contains(query.toLowerCase())).toList();
  }

  void toggleAanwezighden(zwemmerId) {
    final res = zwemmerTestData.firstWhere((element) => element.id == zwemmerId);
    res.isAanwezig = !res.isAanwezig;
  }
}
