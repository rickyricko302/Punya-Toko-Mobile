import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:punyatoko/domain/entities/category_entity.dart';

import '../../../domain/usecases/create_category_usecase.dart';
import '../../../domain/usecases/delete_category_usecase.dart';
import '../../../domain/usecases/get_category_usecase.dart';
import '../../../domain/usecases/update_category_usecase.dart';
import '../loader/loader_button_cubit.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoryUseCase getCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  final LoaderButtonCubit loaderButtonCubit;
  final CreateCategoryUseCase createCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  CategoryBloc(
      {required this.getCategoryUseCase,
      required this.deleteCategoryUseCase,
      required this.createCategoryUseCase,
      required this.updateCategoryUseCase,
      required this.loaderButtonCubit})
      : super(ListingCategoryLoading()) {
    on<CategoryEventGetData>((event, emit) async {
      try {
        emit(ListingCategoryLoading());
        final List<CategoryEntity> model =
            await getCategoryUseCase.getCategory();
        emit(ListingCategorySuccess(model: model));
      } catch (e) {
        emit(ListingCategoryFailed(msgError: e.toString()));
      }
    });

    on<CategoryEventDelete>(
      (event, emit) async {
        try {
          emit(ListingCategoryLoading());
          await deleteCategoryUseCase.deleteCategory(
              idCategory: event.idCategory);
          emit(DeleteCategorySuccess());
        } catch (e) {
          log(e.toString());
          emit(DeleteCategoryFailed(msgError: e.toString()));
        }
      },
    );

    on<CategoryEventCreate>((event, emit) async {
      loaderButtonCubit.setLoading(true);
      try {
        await createCategoryUseCase.createCategory(name: event.categoryName);
        emit(CreateCategorySuccess());
      } catch (e) {
        emit(CreateCategoryFailed(msgError: e.toString()));
      }
      loaderButtonCubit.setLoading(false);
    });

    on<CategoryEventUpdate>((event, emit) async {
      loaderButtonCubit.setLoading(true);
      try {
        await updateCategoryUseCase.updateCategory(
            idCategory: event.idCategory, categoryName: event.categroyName);
        emit(UpdateCategorySuccess());
      } catch (e) {
        emit(UpdateCategoryFailed(msgError: e.toString()));
      }
      loaderButtonCubit.setLoading(false);
    });
  }
}
