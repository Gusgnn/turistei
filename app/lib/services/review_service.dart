import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_config.dart';
import '../models/review.dart';
import 'api_service.dart';

class ReviewService {
  final ApiService _api = ApiService();

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('userId');
    if (value == null) return null;
    return int.tryParse(value);
  }

  Future<List<Review>> getReviewsByPlace(String placeId) async {
    final response = await _api.get(
      '${ApiConfig.reviews}/place/$placeId',
    );

    final List data = _extractList(response);

    return data
        .map((item) => Review.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> createReview({
    required String placeId,
    required double rating,
    required String comment,
  }) async {
    final userId = await _getUserId();

    if (userId == null) {
      throw Exception('Usuário não identificado.');
    }

    await _api.post(
      ApiConfig.reviews,
      auth: true,
      body: {
        'usuario_id': userId,
        'local_id': int.parse(placeId),
        'nota': rating,
        'comentario': comment,
      },
    );
  }

  List _extractList(dynamic response) {
    if (response is List) return response;

    if (response is Map && response['data'] is List) {
      return response['data'];
    }

    if (response is Map && response['reviews'] is List) {
      return response['reviews'];
    }

    return [];
  }
}