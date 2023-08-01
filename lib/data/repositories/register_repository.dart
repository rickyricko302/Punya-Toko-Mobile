import 'dart:developer';

import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:http/http.dart' as http;
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
        headers: Helper.headerWithoutToken(), body: registerModel.toJson());
    log(Helper.generateException(res));
    if (res.statusCode != 200) {
      throw Helper.messageShow(res);
    }
    return 200;
  }
}
