import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_config.dart';
import '../models/notification_model.dart';
import 'api_service.dart';

class NotificationService {
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

  Future<List<NotificationModel>> getNotifications() async {
    final userId = await _getUserId();

    if (userId == null) {
      throw Exception('Usuário não identificado.');
    }

    final response = await _api.get(
      '${ApiConfig.notifications}/user/$userId',
      auth: true,
    );

    final List data = _extractList(response);

    return data
        .map(
          (item) => NotificationModel.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<void> markAsRead(String notificationId) async {
    await _api.patch(
      '${ApiConfig.notifications}/$notificationId/read',
      auth: true,
    );
  }

  Future<void> deleteNotification(String notificationId) async {
    await _api.delete(
      '${ApiConfig.notifications}/$notificationId',
      auth: true,
    );
  }

  List _extractList(dynamic response) {
    if (response is List) return response;

    if (response is Map && response['data'] is List) {
      return response['data'];
    }

    if (response is Map && response['notifications'] is List) {
      return response['notifications'];
    }

    return [];
  }
}