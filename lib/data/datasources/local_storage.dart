import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final GetStorage box = GetStorage();

  /// Fungsi untuk menyimpan token
  static saveToken(String token) {
    box.write("token", token);
  }

  static String getToken() {
    return box.read("token");
  }
}
