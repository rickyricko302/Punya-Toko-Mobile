part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class ListingCategoryLoading extends CategoryState {}

class ListingCategorySuccess extends CategoryState {
  final List<CategoryEntity> model;
  const ListingCategorySuccess({required this.model});
  @override
  List<Object> get props => [model];
}

class ListingCategoryFailed extends CategoryState {
  final String msgError;
  const ListingCategoryFailed({required this.msgError});

  @override
  List<Object> get props => [msgError];
}

class DeleteCategorySuccess extends CategoryState {}

class DeleteCategoryFailed extends CategoryState {
  final String msgError;
  const DeleteCategoryFailed({required this.msgError});

  @override
  List<Object> get props => [msgError];
}
