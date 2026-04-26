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
}
