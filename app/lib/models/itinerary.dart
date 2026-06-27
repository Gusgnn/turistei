class Itinerary {
  final String id;
  final String title;
  final String description;
  final List<String> placeIds;

  Itinerary({
    required this.id,
    required this.title,
    required this.description,
    this.placeIds = const [],
  });
}