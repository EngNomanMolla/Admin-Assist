import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/services/auth_service.dart';
import 'package:flutter_widgets/routes/app_routes.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final authService = Get.find<AuthService>();

  void logout() {
    authService.clearAuthData();
    Get.offAllNamed(AppRoutes.SIGN_IN);
    Get.snackbar("Success", "Logged out successfully",
        backgroundColor: Colors.green, colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
  }

  Future<void> deleteAdmin() async {
    final token = authService.token;
    if (token == null) return;

    try {
      final response = await http.delete(
        Uri.parse('https://mentorassist.online/api/admin/profile'), // Assuming this endpoint
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        authService.clearAuthData();
        Get.offAllNamed(AppRoutes.SIGN_IN);
        Get.snackbar("Success", "Admin account deleted successfully",
            backgroundColor: Colors.green, colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
      } else {
        throw Exception("Failed to delete account");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.redAccent, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
    }
  }

  void confirmDelete(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Delete Account',
      desc: 'Are you sure you want to delete your admin account? This action is permanent.',
      btnCancelOnPress: () {},
      btnOkOnPress: () => deleteAdmin(),
      btnOkColor: Colors.redAccent,
      btnOkText: 'Delete',
      btnCancelText: 'Cancel',
    ).show();
  }
}
