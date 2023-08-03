import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:punyatoko/data/datasources/api_client.dart';
import 'package:punyatoko/data/models/post/create_store_model.dart';
import 'package:punyatoko/util/helper.dart';

abstract class StoreRepository {
  Future<int> createStore(
      {required String token, required CreateStoreModel model});
}

class StoreRepositoryImp implements StoreRepository {
  final http.Client client;
  StoreRepositoryImp({required this.client});

  @override
  Future<int> createStore(
      {required String token, required CreateStoreModel model}) async {
    var res = await http.post(Uri.parse(ApiClient.createStore),
        headers: ApiClient.headersWithToken(token), body: model.toJson());
    log(Helper.generateResponse(res));
    if (res.statusCode != 200) {
      throw Helper.messageShow(res);
    }
    return 200;
  }
}
