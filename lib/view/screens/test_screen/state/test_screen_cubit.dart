import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/ui_models/ui_models.dart';
import '../../../../test_data/niveau_test_data.dart';
import '../../../../test_data/zwemmer_test_data.dart';

part 'test_screen_state.dart';

class TestScreenCubit extends Cubit<TestScreenState> {
  TestScreenCubit() : super(TestScreenInitial());

  void initCubit() {
    zwemmerLijstOef();
    emit(TestScreenDisplay(
      zwemmerLijstOef1: _oef1,
      zwemmerLijstOef2: _oef2,
    ));
  }

  List<ZwemmerTest> _oef1 = [];
  List<ZwemmerTest> _oef2 = [];

  void zwemmerLijstOef() {
    final res =
        zwemmerTestData.where((element) => element.isAanwezig == true && element.isSelected == true).toList();
    final resN = niveauTestData;

    _oef1.clear();
    _oef2.clear();

    for (var value in res) {
      final niveau = resN.firstWhere((element) => element.id == value.niveauId);

      _oef1.add(
        ZwemmerTest(
          zwemmerId: value.id,
          naam: value.naam,
          niveauId: value.niveauId,
          statusOef: value.statusOef1,
          oef: niveau.oef1,
        ),
      );

      _oef2.add(
        ZwemmerTest(
          zwemmerId: value.id,
          naam: value.naam,
          niveauId: value.niveauId,
          statusOef: value.statusOef2,
          oef: niveau.oef2,
        ),
      );
    }
  }

  void toggle(String zwemmerId, int oefIndex) {
    emit(TestScreenLoading());

    final res = zwemmerTestData.firstWhere((element) => element.id == zwemmerId);

    if (oefIndex == 1) {
      res.statusOef1 = !res.statusOef1;
    }

    if (oefIndex == 2) {
      res.statusOef2 = !res.statusOef2;
    }

    zwemmerLijstOef();
    emit(TestScreenDisplay(
      zwemmerLijstOef1: _oef1,
      zwemmerLijstOef2: _oef2,
    ));
  }
}
