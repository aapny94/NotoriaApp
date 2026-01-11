import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant/app_api.dart';
import '../../services/auth_api.dart';

class CategoryDeleteApi {
  /// Deletes a category by docId
  Future<void> deleteCategory(String docId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AuthApi.tokenKey);

    if (token == null) {
      throw Exception('Not authenticated');
    }

    final url = Uri.parse('${AppApi.categories}/$docId');

    final res = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (!res.statusCode.toString().startsWith('2')) {
      try {
        final data = jsonDecode(res.body);
        final msg = data['error']?['message'] ?? data['message'] ?? 'Delete failed';
        throw Exception(msg);
      } catch (_) {
        throw Exception('Delete failed with status ${res.statusCode}');
      }
    }
  }
}
