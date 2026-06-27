class Place {
  final String id;
  final String title;
  final String category;
  final String description;
  final String distance;
  final double rating;
  final double latitude;
  final double longitude;
  final List<String> tags;

  Place({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.distance,
    required this.rating,
    required this.latitude,
    required this.longitude,
    this.tags = const [],
  });
}