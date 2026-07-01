import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_config.dart';
import '../models/itinerary.dart';
import '../models/place.dart';
import 'api_service.dart';

class ItineraryService {
  final ApiService _api = ApiService();

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('userId');
    if (value == null) return null;
    return int.tryParse(value);
  }

  Future<List<Itinerary>> getMyItineraries() async {
    final userId = await _getUserId();

    if (userId == null) {
      throw Exception('Usuário não identificado.');
    }

    final response = await _api.get(
      '${ApiConfig.itineraries}/user/$userId',
      auth: true,
    );

    final List data = _extractList(response);

    return data
        .map((item) => Itinerary.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Itinerary> getItineraryById(String id) async {
    final response = await _api.get(
      '${ApiConfig.itineraries}/$id',
      auth: true,
    );

    final data = response is Map && response['data'] != null
        ? response['data']
        : response;

    return Itinerary.fromJson(data as Map<String, dynamic>);
  }

  Future<List<Place>> getPlacesByItinerary(String id) async {
    final response = await _api.get(
      '${ApiConfig.itineraries}/$id/places',
      auth: true,
    );

    final List data = _extractList(response);

    return data.map((item) {
      final map = item as Map<String, dynamic>;
      final placeData = map['local'] ?? map['place'] ?? map;

      return Place.fromJson(placeData as Map<String, dynamic>);
    }).toList();
  }

  Future<Itinerary> createItinerary({
    required String name,
    String description = '',
  }) async {
    final userId = await _getUserId();

    if (userId == null) {
      throw Exception('Usuário não identificado.');
    }

    final response = await _api.post(
      ApiConfig.itineraries,
      auth: true,
      body: {
        'usuario_id': userId,
        'nome': name,
        'descricao': description,
      },
    );

    final data = response is Map && response['data'] != null
        ? response['data']
        : response;

    if (data is! Map<String, dynamic>) {
      throw Exception('Formato inválido ao criar roteiro.');
    }

    return Itinerary.fromJson(data);
  }

  Future<void> deleteItinerary(String id) async {
    await _api.delete(
      '${ApiConfig.itineraries}/$id',
      auth: true,
    );
  }

  Future<void> addPlaceToItinerary({
    required String itineraryId,
    required String placeId,
    required int order,
  }) async {
    await _api.post(
      '${ApiConfig.itineraries}/places',
      auth: true,
      body: {
        'roteiro_id': int.tryParse(itineraryId) ?? itineraryId,
        'local_id': int.tryParse(placeId) ?? placeId,
        'ordem': order,
      },
    );
  }

  Future<void> removePlaceFromItinerary({
  required String itineraryId,
  required String placeId,
}) async {
  await _api.delete(
    '${ApiConfig.itineraries}/$itineraryId/places/$placeId',
    auth: true,
  );
}

  Future<void> updatePlaceOrder({
    required String itineraryId,
    required String placeId,
    required int order,
  }) async {
    await _api.patch(
      '${ApiConfig.itineraries}/places/order',
      auth: true,
      body: {
        'roteiro_id': int.tryParse(itineraryId) ?? itineraryId,
        'local_id': int.tryParse(placeId) ?? placeId,
        'ordem': order,
      },
    );
  }

  Future<void> updatePlacesOrder({
    required String itineraryId,
    required List<Place> places,
  }) async {
    for (int index = 0; index < places.length; index++) {
      await updatePlaceOrder(
        itineraryId: itineraryId,
        placeId: places[index].id,
        order: index + 1,
      );
    }
  }

  Future<void> createItineraryWithPlaces({
    required String name,
    String description = '',
    required List<Place> places,
  }) async {
    final itinerary = await createItinerary(
      name: name,
      description: description,
    );

    for (int index = 0; index < places.length; index++) {
      await addPlaceToItinerary(
        itineraryId: itinerary.id,
        placeId: places[index].id,
        order: index + 1,
      );
    }
  }

  List _extractList(dynamic response) {
    if (response is List) return response;

    if (response is Map && response['data'] is List) {
      return response['data'];
    }

    if (response is Map && response['itineraries'] is List) {
      return response['itineraries'];
    }

    if (response is Map && response['roteiros'] is List) {
      return response['roteiros'];
    }

    if (response is Map && response['places'] is List) {
      return response['places'];
    }

    if (response is Map && response['locais'] is List) {
      return response['locais'];
    }

    return [];
  }
}