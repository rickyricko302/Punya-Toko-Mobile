import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:punyatoko/data/datasources/local_storage.dart';
import 'package:punyatoko/data/models/post/register_model.dart';
import 'package:punyatoko/util/helper.dart';

import '../datasources/api_client.dart';

abstract class RegisterRepository {
  Future<int> createAccount({required RegisterModel registerModel});
}

class RegisterRepositoryImp implements RegisterRepository {
  final http.Client client;
  RegisterRepositoryImp({required this.client});

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
}
