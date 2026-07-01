import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_config.dart';
import '../models/place.dart';
import 'api_service.dart';

class FavoriteService {
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

  Future<List<Place>> getFavorites() async {
  final response = await _api.get(
    '${ApiConfig.favorites}/me',
    auth: true,
  );

  final List data = _extractList(response);

  return data.map((item) {
    final map = item as Map<String, dynamic>;

    final placeData = map['local'] ??
        map['place'] ??
        map['lugar'] ??
        map;

    return Place.fromJson(placeData as Map<String, dynamic>);
  }).toList();
}

  Future<void> addFavorite(String placeId) async {
  await _api.post(
    ApiConfig.favorites,
    auth: true,
    body: {
      'local_id': int.parse(placeId),
    },
  );
}

  Future<void> removeFavorite(String placeId) async {
  await _api.delete(
    '${ApiConfig.favorites}/me/place/$placeId',
    auth: true,
  );
}

  List _extractList(dynamic response) {
    if (response is List) return response;

    if (response is Map && response['data'] is List) {
      return response['data'];
    }

    if (response is Map && response['favorites'] is List) {
      return response['favorites'];
    }

    return [];
  }
}