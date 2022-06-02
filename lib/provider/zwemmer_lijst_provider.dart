import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zovo2/models/database_models/database_models.dart';

import '../models/ui_models/afnemen.dart';
import '../test_data/niveau_test_data.dart';
import '../test_data/zwemmer_test_data.dart';

class ZwemmerLijst extends ChangeNotifier {
  final List<Zwemmer> _zwemmers = zwemmerTestData;
  final List<Niveau> _niveaus = niveauTestData;
  final List<String> _groepen = ["Kik", "KZ", "GZ", "Dol", "Wal", "Ork"];
  String _currentGroep = "GZ";
  bool _mode = false;

  bool get mode => _mode;

  void toggle(String zwemmerId) {
    if (_mode) {
      final res = zwemmerTestData.firstWhere((element) => element.id == zwemmerId);
      res.isAanwezig = !res.isAanwezig;
      notifyListeners();
    }

    if (!_mode) {
      final res = zwemmerTestData.firstWhere((element) => element.id == zwemmerId);
      res.isSelected = !res.isSelected;
      notifyListeners();
    }

    print("sdfsdf");
  }

  List<Zwemmer> get zwemmers => _zwemmers;
  List<String> get groepen => _groepen;
  String get currentGroep => _currentGroep;

  void changeGroep(String groep) {
    _currentGroep = groep;
    notifyListeners();
  }

  List<Afnemen> get afnemenZwemmers {
    if (_mode) {
      final res = _zwemmers.where((element) => element.groep == _currentGroep).toList();
      return res
          .map(
            (e) => Afnemen(
              niveau: _niveaus.firstWhere((element) => element.id == e.niveauId).niveau,
              naam: e.naam,
              zwemmerId: e.id,
              isSelected: e.isAanwezig,
            ),
          )
          .toList();
    }

    final res =
        _zwemmers.where((element) => element.isAanwezig == true && element.groep == _currentGroep).toList();
    return res
        .map(
          (e) => Afnemen(
            niveau: _niveaus.firstWhere((element) => element.id == e.niveauId).niveau,
            naam: e.naam,
            zwemmerId: e.id,
            isSelected: e.isSelected,
          ),
        )
        .toList();
  }

  List<Zwemmer> getSearchResults(String query) {
    return _zwemmers.where((element) => element.naam.toLowerCase().contains(query.toLowerCase())).toList();
  }

  void setMode(bool set) {
    _mode = set;
    notifyListeners();
  }
}

final zwemmerLijstProvider = ChangeNotifierProvider<ZwemmerLijst>((ref) {
  return ZwemmerLijst();
});
