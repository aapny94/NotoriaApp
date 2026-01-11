import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant/app_api.dart';
import '../../services/auth_api.dart';

class CategoryCreateApi {
  Future<Map<String, dynamic>?> createCategory({
    required String name,
    required String slug,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AuthApi.tokenKey);
    final userStr = prefs.getString(AuthApi.userKey);

    if (token == null || userStr == null) {
      throw Exception('Not authenticated');
    }

    final user = jsonDecode(userStr);
    final userId = user['id'];

    final url = Uri.parse(AppApi.categories);

    final body = jsonEncode({
      'data': {
        'name': name,
        'slug': slug,
        'users_permissions_user': {'id': userId},
      }
    });

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    if (!res.statusCode.toString().startsWith('2')) {
      try {
        final data = jsonDecode(res.body);
        final msg = data['error']?['message'] ?? data['message'] ?? 'Create failed';
        throw Exception(msg);
      } catch (_) {
        throw Exception('Create failed with status ${res.statusCode}');
      }
    }

    return jsonDecode(res.body)['data'];
  }
}
