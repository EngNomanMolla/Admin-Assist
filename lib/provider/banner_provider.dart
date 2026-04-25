import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_widgets/services/auth_service.dart';
import 'package:get/get.dart';

class BannerProvider {
  final String baseUrl = "https://mentorassist.online/api"; // Same as NoticeProvider

  Future<Map<String, dynamic>> fetchBanners() async {
    final token = Get.find<AuthService>().token;
    
    final response = await http.get(
      Uri.parse("$baseUrl/admin/banners"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load banners");
    }
  }

  Future<void> updateBanner(int id, Map<String, dynamic> data) async {
    final token = Get.find<AuthService>().token;
    
    final response = await http.put(
      Uri.parse("$baseUrl/admin/banners/$id"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update banner");
    }
  }

  Future<void> deleteBanner(int id) async {
    final token = Get.find<AuthService>().token;
    
    final response = await http.delete(
      Uri.parse("$baseUrl/admin/banners/$id"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Failed to delete banner");
    }
  }
}
