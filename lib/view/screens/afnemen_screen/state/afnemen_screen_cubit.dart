import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/ui_models/ui_models.dart';
import '../../../../test_data/zwemmer_test_data.dart';

part 'afnemen_screen_state.dart';

class AfnemenScreenCubit extends Cubit<AfnemenScreenState> {
  AfnemenScreenCubit() : super(AfnemenScreenInitial());

  bool _mode = false;

  void initCubit(String mode) {
    if (mode == "afnemen") {
      _mode = true;
      emit(AfnemenScreenDisplay(
        zwemmerLijst: _map(),
        mode: true,
      ));

      return;
    }

    emit(AfnemenScreenDisplay(
      zwemmerLijst: _map(),
      mode: false,
    ));
    _mode = false;
  }

  void toggle(String zwemmerId) {
    emit(AfnemenScreenLoading());

    final res = zwemmerTestData.firstWhere((element) => element.id == zwemmerId);
    res.isAanwezig = !res.isAanwezig;

    emit(AfnemenScreenDisplay(
      zwemmerLijst: _map(),
      mode: _mode,
    ));
  }

  List<Afnemen> _map() {
    final res = zwemmerTestData;
    return res
        .map(
          (e) => Afnemen(
            naam: e.naam,
            zwemmerId: e.id,
            isSelected: e.isAanwezig,
          ),
        )
        .toList();
  }
}
