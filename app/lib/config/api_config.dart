class ApiConfig {
  static const String serverUrl = 'http://10.0.2.2:3000';
  static const String baseUrl = '$serverUrl/api';

  static const String auth = '$baseUrl/auth';
  static const String users = '$baseUrl/users';
  static const String places = '$baseUrl/places';
  static const String categories = '$baseUrl/categories';
  static const String events = '$baseUrl/events';
  static const String favorites = '$baseUrl/favorites';
  static const String itineraries = '$baseUrl/itineraries';
  static const String notifications = '$baseUrl/notifications';
  static const String reviews = '$baseUrl/reviews';
}