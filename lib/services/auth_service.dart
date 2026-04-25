import 'package:get/get.dart';
import '../models/admin_model.dart';

class AuthService extends GetxService {
  String? token;
  Admin? admin;

  void setUserData(String newToken, Admin newAdmin) {
    token = newToken;
    admin = newAdmin;
  }

  void clearAuthData() {
    token = null;
    admin = null;
  }
}
