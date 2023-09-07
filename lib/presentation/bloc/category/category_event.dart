part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryEventGetData extends CategoryEvent {}

class CategoryEventDelete extends CategoryEvent {
  final int idCategory;
  const CategoryEventDelete({required this.idCategory});
}
