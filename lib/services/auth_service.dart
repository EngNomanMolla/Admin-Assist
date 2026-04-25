import 'package:get/get.dart';

class AuthService extends GetxService {
  String? token;

  void setToken(String newToken) {
    token = newToken;
  }

  void clearToken() {
    token = null;
  }
}
