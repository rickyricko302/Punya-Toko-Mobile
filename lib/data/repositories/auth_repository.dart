import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:punyatoko/data/datasources/local_storage.dart';
import 'package:punyatoko/data/models/post/login_model.dart';
import 'package:punyatoko/data/models/post/register_model.dart';
import 'package:punyatoko/util/helper.dart';

import '../datasources/api_client.dart';

abstract class AuthRepository {
  Future<int> createAccount({required RegisterModel registerModel});
  Future<String> loginAccount({required LoginModel loginModel});
}

class AuthRepositoryImp implements AuthRepository {
  final http.Client client;
  AuthRepositoryImp({required this.client});

  @override
  Future<int> createAccount({required RegisterModel registerModel}) async {
    var res = await client.post(Uri.parse(ApiClient.register),
        headers: ApiClient.headersWithoutToken(), body: registerModel.toJson());
    log(Helper.generateResponse(res));
    if (res.statusCode != 200) {
      throw Helper.messageShow(res);
    }
    LocalStorage.saveToken(jsonDecode(res.body)['token']);
    return 200;
  }

  @override
  Future<String> loginAccount({required LoginModel loginModel}) async {
    var res = await http.post(Uri.parse(ApiClient.login),
        headers: ApiClient.headersWithoutToken(), body: loginModel.toJson());
    log(Helper.generateResponse(res));
    if (res.statusCode != 200) {
      throw (Helper.messageShow(res));
    }
    return jsonDecode(res.body)['token'];
  }
}
