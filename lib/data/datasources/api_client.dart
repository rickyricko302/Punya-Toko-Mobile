import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:punyatoko/data/datasources/local_storage.dart';

class ApiClient {
  /// header dengan token user
  static Map<String, String> headersWithToken() {
    return {
      "Accept": "application/json",
      "authorization": "Bearer ${LocalStorage.getToken()}"
    };
  }

  /// header tanap token user
  static Map<String, String> headersWithoutToken() {
    return {
      "Accept": "application/json",
    };
  }

  /// url/api
  static final String _baseUrl = FlavorConfig.instance.variables['base_url'];

  static String register = "$_baseUrl/auth/register";
  static String createStore = "$_baseUrl/store";
  static String login = "$_baseUrl/auth/login";
  static String category = "$_baseUrl/category";
  static String deleteCategory(int idCategory) {
    return "$_baseUrl/category/$idCategory";
  }

  static String updateCategory(int idCategory) {
    return "$_baseUrl/category/$idCategory";
  }

  static String product = "$_baseUrl/product";
}
