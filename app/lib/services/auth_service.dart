import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_config.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> login({
    required String email,
    required String senha,
  }) async {
    final response = await _api.post(
      '${ApiConfig.auth}/login',
      body: {
        'email': email,
        'senha': senha,
      },
    );

    if (response['success'] == true) {
      final token = response['data']?['token'];

      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token.toString());
      }

      return Map<String, dynamic>.from(response);
    }

    throw Exception(response['message'] ?? 'Erro ao fazer login.');
  }

  Future<Map<String, dynamic>> register({
    required String nome,
    required String email,
    required String senha,
  }) async {
    final response = await _api.post(
      ApiConfig.users,
      body: {
        'nome': nome,
        'email': email,
        'senha': senha,
        'tipo': 'usuario',
      },
    );

    if (response['success'] == true) {
      return Map<String, dynamic>.from(response);
    }

    throw Exception(response['message'] ?? 'Erro ao criar conta.');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}