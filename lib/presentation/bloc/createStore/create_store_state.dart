part of 'create_store_bloc.dart';

abstract class CreateStoreState extends Equatable {
  const CreateStoreState();

  @override
  List<Object> get props => [];
}

class CreateStoreInitial extends CreateStoreState {}

class CreateStoreSuccess extends CreateStoreState {}

class CreateStoreFailed extends CreateStoreState {
  final String msgError;

  const CreateStoreFailed({required this.msgError});
  @override
  List<Object> get props => [msgError];
}
