part of 'create_store_bloc.dart';

abstract class CreateStoreEvent extends Equatable {
  const CreateStoreEvent();

  @override
  List<Object> get props => [];
}

class CreateStorePressEvent extends CreateStoreEvent {
  final LoaderButtonCubit loaderButtonCubit;
  final CreateStoreModel model;
  const CreateStorePressEvent(
      {required this.loaderButtonCubit, required this.model});

  @override
  List<Object> get props => [loaderButtonCubit, model];
}
