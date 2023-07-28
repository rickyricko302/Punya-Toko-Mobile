import 'package:flutter_bloc/flutter_bloc.dart';

class LoaderButtonCubit extends Cubit<bool> {
  LoaderButtonCubit() : super(false);

  void setLoading(loading) {
    emit(loading);
  }
}
