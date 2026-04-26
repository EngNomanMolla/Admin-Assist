import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../services/auth_service.dart';

class ProductProvider {
  final String baseUrl = "https://mentorassist.online/api/admin";

  Future<List<dynamic>> fetchProducts({int? categoryId}) async {
    final token = Get.find<AuthService>().token;
    
    String url = "$baseUrl/products";
    if (categoryId != null) {
      url += "?category_id=$categoryId";
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['products'] ?? [];
    } else {
      throw Exception("Failed to load products");
    }
  }

  Future<bool> createProduct(Map<String, String> fields, String imagePath) async {
    final token = Get.find<AuthService>().token;
    
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/products"),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.fields.addAll(fields);
    
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imagePath,
    ));

    final response = await request.send();
    final responseData = await http.Response.fromStream(response);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      final error = json.decode(responseData.body);
      throw Exception(error['message'] ?? "Failed to create product");
    }
  }

  Future<bool> updateProduct(int id, Map<String, String> fields, String? imagePath) async {
    final token = Get.find<AuthService>().token;
    
    // Some Laravel/PHP backends require POST with _method=PUT for multipart updates
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/products/$id"),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.fields.addAll(fields);
    
    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imagePath,
      ));
    }

    final response = await request.send();
    final responseData = await http.Response.fromStream(response);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      final error = json.decode(responseData.body);
      throw Exception(error['message'] ?? "Failed to update product");
    }
  }

  Future<bool> deleteProduct(int id) async {
    final token = Get.find<AuthService>().token;
    
    final response = await http.delete(
      Uri.parse("$baseUrl/products/$id"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final error = json.decode(response.body);
      throw Exception(error['message'] ?? "Failed to delete product");
    }
  }
}
