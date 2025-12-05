import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constant/app_api.dart';
import '../../services/auth_api.dart';

class CategoryUpdateApi {
  Future<Map<String, dynamic>> updateCategory(String docId, Map<String, dynamic> fields) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AuthApi.tokenKey);

    final res = await http.put(
      Uri.parse("${AppApi.categories}/$docId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"data": fields}),
    );

    if (!res.statusCode.toString().startsWith("2")) {
      throw Exception("Failed to update category");
    }

    return jsonDecode(res.body);
  }
}