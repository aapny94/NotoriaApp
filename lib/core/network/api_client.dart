import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client = http.Client();

  Future<dynamic> get(String url) async {
    final res = await _client.get(Uri.parse(url));

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return jsonDecode(res.body);
    } else {
      throw Exception("GET failed: ${res.statusCode} ${res.body}");
    }
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    final res = await _client.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return jsonDecode(res.body);
    } else {
      throw Exception("POST failed: ${res.statusCode} ${res.body}");
    }
  }
}