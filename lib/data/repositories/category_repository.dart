import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:punyatoko/data/datasources/api_client.dart';
import 'package:punyatoko/data/models/response/category_model.dart';
import 'package:punyatoko/util/helper.dart';

abstract class CategoryRepository {
  Future<int> createCategory({required String name});
  Future<List<CategoryModel>> getCategory();
  Future<int> deleteCategory({required int idCategory});
}

class CategoryRepositoryImp implements CategoryRepository {
  @override
  Future<int> createCategory({required String name}) async {
    final res = await http.post(Uri.parse(ApiClient.category),
        headers: ApiClient.headersWithToken(), body: {'name': name});
    log(Helper.messageShow(res));
    if (res.statusCode != 200) {
      throw (Exception(Helper.generateResponse(res)));
    }
    return 200;
  }

  @override
  Future<int> deleteCategory({required int idCategory}) async {
    final res = await http.delete(
        Uri.parse(ApiClient.deleteCategory(idCategory)),
        headers: ApiClient.headersWithToken());
    // log(Helper.messageShow(res));
    log(res.body);
    if (res.statusCode != 200) {
      throw (Exception(Helper.generateResponse(res)));
    }
    return 200;
  }

  @override
  Future<List<CategoryModel>> getCategory() async {
    final res = await http.get(Uri.parse(ApiClient.category),
        headers: ApiClient.headersWithToken());
    log(Helper.generateResponse(res));
    if (res.statusCode != 200) {
      throw (Exception(Helper.generateResponse(res)));
    }
    Iterable datas = jsonDecode(res.body)['data'];
    List<CategoryModel> model = [];
    for (var element in datas) {
      model.add(CategoryModel.fromJson(element));
    }
    return model;
  }
}
