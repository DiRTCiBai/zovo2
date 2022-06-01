part of 'test_screen_cubit.dart';

abstract class TestScreenState extends Equatable {
  const TestScreenState();
}

class TestScreenInitial extends TestScreenState {
  @override
  List<Object> get props => [];
}

class TestScreenLoading extends TestScreenState {
  @override
  List<Object> get props => [];
}

class TestScreenDisplay extends TestScreenState {
  final List<ZwemmerTest> zwemmerLijstOef1;
  final List<ZwemmerTest> zwemmerLijstOef2;

  TestScreenDisplay({
    required this.zwemmerLijstOef1,
    required this.zwemmerLijstOef2,
  });

  @override
  List<Object> get props => [];
}
