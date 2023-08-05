import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:punyatoko/data/datasources/local_storage.dart';
import 'package:punyatoko/presentation/bloc/loader/loader_button_cubit.dart';

import '../../../data/models/post/create_store_model.dart';
import '../../../domain/usecases/create_store_usecase.dart';

part 'create_store_event.dart';
part 'create_store_state.dart';

class CreateStoreBloc extends Bloc<CreateStoreEvent, CreateStoreState> {
  final CreateStoreUseCase createStoreUseCase;
  CreateStoreBloc({required this.createStoreUseCase})
      : super(CreateStoreInitial()) {
    on<CreateStorePressEvent>((event, emit) async {
      event.loaderButtonCubit.setLoading(true);
      try {
        emit(CreateStoreInitial());
        await createStoreUseCase.createStore(
            token: LocalStorage.getToken() ?? "", model: event.model);
        emit(CreateStoreSuccess());
      } catch (e) {
        emit(CreateStoreFailed(msgError: e.toString()));
      }
      event.loaderButtonCubit.setLoading(false);
    });
  }
}
