import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:zovo2/controllers/database/csv_data.dart';
import 'package:zovo2/models/database_models/database_models.dart';
import 'package:zovo2/test_data/zwemmer_test_data.dart';

import '../models/ui_models/ui_models.dart';
import '../services/database/zwemmer_database/zwemmer.dart';
import '../test_data/niveau_test_data.dart';

class ZwemmerLijst extends ChangeNotifier {
  List<Zwemmer> _zwemmers = [];
  final List<Niveau> _niveaus = niveauTestData;
  final List<String> _groepen = ["Kik", "KZ", "GZ", "DOL", "Wal", "Ork"];
  String _currentGroep = "GZ";
  bool _mode = false;
  Box? box;
  bool get mode => _mode;

  // werk

  ///***************************************************************************
  /// INIT PROVIDER
  ///***************************************************************************
  void init() async {
    box = await Hive.openBox<ZwemmerData>('zwemmers');
    final res = box!.values;
    res.forEach((element) {
      print(element.naam);
    });
    _zwemmers = zwemmerTestData;
    /*  _zwemmers = [
      ...res
          .map(
            (e) => Zwemmer(
              isSelected: e.isSelected,
              naam: e.naam,
              opmerking: e.opmerking,
              id: e.id,
              groep: e.groep,
              isAanwezig: e.isAanwezig,
              niveauId: e.niveauId,
              statusOef1: e.statusOef1,
              statusOef2: e.statusOef2,
            ),
          )
          .toList()
    ];*/
  }

  ///***************************************************************************
  /// AFNEMEN SCREEN
  ///***************************************************************************
  void toggle(String zwemmerId) {
    if (_mode) {
      final res = _zwemmers.firstWhere((element) => element.id == zwemmerId);
      res.isAanwezig = !res.isAanwezig;
      notifyListeners();
    }

    if (!_mode) {
      final res = _zwemmers.firstWhere((element) => element.id == zwemmerId);
      res.isSelected = !res.isSelected;
      notifyListeners();
    }
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
      final res =
          _zwemmers.where((element) => element.groep == _currentGroep).toList();
      return res
          .map(
            (e) => Afnemen(
              niveau: _niveaus
                  .firstWhere((element) => element.id == e.niveauId)
                  .niveau,
              naam: e.naam,
              zwemmerId: e.id,
              isSelected: e.isAanwezig,
            ),
          )
          .toList();
    }

    final res = _zwemmers
        .where((element) =>
            element.isAanwezig == true && element.groep == _currentGroep)
        .toList();

    return res
        .map(
          (e) => Afnemen(
            niveau: _niveaus
                .firstWhere((element) => element.id == e.niveauId)
                .niveau,
            naam: e.naam,
            zwemmerId: e.id,
            isSelected: e.isSelected,
          ),
        )
        .toList();
  }

  List<Zwemmer> getSearchResults(String query) {
    return _zwemmers
        .where((element) =>
            element.naam.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void setAfnemenMode(bool set) {
    _mode = set;
    notifyListeners();
  }

  ///***************************************************************************
  /// TEST SCREEN
  ///***************************************************************************
  final List<ZwemmerTest> _oef1 = [];
  final List<ZwemmerTest> _oef2 = [];

  List<ZwemmerTest> oefening1() {
    zwemmerLijstOef();
    return _oef1;
  }

  List<ZwemmerTest> oefening2() {
    zwemmerLijstOef();
    return _oef2;
  }

  void zwemmerLijstOef() {
    final zwemmers = selectedTestZwemmers;

    clearOefeningenLijst();

    for (var zwemmer in zwemmers) {
      addZwemmerOefToLijst(zwemmer);
    }
  }

  void addZwemmerOefToLijst(Zwemmer zwemmer) {
    final niveau =
        _niveaus.firstWhere((element) => element.id == zwemmer.niveauId);

    _oef1.add(_convertToZwemmerTest(
      zwemmer,
      niveau.oef1,
      zwemmer.statusOef1,
    ));

    _oef2.add(_convertToZwemmerTest(
      zwemmer,
      niveau.oef2,
      zwemmer.statusOef2,
    ));
  }

  void clearOefeningenLijst() {
    _oef1.clear();
    _oef2.clear();
  }

  ZwemmerTest _convertToZwemmerTest(Zwemmer data, String oef, bool statusOef) {
    return ZwemmerTest(
      zwemmerId: data.id,
      naam: data.naam,
      niveauId: data.niveauId,
      statusOef: statusOef,
      oef: oef,
    );
  }

  List<Zwemmer> get selectedTestZwemmers {
    return _zwemmers
        .where((element) =>
            element.isAanwezig == true &&
            element.isSelected == true &&
            element.groep == _currentGroep)
        .toList();
  }

  /// toggle of zwemmer oef kan of niet
  void toggleTest(String zwemmerId, int oefIndex) {
    final zwemmer = _zwemmers.firstWhere((element) => element.id == zwemmerId);

    if (oefIndex == 1) {
      zwemmer.statusOef1 = !zwemmer.statusOef1;
    }

    if (oefIndex == 2) {
      zwemmer.statusOef2 = !zwemmer.statusOef2;
    }

    zwemmerLijstOef();
    notifyListeners();
  }

  ///***************************************************************************
  /// IMPORT EXPORT SCREEN
  ///***************************************************************************
  void importZwemmerData() async {
    final res = await CSVData().impotZwemmerData();

    var box = await Hive.openBox<ZwemmerData>('zwemmers');
    box.clear();

    for (var value in res) {
      box.put(
        value[0].toString(),
        ZwemmerData(
          id: value[0].toString(),
          opmerking: value[6].toString(),
          naam: value[1].toString(),
          groep: value[2].toString(),
          isAanwezig: false,
          isSelected: false,
          niveauId: value[3].toString(),
          statusOef1: value[4].toString().toLowerCase() == 'true',
          statusOef2: value[5].toString().toLowerCase() == 'true',
        ),
      );
    }

    _zwemmers = [
      ...box.values
          .map(
            (e) => Zwemmer(
              id: e.id,
              opmerking: e.opmerking,
              naam: e.naam,
              groep: e.groep,
              isAanwezig: false,
              isSelected: false,
              niveauId: e.niveauId,
              statusOef1: e.statusOef1,
              statusOef2: e.statusOef2,
            ),
          )
          .toList()
    ];

    box.close();
    notifyListeners();
  }

  void exportZwemmerData() async {
    List<List<dynamic>> ddd = [];
    _zwemmers.forEach((element) {
      ddd.add([
        element.id,
        element.naam,
        element.niveauId,
        element.statusOef1,
        element.statusOef2,
        element.opmerking
      ]);
    });
    await CSVData().exportZwemmerData(ddd);
  }

  ///***************************************************************************
  /// ZWEMMER SCREEN
  ///***************************************************************************
  List<String> filters = ["Over", "all", "niv"];
  String _currentFilter = "all";

  void setFilter(String newFilter) {
    for (int i = 0; i < filters.length; i++) {
      if (filters[i] == newFilter) {
        _currentFilter = filters[i];
        notifyListeners();
        return;
      }
    }
  }

  List<Zwemmer> get filterZwemmerLijst {
    if (_currentFilter == filters[0]) {
      return zwemmers
          .where((element) =>
              element.statusOef2 == true && element.statusOef1 == true)
          .toList();
    }

    if (_currentFilter == filters[2]) {
      return zwemmers;
    }

    return zwemmers;
  }

  ///***************************************************************************
  /// ZWEMMER INFO SCREEN
  ///***************************************************************************

  String zwemmerCurrentGroep(String zwemmerId) {
    return _zwemmers.firstWhere((element) => element.id == zwemmerId).groep;
  }

  List<Niveau> zwemmerNiveaus(String zwemmerId) {
    final groep =
        zwemmers.firstWhere((element) => element.id == zwemmerId).groep;
    return _niveaus.where((element) => element.groep == groep).toList();
  }

  Zwemmer zwemmerById(String zwemmerId) {
    return _zwemmers.firstWhere((element) => element.id == zwemmerId);
  }
}

///***************************************************************************
/// PROVIDER INSTANCE
///***************************************************************************
final zwemmerLijstProvider = ChangeNotifierProvider<ZwemmerLijst>((ref) {
  return ZwemmerLijst();
});
