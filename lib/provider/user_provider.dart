import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_widgets/services/auth_service.dart';
import 'package:get/get.dart';

class UserProvider {
  final String baseUrl = "https://mentorassist.online/api";

  Future<List<dynamic>> fetchActiveUsers() async {
    final token = Get.find<AuthService>().token;
    
    final response = await http.get(
      Uri.parse("$baseUrl/admin/users?status=active"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load users");
    }
  }

  Future<void> deleteUser(int id) async {
    final token = Get.find<AuthService>().token;
    
    final response = await http.delete(
      Uri.parse("$baseUrl/admin/users/$id"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Failed to delete user");
    }
  }
}
