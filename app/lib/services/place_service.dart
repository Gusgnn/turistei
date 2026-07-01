import '../config/api_config.dart';
import '../models/place.dart';
import 'api_service.dart';

class PlaceService {
  final ApiService _api = ApiService();

  Future<List<Place>> getPlaces() async {
    final response = await _api.get(ApiConfig.places);

    final List data = _extractList(response);

    return data
        .map((item) => Place.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Place> getPlaceById(String id) async {
  final response = await _api.get('${ApiConfig.places}/$id');

  dynamic data;

  if (response is Map && response['data'] != null) {
    data = response['data'];
  } else {
    data = response;
  }

  if (data is List && data.isNotEmpty) {
    data = data.first;
  }

  if (data is! Map<String, dynamic>) {
    throw Exception('Formato inválido ao buscar local.');
  }

  return Place.fromJson(data);
}

  Future<List<Place>> searchPlaces(String query) async {
    final response = await _api.get('${ApiConfig.places}/search?q=$query');

    final List data = _extractList(response);

    return data
        .map((item) => Place.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<Place>> getPlacesByCategory(String categoryId) async {
    final response = await _api.get(
      '${ApiConfig.places}/category/$categoryId',
    );

    final List data = _extractList(response);

    return data
        .map((item) => Place.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<Place>> getPopularPlaces() async {
    final response = await _api.get('${ApiConfig.places}/popular');

    final List data = _extractList(response);

    return data
        .map((item) => Place.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<Place>> getNearbyPlaces({
  required double lat,
  required double lng,
}) async {
  final response = await _api.get(
    '${ApiConfig.places}/nearby?lat=$lat&lng=$lng',
  );

  final List data = _extractList(response);

  return data
      .map((item) => Place.fromJson(item as Map<String, dynamic>))
      .toList();
}

  List _extractList(dynamic response) {
    if (response is List) {
      return response;
    }

    if (response is Map && response['data'] is List) {
      return response['data'];
    }

    if (response is Map && response['places'] is List) {
      return response['places'];
    }

    return [];
  }
}