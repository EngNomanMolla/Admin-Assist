import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthProvider {
  static const String baseUrl = 'https://mentorassist.online/api/admin';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    return _processResponse(response);
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    return _processResponse(response);
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      try {
        final decoded = jsonDecode(response.body);
        throw Exception(decoded['message'] ?? 'An error occurred');
      } catch (e) {
        throw Exception('Failed to connect to the server: ${response.statusCode}');
      }
    }
  }
}
