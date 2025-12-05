import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constant/app_api.dart';
import '../../services/auth_api.dart';

class CategoryGetApi {
  Future<Map<String, dynamic>?> getCategory(String idOrDocId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AuthApi.tokenKey);

    final url = "${AppApi.categories}/$idOrDocId";

    final res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode != 200) return null;
    return jsonDecode(res.body)["data"];
  }
}