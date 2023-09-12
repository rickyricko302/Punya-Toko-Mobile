import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:punyatoko/data/constants/status.dart';
import 'package:punyatoko/data/models/post/create_product_model.dart';
import 'package:punyatoko/domain/entities/category_entity.dart';
import 'package:punyatoko/presentation/bloc/loader/loader_button_cubit.dart';

import '../../../domain/usecases/create_category_usecase.dart';
import '../../../domain/usecases/create_product_usecase.dart';
import '../../../domain/usecases/get_category_usecase.dart';

part 'create_product_event.dart';
part 'create_product_state.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  final LoaderButtonCubit loaderButtonCubit;
  final CreateCategoryUseCase createCategoryUseCase;
  final GetCategoryUseCase getCategoryUseCase;
  final CreateProductUseCase createProductUseCase;
  CreateProductBloc(
      {required this.loaderButtonCubit,
      required this.createCategoryUseCase,
      required this.getCategoryUseCase,
      required this.createProductUseCase})
      : super(const CreateProductInitial(
            indexCategory: -1, categoryEntity: [], isExpense: false)) {
    on<SelectCategoryEvent>((event, emit) async {
      emit(CreateProductInitial(
          indexCategory: event.index,
          categoryEntity: state.categoryEntity,
          isExpense: state.isExpense));
    });

    on<CreateCategoryEvent>((event, emit) async {
      loaderButtonCubit.setLoading(true);
      try {
        emit(CreateProductInitial(
            indexCategory: state.indexCategory,
            categoryEntity: state.categoryEntity,
            isExpense: state.isExpense));
        await createCategoryUseCase.createCategory(name: event.name);
        emit(CreateCategorySuccess(
            indexCategory: state.indexCategory,
            categoryEntity: state.categoryEntity,
            isExpense: state.isExpense));
      } catch (e) {
        log(e.toString());
        emit(CreateCategoryFailed(
            indexCategory: state.indexCategory,
            msgError: e.toString(),
            categoryEntity: state.categoryEntity,
            isExpense: state.isExpense));
      }
      loaderButtonCubit.setLoading(false);
    });

    on<GetCategoryEvent>((event, emit) async {
      try {
        emit(GetCategoryLoading(
            indexCategory: state.indexCategory,
            categoryEntity: state.categoryEntity,
            isExpense: state.isExpense));
        List<CategoryEntity> entity = await getCategoryUseCase.getCategory();
        int index = state.indexCategory;
        if (event.selectLast ?? false) {
          index = entity.length - 1;
        }
        emit(GetCategorySuccess(
            categoryEntity: entity,
            indexCategory: index,
            isExpense: state.isExpense));
      } catch (e) {
        emit(GetCategoryFailed(
            msgError: e.toString(),
            indexCategory: state.indexCategory,
            categoryEntity: state.categoryEntity,
            isExpense: state.isExpense));
      }
    });

    on<CheckboxExpenseEvent>((event, emit) => emit(CreateProductInitial(
        indexCategory: state.indexCategory,
        categoryEntity: state.categoryEntity,
        isExpense: event.value)));

    on<SaveProductEvent>((event, emit) async {
      loaderButtonCubit.setLoading(true);
      try {
        await createProductUseCase.createProduct(model: event.model);
        emit(CreateProductSuccess(
            indexCategory: state.indexCategory,
            categoryEntity: state.categoryEntity,
            isExpense: state.isExpense));
      } catch (e) {
        emit(CreateProductFailed(
            msgError: e.toString(),
            indexCategory: state.indexCategory,
            categoryEntity: state.categoryEntity,
            isExpense: state.isExpense));
      }
      loaderButtonCubit.setLoading(false);
    });
  }

  Status getStatusCategory() {
    if (state is GetCategoryLoading) {
      return Status.LOADING;
    } else if (state is GetCategoryFailed) {
      return Status.FAILED;
    }
    return Status.SUCCESS;
  }
}
