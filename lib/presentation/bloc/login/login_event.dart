part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  final LoginModel model;
  const LoginEvent({required this.model});

  @override
  List<Object> get props => [model];
}
