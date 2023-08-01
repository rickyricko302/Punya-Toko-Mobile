import 'package:flutter_flavor/flutter_flavor.dart';

class ApiClient {
  static final String _baseUrl = FlavorConfig.instance.variables['base_url'];

  static String register = "$_baseUrl/auth/register";
}
