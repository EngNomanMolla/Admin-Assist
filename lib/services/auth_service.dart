import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/admin_model.dart';

class AuthService extends GetxService {
  String? token;
  Admin? admin;
  bool isRememberMe = false;

  late SharedPreferences _prefs;

  Future<AuthService> init() async {
    _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('token');
    isRememberMe = _prefs.getBool('remember_me') ?? false;
    
    final adminStr = _prefs.getString('admin');
    if (adminStr != null) {
      admin = Admin.fromJson(json.decode(adminStr));
    }
    return this;
  }

  void setUserData(String newToken, Admin newAdmin, bool remember) {
    token = newToken;
    admin = newAdmin;
    isRememberMe = remember;

    if (remember) {
      _prefs.setString('token', newToken);
      _prefs.setBool('remember_me', true);
      _prefs.setString('admin', json.encode(newAdmin.toJson()));
    }
  }

  void clearAuthData() {
    token = null;
    admin = null;
    isRememberMe = false;
    _prefs.clear();
  }
}
