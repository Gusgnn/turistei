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

    final data = response is Map && response['data'] != null
        ? response['data']
        : response;

    return Place.fromJson(data as Map<String, dynamic>);
  }

  Future<List<Place>> searchPlaces(String query) async {
    final response = await _api.get('${ApiConfig.places}?search=$query');

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