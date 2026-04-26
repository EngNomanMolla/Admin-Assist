import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../services/auth_service.dart';

class DashboardProvider {
  final String baseUrl = "https://mentorassist.online/api/admin";

  Future<Map<String, dynamic>> fetchDashboardData() async {
    final token = Get.find<AuthService>().token;
    
    final response = await http.get(
      Uri.parse("$baseUrl/dashboard"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load dashboard data");
    }
  }
}
