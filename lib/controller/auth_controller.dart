import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/provider/auth_provider.dart';
import 'package:flutter_widgets/routes/app_routes.dart';
import 'package:flutter_widgets/services/auth_service.dart';
import 'package:flutter_widgets/models/admin_model.dart';

class AuthController extends GetxController {
  final AuthProvider _authProvider = AuthProvider();

  // Sign In Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Sign Up Controllers
  final signUpNameController = TextEditingController();
  final signUpEmailController = TextEditingController();
  final signUpPasswordController = TextEditingController();

  var isLoading = false.obs;
  var isRememberMe = false.obs;

  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields",
          backgroundColor: Colors.redAccent, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
      return;
    }

    try {
      isLoading(true);
      final response = await _authProvider.login(email, password);
      
      // Save data to service
      final token = response['token'];
      final adminData = response['admin'];
      
      if (token != null && adminData != null) {
        final admin = Admin.fromJson(adminData);
        Get.find<AuthService>().setUserData(token, admin, isRememberMe.value);
      }
      
      Get.offAllNamed(AppRoutes.BOTTOM_NAV);
    } catch (e) {
      Get.snackbar("Login Failed", e.toString().replaceAll('Exception: ', ''),
          backgroundColor: Colors.redAccent, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
    } finally {
      isLoading(false);
    }
  }

  Future<void> register() async {
    final name = signUpNameController.text.trim();
    final email = signUpEmailController.text.trim();
    final password = signUpPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields",
          backgroundColor: Colors.redAccent, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
      return;
    }

    try {
      isLoading(true);
      final response = await _authProvider.register(name, email, password);
      Get.snackbar("Success", "Account created successfully. Please sign in.",
          backgroundColor: Colors.green, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
      Get.offAllNamed(AppRoutes.SIGN_IN);
    } catch (e) {
      Get.snackbar("Registration Failed", e.toString().replaceAll('Exception: ', ''),
          backgroundColor: Colors.redAccent, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    signUpNameController.dispose();
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    super.onClose();
  }
}
