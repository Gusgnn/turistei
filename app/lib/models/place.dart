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

  factory Place.fromJson(Map<String, dynamic> json) {
    String categoryName = '';

    if (json['categoria'] is Map) {
      categoryName = json['categoria']['nome']?.toString() ?? '';
    } else if (json['categoria'] is String) {
      categoryName = json['categoria'];
    } else if (json['categoria_nome'] != null) {
      categoryName = json['categoria_nome'].toString();
    }

    return Place(
      id: json['id']?.toString() ?? '',
      title: json['nome']?.toString() ?? '',
      category: categoryName,
      description: json['descricao']?.toString() ?? '',
      distance: json['distancia']?.toString() ?? '',
      rating: double.tryParse(
            json['avaliacao_media']?.toString() ??
                json['rating']?.toString() ??
                '0',
          ) ??
          0,
      latitude: double.tryParse(json['latitude']?.toString() ?? '0') ?? 0,
      longitude: double.tryParse(json['longitude']?.toString() ?? '0') ?? 0,
      tags: json['tags'] is List
          ? List<String>.from(json['tags'].map((tag) => tag.toString()))
          : [],
    );
  }
}