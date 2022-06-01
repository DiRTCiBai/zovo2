import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zovo2/services/database/groepen.dart';
import 'package:zovo2/test_data/niveau_test_data.dart';

import '../../../../models/ui_models/ui_models.dart';
import '../../../../test_data/zwemmer_test_data.dart';

part 'afnemen_screen_state.dart';

class AfnemenScreenCubit extends Cubit<AfnemenScreenState> {
  AfnemenScreenCubit() : super(AfnemenScreenInitial());

  bool _mode = false;
  final List<String> _groepen = groepen;
  String _currentGroep = "GZ";

  void initCubit(String mode) {
    if (mode == "afnemen") {
      _mode = true;
      emit(AfnemenScreenDisplay(
        zwemmerLijst: _map(),
        groepen: _groepen,
        mode: true,
      ));

      return;
    }

    emit(AfnemenScreenDisplay(
      zwemmerLijst: _map(),
      groepen: _groepen,
      mode: false,
    ));
    _mode = false;
  }

  void toggle(String zwemmerId) {
    emit(AfnemenScreenLoading());

    if (_mode) {
      final res = zwemmerTestData.firstWhere((element) => element.id == zwemmerId);
      res.isAanwezig = !res.isAanwezig;
    }

    if (!_mode) {
      final res = zwemmerTestData.firstWhere((element) => element.id == zwemmerId);
      res.isSelected = !res.isSelected;
    }

    emit(AfnemenScreenDisplay(
      zwemmerLijst: _map(),
      groepen: _groepen,
      mode: _mode,
    ));
  }

  List<Afnemen> _map() {
    final resN = niveauTestData;

    if (_mode) {
      final res = zwemmerTestData.where((element) => element.groep == _currentGroep).toList();
      return res
          .map(
            (e) => Afnemen(
              niveau: resN.firstWhere((element) => element.id == e.niveauId).niveau,
              naam: e.naam,
              zwemmerId: e.id,
              isSelected: e.isAanwezig,
            ),
          )
          .toList();
    }

    final res = zwemmerTestData
        .where((element) => element.isAanwezig == true && element.groep == _currentGroep)
        .toList();
    return res
        .map(
          (e) => Afnemen(
            niveau: resN.firstWhere((element) => element.id == e.niveauId).niveau,
            naam: e.naam,
            zwemmerId: e.id,
            isSelected: e.isSelected,
          ),
        )
        .toList();
  }

  void changeGroep(String groep) {
    emit(AfnemenScreenLoading());
    _currentGroep = groep;

    emit(AfnemenScreenDisplay(
      zwemmerLijst: _map(),
      groepen: _groepen,
      mode: _mode,
    ));
  }
}
