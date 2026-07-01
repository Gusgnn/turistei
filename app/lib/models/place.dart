import '../config/api_config.dart';

class Place {
  final String id;
  final String title;
  final String category;
  final String description;
  final String distance;
  final double rating;
  final double latitude;
  final double longitude;
  final String imageUrl;
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
    required this.imageUrl,
    this.tags = const [],
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    String categoryName = '';

    if (json['categoria'] is Map) {
      categoryName = json['categoria']['nome']?.toString() ?? '';
    } else if (json['categoria'] is String) {
      categoryName = json['categoria'].toString();
    } else if (json['categoria_nome'] != null) {
      categoryName = json['categoria_nome'].toString();
    } else if (json['categoriaNome'] != null) {
      categoryName = json['categoriaNome'].toString();
    }

    final rawImage = json['imagem_principal']?.toString() ??
        json['imagemPrincipal']?.toString() ??
        json['imageUrl']?.toString() ??
        json['image_url']?.toString() ??
        json['imagem']?.toString() ??
        '';

    return Place(
      id: json['id']?.toString() ??
          json['local_id']?.toString() ??
          json['localId']?.toString() ??
          '',
      title: json['nome']?.toString() ??
          json['title']?.toString() ??
          json['titulo']?.toString() ??
          '',
      category: categoryName,
      description: json['descricao']?.toString() ??
          json['description']?.toString() ??
          '',
      distance: json['distancia']?.toString() ??
          json['distance']?.toString() ??
          '',
      rating: double.tryParse(
            json['avaliacaoMedia']?.toString() ??
                json['avaliacao_media']?.toString() ??
                json['rating']?.toString() ??
                '0',
          ) ??
          0,
      latitude: double.tryParse(json['latitude']?.toString() ?? '0') ?? 0,
      longitude: double.tryParse(json['longitude']?.toString() ?? '0') ?? 0,
      imageUrl: _buildImageUrl(rawImage),
      tags: json['tags'] is List
          ? List<String>.from(
              (json['tags'] as List).map((tag) => tag.toString()),
            )
          : [],
    );
  }

  static String _buildImageUrl(String image) {
    if (image.isEmpty) return '';

    if (image.startsWith('http://') || image.startsWith('https://')) {
      return image;
    }

    if (image.startsWith('/uploads/')) {
      return '${ApiConfig.serverUrl}$image';
    }

    if (image.startsWith('uploads/')) {
      return '${ApiConfig.serverUrl}/$image';
    }

    return '${ApiConfig.serverUrl}/uploads/$image';
  }
}