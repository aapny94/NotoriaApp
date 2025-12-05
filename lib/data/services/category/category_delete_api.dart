import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constant/app_api.dart';
import '../../services/auth_api.dart';

class CategoryDeleteApi {
  Future<bool> deleteCategory(String docId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AuthApi.tokenKey);

    final res = await http.delete(
      Uri.parse("${AppApi.categories}/$docId"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 204) return true;
    if (!res.statusCode.toString().startsWith("2")) return false;

    return true;
  }
}