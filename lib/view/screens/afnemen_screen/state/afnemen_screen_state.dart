part of 'afnemen_screen_cubit.dart';

abstract class AfnemenScreenState extends Equatable {
  const AfnemenScreenState();
}

class AfnemenScreenInitial extends AfnemenScreenState {
  @override
  List<Object> get props => [];
}

class AfnemenScreenLoading extends AfnemenScreenState {
  @override
  List<Object> get props => [];
}

class AfnemenScreenDisplay extends AfnemenScreenState {
  final List<Afnemen> zwemmerLijst;
  final bool mode;
  final List<String> groepen;

  AfnemenScreenDisplay({
    required this.zwemmerLijst,
    required this.mode,
    required this.groepen,
  });

  @override
  List<Object> get props => [];
}
