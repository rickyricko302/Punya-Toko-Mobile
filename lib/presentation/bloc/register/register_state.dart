part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState({required this.gender});
  final String gender;
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial({required super.gender});

  @override
  List<Object> get props => [gender];
}
