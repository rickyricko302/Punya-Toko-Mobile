import 'package:punyatoko/data/models/post/login_model.dart';
import 'package:punyatoko/data/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepositoryImp authRepositoryImp;

  LoginUseCase({required this.authRepositoryImp});

  Future<String> loginUser({required LoginModel loginModel}) async {
    return authRepositoryImp.loginAccount(loginModel: loginModel);
  }
}
