part of 'zwemmers_screen_cubit.dart';

abstract class ZwemmersScreenState extends Equatable {
  const ZwemmersScreenState();
}

class ZwemmersScreenInitial extends ZwemmersScreenState {
  @override
  List<Object> get props => [];
}

class ZwemmersScreenLoading extends ZwemmersScreenState {
  @override
  List<Object> get props => [];
}

class ZwemmersScreenDisplay extends ZwemmersScreenState {
  final List<Zwemmer> zwemmers;

  ZwemmersScreenDisplay({
    required this.zwemmers,
  });

  @override
  List<Object> get props => [];
}
