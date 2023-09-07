import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:punyatoko/domain/entities/category_entity.dart';

import '../../../domain/usecases/delete_category_usecase.dart';
import '../../../domain/usecases/get_category_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoryUseCase getCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  CategoryBloc(
      {required this.getCategoryUseCase, required this.deleteCategoryUseCase})
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
  }
}
