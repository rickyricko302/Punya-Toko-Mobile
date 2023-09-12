import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:punyatoko/data/datasources/api_client.dart';
import 'package:punyatoko/data/models/post/create_product_model.dart';
import 'package:punyatoko/util/helper.dart';

abstract class ProductRepository {
  Future<int> createProduct({required CreateProductModel model});
}

class ProductRepositoryImp implements ProductRepository {
  @override
  Future<int> createProduct({required CreateProductModel model}) async {
    var res = await http.post(Uri.parse(ApiClient.product),
        body: model.toJson(), headers: ApiClient.headersWithToken());
    log(Helper.messageShow(res));
    if (res.statusCode != 200) {
      throw (Exception(Helper.generateResponse(res)));
    }
    return 200;
  }
}
