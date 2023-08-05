import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:punyatoko/data/datasources/local_storage.dart';
import 'package:punyatoko/data/models/post/login_model.dart';
import 'package:punyatoko/domain/usecases/login_usecase.dart';

import '../loader/loader_button_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final LoaderButtonCubit loaderButtonCubit;
  LoginBloc({required this.loginUseCase, required this.loaderButtonCubit})
      : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      loaderButtonCubit.setLoading(true);
      try {
        emit(LoginInitial());
        String token = await loginUseCase.loginUser(loginModel: event.model);
        LocalStorage.saveToken(token);
        emit(LoginSuccess());
      } catch (e) {
        log(e.toString());
        emit(LoginFailed(msgError: e.toString()));
      }
      loaderButtonCubit.setLoading(false);
    });
  }
}
