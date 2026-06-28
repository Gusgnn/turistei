import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<Map<String, String>> _headers({bool auth = false}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (auth) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  Future<dynamic> get(String url, {bool auth = false}) async {
    final response = await http.get(
      Uri.parse(url),
      headers: await _headers(auth: auth),
    );

    return _handleResponse(response);
  }

  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? body,
    bool auth = false,
  }) async {
    final response = await http.post(
      Uri.parse(url),
      headers: await _headers(auth: auth),
      body: jsonEncode(body ?? {}),
    );

    return _handleResponse(response);
  }

  Future<dynamic> put(
    String url, {
    Map<String, dynamic>? body,
    bool auth = false,
  }) async {
    final response = await http.put(
      Uri.parse(url),
      headers: await _headers(auth: auth),
      body: jsonEncode(body ?? {}),
    );

    return _handleResponse(response);
  }

  Future<dynamic> delete(String url, {bool auth = false}) async {
    final response = await http.delete(
      Uri.parse(url),
      headers: await _headers(auth: auth),
    );

    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    dynamic body;

    try {
      body = response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } catch (_) {
      throw Exception(
        'Resposta inválida do servidor: ${response.body}',
      );
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    throw Exception(
      body?['message'] ?? 'Erro ao comunicar com o servidor.',
    );
  }
}