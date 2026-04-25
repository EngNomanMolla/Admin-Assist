import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../provider/user_provider.dart';

class UserController extends GetxController {
  final UserProvider _userProvider = UserProvider();
  var users = <User>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading(true);
      final response = await _userProvider.fetchActiveUsers();
      users.assignAll(response.map((e) => User.fromJson(e)).toList());
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch users: ${e.toString()}",
          backgroundColor: Colors.redAccent, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
    } finally {
      isLoading(false);
    }
  }

  void updateUserInfo(int index, String newName, String newPhone) {
    // This will need API implementation later, for now just local update if needed
    update();
  }

  Future<void> deleteUser(int id) async {
    try {
      isLoading(true);
      await _userProvider.deleteUser(id);
      
      users.removeWhere((u) => u.id == id);
      
      Get.back(); // Close the details screen first
      
      Get.snackbar("Success", "User deleted successfully",
          backgroundColor: Colors.green, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
    } catch (e) {
      Get.snackbar("Error", "Failed to delete user: ${e.toString()}",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }
}
