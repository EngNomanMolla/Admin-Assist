import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/provider/auth_provider.dart';
import 'package:flutter_widgets/routes/app_routes.dart';
import 'package:flutter_widgets/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthProvider _authProvider = AuthProvider();

  // Sign In Controllers
  final emailController = TextEditingController(text: "mollanoman2017@gmail.com");
  final passwordController = TextEditingController(text: "12345678");

  // Sign Up Controllers
  final signUpNameController = TextEditingController(text: "Noman Molla");
  final signUpEmailController = TextEditingController(text: "mollanoman2017@gmail.com");
  final signUpPasswordController = TextEditingController(text: "12345678");

  var isLoading = false.obs;

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
      
      // Save token to service
      final token = response['token'] ?? (response['data'] != null ? response['data']['token'] : null);
      if (token != null) {
        Get.find<AuthService>().setToken(token);
      }
      
      Get.snackbar("Success", "Logged in successfully",
          backgroundColor: Colors.green, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
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
