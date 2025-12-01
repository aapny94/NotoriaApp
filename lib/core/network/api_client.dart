import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final _client = http.Client();

  Future<dynamic> get(String url) async {
    final res = await _client.get(Uri.parse(url));
    return jsonDecode(res.body);
  }
}