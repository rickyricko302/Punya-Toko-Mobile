import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:punyatoko/presentation/bloc/loader/loader_button_cubit.dart';

import '../../../domain/usecases/create_category_usecase.dart';

part 'create_product_event.dart';
part 'create_product_state.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  final LoaderButtonCubit loaderButtonCubit;
  final CreateCategoryUseCase createCategoryUseCase;
  CreateProductBloc(
      {required this.loaderButtonCubit, required this.createCategoryUseCase})
      : super(const CreateProductInitial(indexCategory: -1)) {
    on<CreateProductEvent>((event, emit) async {
      if (event is SelectCategoryEvent) {
        emit(CreateProductInitial(indexCategory: event.index));
      } else if (event is CreateCategoryEvent) {
        loaderButtonCubit.setLoading(true);
        try {
          emit(CreateProductInitial(indexCategory: state.indexCategory));
          await createCategoryUseCase.createCategory(name: event.name);
          emit(CreateProductSuccess(indexCategory: state.indexCategory));
        } catch (e) {
          log(e.toString());
          emit(CreateProductFailed(
              indexCategory: state.indexCategory, msgError: e.toString()));
        }
        loaderButtonCubit.setLoading(false);
      }
    });
  }
}
