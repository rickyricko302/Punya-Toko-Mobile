part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {
  final String msgError;
  const LoginFailed({required this.msgError});

  @override
  List<Object> get props => [msgError];
}
