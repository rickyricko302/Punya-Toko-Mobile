import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:punyatoko/data/models/post/register_model.dart';
import 'package:punyatoko/presentation/bloc/loader/loader_button_cubit.dart';

import '../../../domain/usecases/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;
  RegisterBloc({required this.registerUseCase})
      : super(const RegisterInitial(
          gender: '',
        )) {
    on<RegisterChangeGenderEvent>((event, emit) {
      emit(RegisterInitial(
        gender: event.gender,
      ));
    });
    on<RegisterAccountEvent>(
      (event, emit) async {
        try {
          event.loaderButtonCubit.setLoading(true);
          emit(RegisterInitial(gender: state.gender));
          await registerUseCase.registerUser(registerModel: event.model);
          emit(RegisterSuccess(gender: state.gender));
          event.loaderButtonCubit.setLoading(false);
        } catch (e) {
          event.loaderButtonCubit.setLoading(false);
          emit(RegisterFailed(msgError: e.toString(), gender: state.gender));
        }
      },
    );
  }
}
