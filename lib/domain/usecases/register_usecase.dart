import 'package:punyatoko/data/models/post/register_model.dart';

import '../../data/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepositoryImp registerRepositoryImp;
  RegisterUseCase({required this.registerRepositoryImp});

  Future<int> registerUser({required RegisterModel registerModel}) async {
    return await registerRepositoryImp.createAccount(
        registerModel: registerModel);
  }
}
