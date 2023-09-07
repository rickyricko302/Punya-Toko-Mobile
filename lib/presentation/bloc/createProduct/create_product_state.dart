part of 'create_product_bloc.dart';

abstract class CreateProductState extends Equatable {
  const CreateProductState({required this.indexCategory});
  final int indexCategory;

  @override
  List<Object> get props => [indexCategory];
}

class CreateProductInitial extends CreateProductState {
  const CreateProductInitial({required super.indexCategory});

  @override
  List<Object> get props => [indexCategory];
}

class CreateProductSuccess extends CreateProductState {
  const CreateProductSuccess({required super.indexCategory});
}

class CreateProductFailed extends CreateProductState {
  final String msgError;
  const CreateProductFailed(
      {required super.indexCategory, required this.msgError});

  @override
  List<Object> get props => [msgError];
}
