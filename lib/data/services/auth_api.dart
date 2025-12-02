import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/app_api.dart';

class AuthApi {
  static const String tokenKey = 'auth_token';
  static const String userKey = 'auth_user';
  static const String expiryKey = 'auth_token_expiry';

  // same as TOKEN_EXPIRY_HOURS in React
  static const int tokenExpiryHours = 2;

  /// Returns true if login succeeds, otherwise throws an Exception
  Future<void> login({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse(AppApi.login);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'identifier': username, // Strapi expects `identifier`
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['jwt'] != null) {
      final jwt = data['jwt'] as String;
      final user = data['user'];

      // calculate expiry (same logic as React)
      final expiryMillis = DateTime.now()
              .add(const Duration(hours: tokenExpiryHours))
              .millisecondsSinceEpoch;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(tokenKey, jwt);
      await prefs.setString(userKey, jsonEncode(user));
      await prefs.setInt(expiryKey, expiryMillis);
    } else {
      final message =
          data['error']?['message'] ?? 'Invalid credentials or login failed';
      throw Exception(message);
    }
  }

  /// Optional helper: check if token is still valid
  Future<bool> hasValidToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(tokenKey);
    final expiry = prefs.getInt(expiryKey);

    if (token == null || expiry == null) return false;

    final now = DateTime.now().millisecondsSinceEpoch;
    return now < expiry;
  }

  /// Optional: clear token on logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(userKey);
    await prefs.remove(expiryKey);
  }
}