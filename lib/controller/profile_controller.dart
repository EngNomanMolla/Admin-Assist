import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/services/auth_service.dart';
import 'package:flutter_widgets/routes/app_routes.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final authService = Get.find<AuthService>();
  var isLoading = false.obs;

  Future<void> logout() async {
    final token = authService.token;
    
    try {
      isLoading(true);
      if (token != null) {
        await http.post(
          Uri.parse('https://mentorassist.online/api/admin/logout'),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );
      }
    } catch (e) {
      // Even if API fails, we usually want to logout locally
      debugPrint("Logout API error: $e");
    } finally {
      isLoading(false);
      authService.clearAuthData();
      Get.offAllNamed(AppRoutes.SIGN_IN);
      Get.snackbar("Success", "Logged out successfully",
          backgroundColor: Colors.green, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
    }
  }
}
