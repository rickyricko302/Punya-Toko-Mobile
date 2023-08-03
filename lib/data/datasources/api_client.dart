import 'package:flutter_flavor/flutter_flavor.dart';

class ApiClient {
  /// header dengan token user
  static Map<String, String> headersWithToken(String token) {
    return {"Accept": "application/json", "authorization": "Bearer $token"};
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
}
