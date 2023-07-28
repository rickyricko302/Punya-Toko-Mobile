part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterChangeGenderEvent extends RegisterEvent {
  final String gender;
  const RegisterChangeGenderEvent({required this.gender});

  @override
  List<Object> get props => [gender];
}
