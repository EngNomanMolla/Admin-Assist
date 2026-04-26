import 'dart:convert';
import 'dart:io';
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

  Future<void> createBanner(Map<String, String> data, String? filePath) async {
    final token = Get.find<AuthService>().token;
    
    var request = http.MultipartRequest('POST', Uri.parse("$baseUrl/admin/banners"));
    
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    data.forEach((key, value) {
      request.fields[key] = value;
    });

    if (filePath != null && !filePath.startsWith('http') && File(filePath).existsSync()) {
      request.files.add(await http.MultipartFile.fromPath('image', filePath));
    } else if (filePath != null) {
      request.fields['image'] = filePath;
    }

    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode != 200 && response.statusCode != 201) {
      final error = json.decode(response.body);
      throw Exception(error['message'] ?? "Failed to create banner");
    }
  }

  Future<void> updateBanner(int id, Map<String, String> data, String? filePath) async {
    final token = Get.find<AuthService>().token;
    
    // Using POST with _method: PUT for Laravel multipart support
    var request = http.MultipartRequest('POST', Uri.parse("$baseUrl/admin/banners/$id"));
    
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.fields['_method'] = 'PUT';
    data.forEach((key, value) {
      request.fields[key] = value;
    });

    if (filePath != null && !filePath.startsWith('http') && File(filePath).existsSync()) {
      request.files.add(await http.MultipartFile.fromPath('image', filePath));
    } else if (filePath != null) {
      request.fields['image'] = filePath;
    }

    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode != 200) {
      final error = json.decode(response.body);
      throw Exception(error['message'] ?? "Failed to update banner");
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
