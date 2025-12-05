import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constant/app_api.dart';
import '../../services/auth_api.dart';

class CategoryListApi {
  Future<int?> _getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userStr = prefs.getString(AuthApi.userKey);
    if (userStr == null) return null;
    return jsonDecode(userStr)['id'];
  }

  Future<List<dynamic>> getUserCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AuthApi.tokenKey);
    final userId = await _getCurrentUserId();

    if (token == null || userId == null) return [];

    final url =
        "${AppApi.categories}?populate=users_permissions_user&filters[users_permissions_user][id][\$eq]=$userId";

    final res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (!res.statusCode.toString().startsWith("2")) {
      return getCategories(); // fallback like React
    }

    final data = jsonDecode(res.body);
    return data["data"] ?? [];
  }

  Future<List<dynamic>> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AuthApi.tokenKey);

    final url =
        "${AppApi.categories}?publicationState=preview&pagination[pageSize]=1000";

    final res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(res.body);
    return data["data"] ?? [];
  }
}