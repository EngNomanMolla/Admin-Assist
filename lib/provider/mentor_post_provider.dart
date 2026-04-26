import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../services/auth_service.dart';

class MentorPostProvider {
  final String baseUrl = "https://mentorassist.online/api/admin";

  Future<List<dynamic>> fetchMentorPosts() async {
    final token = Get.find<AuthService>().token;
    
    final response = await http.get(
      Uri.parse("$baseUrl/mentor_posts"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['mentor_posts'] ?? [];
    } else {
      throw Exception("Failed to load mentor posts");
    }
  }

  Future<bool> deleteMentorPost(int id) async {
    final token = Get.find<AuthService>().token;
    
    final response = await http.delete(
      Uri.parse("$baseUrl/mentor_posts/$id"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    return response.statusCode == 200;
  }

  Future<void> createMentorPost(Map<String, String> fields, String? imagePath) async {
    final token = Get.find<AuthService>().token;
    var request = http.MultipartRequest('POST', Uri.parse("$baseUrl/mentor_posts"));
    
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.fields.addAll(fields);

    if (imagePath != null && fields['type'] == 'image') {
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));
    }

    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode != 200 && response.statusCode != 201) {
      final error = json.decode(response.body);
      throw Exception(error['message'] ?? "Failed to create post");
    }
  }

  Future<void> updateMentorPost(int id, Map<String, String> fields, String? imagePath) async {
    final token = Get.find<AuthService>().token;
    var request = http.MultipartRequest('POST', Uri.parse("$baseUrl/mentor_posts/$id"));
    
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.fields['_method'] = 'PUT';
    request.fields.addAll(fields);

    if (imagePath != null && fields['type'] == 'image' && !imagePath.startsWith('http')) {
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));
    }

    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode != 200) {
      final error = json.decode(response.body);
      throw Exception(error['message'] ?? "Failed to update post");
    }
  }
}
