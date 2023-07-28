import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterInitial(gender: '')) {
    on<RegisterChangeGenderEvent>((event, emit) {
      emit(RegisterInitial(gender: event.gender));
    });
  }
}
