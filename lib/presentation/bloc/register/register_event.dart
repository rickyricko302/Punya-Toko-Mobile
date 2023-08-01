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

class RegisterAccountEvent extends RegisterEvent {
  final RegisterModel model;
  final LoaderButtonCubit loaderButtonCubit;
  const RegisterAccountEvent(
      {required this.model, required this.loaderButtonCubit});
  @override
  List<Object> get props => [model, loaderButtonCubit];
}
