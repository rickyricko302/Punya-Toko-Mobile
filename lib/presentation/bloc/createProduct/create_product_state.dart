part of 'create_product_bloc.dart';

abstract class CreateProductState extends Equatable {
  const CreateProductState(
      {required this.indexCategory,
      required this.categoryEntity,
      required this.isExpense});
  final int indexCategory;
  final List<CategoryEntity> categoryEntity;
  final bool isExpense;

  @override
  List<Object> get props => [indexCategory];
}

class CreateProductInitial extends CreateProductState {
  const CreateProductInitial(
      {required super.indexCategory,
      required super.categoryEntity,
      required super.isExpense});

  @override
  List<Object> get props => [indexCategory, categoryEntity, isExpense];
}

class CreateProductSuccess extends CreateProductState {
  const CreateProductSuccess(
      {required super.indexCategory,
      required super.categoryEntity,
      required super.isExpense});
}

class CreateProductFailed extends CreateProductState {
  final String msgError;
  const CreateProductFailed(
      {required super.indexCategory,
      required this.msgError,
      required super.categoryEntity,
      required super.isExpense});

  @override
  List<Object> get props => [msgError];
}

class CreateCategorySuccess extends CreateProductState {
  const CreateCategorySuccess(
      {required super.indexCategory,
      required super.categoryEntity,
      required super.isExpense});
}

class CreateCategoryFailed extends CreateProductState {
  final String msgError;
  const CreateCategoryFailed(
      {required super.indexCategory,
      required this.msgError,
      required super.categoryEntity,
      required super.isExpense});

  @override
  List<Object> get props => [msgError];
}

class GetCategoryLoading extends CreateProductState {
  const GetCategoryLoading(
      {required super.indexCategory,
      required super.categoryEntity,
      required super.isExpense});
}

class GetCategorySuccess extends CreateProductState {
  const GetCategorySuccess(
      {required super.categoryEntity,
      required super.indexCategory,
      required super.isExpense});
}

class GetCategoryFailed extends CreateProductState {
  final String msgError;
  const GetCategoryFailed(
      {required this.msgError,
      required super.indexCategory,
      required super.categoryEntity,
      required super.isExpense});
}
