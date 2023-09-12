import 'dart:convert';

import 'package:http/http.dart' as http;

class Helper {
  /// Fungsi untuk mengelog API error / gagal
  static String generateResponse(http.Response res) {
    return "\n- url  : ${res.request?.url}\n- res  : ${res.body}\n- code : ${res.statusCode}";
  }

  static String messageShow(http.Response res) {
    try {
      return jsonDecode(res.body)['message'];
    } catch (e) {
      return 'undefinied msg';
    }
  }

  /// Ini adalah fungsi untuk mengubah string ke mata uang indonesia
  ///
  /// Parameter :
  /// - value : String yang akan diubah
  /// - separator : Pemisah 3 digit, default(.)
  /// - trailing : penambah diakhir string
  ///
  /// Example :
  /// ```dart
  /// print("Rp ${Utils.rupiah('10000')}"); //Rp 10.000
  /// ```
  static String rupiah(value, {String separator = '.', String trailing = ''}) {
    return value.toString().replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]}$separator') +
        trailing;
  }
}
