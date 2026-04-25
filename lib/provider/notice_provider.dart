import 'dart:convert';
import 'package:http/http.dart' as http;

class NoticeProvider {
  static const String baseUrl = 'https://mentorassist.online/api/admin';

  Future<Map<String, dynamic>> createNotice({
    required String noticeText,
    required String startDate,
    required String endDate,
    required String token,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notices'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'notice_text': noticeText,
        'start_date': startDate,
        'end_date': endDate,
        'status': 'active',
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      try {
        final decoded = jsonDecode(response.body);
        throw Exception(decoded['message'] ?? 'An error occurred while creating notice');
      } catch (e) {
        throw Exception('Failed to create notice: ${response.statusCode}');
      }
    }
  }

  Future<List<dynamic>> fetchNotices(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/notices'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decoded = jsonDecode(response.body);
      return decoded['notices'] ?? [];
    } else {
      try {
        final decoded = jsonDecode(response.body);
        throw Exception(decoded['message'] ?? 'An error occurred while fetching notices');
      } catch (e) {
        throw Exception('Failed to fetch notices: ${response.statusCode}');
      }
    }
  }

  Future<Map<String, dynamic>> updateNotice({
    required int noticeId,
    required String noticeText,
    required String startDate,
    required String endDate,
    required String token,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/notices/$noticeId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'notice_text': noticeText,
        'start_date': startDate,
        'end_date': endDate,
        'status': 'active',
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      try {
        final decoded = jsonDecode(response.body);
        throw Exception(decoded['message'] ?? 'An error occurred while updating notice');
      } catch (e) {
        throw Exception('Failed to update notice: ${response.statusCode}');
      }
    }
  }

  Future<Map<String, dynamic>> deleteNotice({
    required int noticeId,
    required String token,
  }) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/notices/$noticeId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      if (response.body.isEmpty) return {'message': 'Deleted successfully'};
      return jsonDecode(response.body);
    } else {
      try {
        final decoded = jsonDecode(response.body);
        throw Exception(decoded['message'] ?? 'An error occurred while deleting notice');
      } catch (e) {
        throw Exception('Failed to delete notice: ${response.statusCode}');
      }
    }
  }
}
