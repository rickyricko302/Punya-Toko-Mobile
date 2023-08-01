part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  final String gender;
  const RegisterState({required this.gender});

  @override
  List<Object> get props => [gender];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial({
    required super.gender,
  });

  @override
  List<Object> get props => [gender];
}

class RegisterLoading extends RegisterState {
  const RegisterLoading({required super.gender});
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess({required super.gender});
}

class RegisterFailed extends RegisterState {
  final String msgError;

  const RegisterFailed({
    required super.gender,
    required this.msgError,
  });
}
