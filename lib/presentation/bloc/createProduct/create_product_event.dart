part of 'create_product_bloc.dart';

abstract class CreateProductEvent extends Equatable {
  const CreateProductEvent();

  @override
  List<Object> get props => [];
}

class SelectCategoryEvent extends CreateProductEvent {
  final int index;
  const SelectCategoryEvent({required this.index});
}

class CreateCategoryEvent extends CreateProductEvent {
  final String name;
  const CreateCategoryEvent({required this.name});
}
