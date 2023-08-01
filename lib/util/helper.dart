import 'dart:convert';

import 'package:http/http.dart' as http;

class Helper {
  /// Fungsi untuk mendapatkan header tanpa token
  static Map<String, String> headerWithoutToken() {
    return {"accept": "application/json"};
  }

  /// Fungsi untuk mendapatkan header dengan token
  static Map<String, String> headerWithToken(String token) {
    return {"accept": "application/json", "authorization": "Bearer $token"};
  }

  /// Fungsi untuk mengelog API error / gagal
  static String generateException(http.Response res) {
    return "\n- url  : ${res.request?.url}\n- res  : ${res.body}\n- code : ${res.statusCode}";
  }

  static String messageShow(http.Response res) {
    return jsonDecode(res.body)['message'];
  }
}
