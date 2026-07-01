import '../config/api_config.dart';
import '../models/event.dart';
import 'api_service.dart';

class EventService {
  final ApiService _api = ApiService();

  Future<List<Event>> getEvents() async {
    final response = await _api.get(ApiConfig.events);

    final List data = _extractList(response);

    return data
        .map((item) => Event.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  List _extractList(dynamic response) {
    if (response is List) return response;

    if (response is Map && response['data'] is List) {
      return response['data'];
    }

    if (response is Map && response['events'] is List) {
      return response['events'];
    }

    return [];
  }
}