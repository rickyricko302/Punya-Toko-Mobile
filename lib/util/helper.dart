import 'dart:convert';

import 'package:http/http.dart' as http;

class Helper {
  /// Fungsi untuk mengelog API error / gagal
  static String generateResponse(http.Response res) {
    return "\n- url  : ${res.request?.url}\n- res  : ${res.body}\n- code : ${res.statusCode}";
  }

  static String messageShow(http.Response res) {
    return jsonDecode(res.body)['message'];
  }
}
