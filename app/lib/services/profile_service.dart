import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_config.dart';
import '../models/user.dart';
import 'api_service.dart';

class ProfileService {
  final ApiService _api = ApiService();

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString('userId') ??
        prefs.getString('usuario_id') ??
        prefs.getString('user_id') ??
        prefs.getString('id');

    if (value == null) return null;

    return int.tryParse(value);
  }

  Future<User> getProfile() async {
    final userId = await _getUserId();

    if (userId == null) {
      throw Exception('Usuário não identificado.');
    }

    final response = await _api.get(
      '${ApiConfig.users}/$userId',
      auth: true,
    );

    final data = response is Map && response['data'] != null
        ? response['data']
        : response;

    return User.fromJson(data as Map<String, dynamic>);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('token');
    await prefs.remove('userId');
    await prefs.remove('usuario_id');
    await prefs.remove('user_id');
    await prefs.remove('id');
  }
}