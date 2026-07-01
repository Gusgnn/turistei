import '../config/api_config.dart';
import '../models/category.dart';
import 'api_service.dart';

class CategoryService {
  final ApiService _api = ApiService();

  Future<List<Category>> getCategories() async {
    final response = await _api.get(ApiConfig.categories);

    final List data = _extractList(response);

    return data
        .map((item) => Category.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  List _extractList(dynamic response) {
    if (response is List) {
      return response;
    }

    if (response is Map && response['data'] is List) {
      return response['data'];
    }

    if (response is Map && response['categories'] is List) {
      return response['categories'];
    }

    return [];
  }
}