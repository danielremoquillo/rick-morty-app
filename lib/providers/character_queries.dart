import 'package:flutter/foundation.dart';

class CharacterQueryProvider with ChangeNotifier {
  Map<String, String> _mapQuery = {'Status': '', 'Species': '', 'Gender': ''};
  Map<String, String> _tempQuery = {'Status': '', 'Species': '', 'Gender': ''};

  void stageQuery(String query, String category) {
    _tempQuery[category] = query;
    notifyListeners();
  }

  void pushQuery() {
    _mapQuery = _tempQuery;
    notifyListeners();
  }

  void resetQuery() {
    _tempQuery = {'Status': '', 'Species': '', 'Gender': ''};
    notifyListeners();
  }

  Map<String, String> get getMapQuery => _mapQuery;
  Map<String, String> get getTempQuery => _tempQuery;
}
