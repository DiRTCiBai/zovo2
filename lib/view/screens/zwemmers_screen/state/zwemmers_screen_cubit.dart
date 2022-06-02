import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/database_models/database_models.dart';

part 'zwemmers_screen_state.dart';

class ZwemmersScreenCubit extends Cubit<ZwemmersScreenState> {
  ZwemmersScreenCubit() : super(ZwemmersScreenInitial());

  void initCubit() {
    emit(ZwemmersScreenDisplay(zwemmers: []));
  }
}
