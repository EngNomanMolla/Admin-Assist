import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../services/auth_service.dart';

class CareerProvider {
  final String baseUrl = "https://mentorassist.online/api";

  Future<Map<String, dynamic>> fetchJobCirculars() async {
    final token = Get.find<AuthService>().token;
    
    final response = await http.get(
      Uri.parse("$baseUrl/admin/job_circulars"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load job circulars");
    }
  }

  Future<void> deleteJobCircular(int id) async {
    final token = Get.find<AuthService>().token;
    
    final response = await http.delete(
      Uri.parse("$baseUrl/admin/job_circulars/$id"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Failed to delete job circular");
    }
  }

  Future<void> createJobCircular(Map<String, dynamic> data) async {
    final token = Get.find<AuthService>().token;
    
    final response = await http.post(
      Uri.parse("$baseUrl/admin/job_circulars"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to create job circular");
    }
  }

  Future<void> updateJobCircular(int id, Map<String, dynamic> data) async {
    final token = Get.find<AuthService>().token;
    
    final response = await http.put(
      Uri.parse("$baseUrl/admin/job_circulars/$id"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update job circular");
    }
  }
}
