class Review {
  final String id;
  final String userName;
  final double rating;
  final String comment;

  Review({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    String name = 'Usuário';

    if (json['usuario'] is Map) {
      name = json['usuario']['nome']?.toString() ?? 'Usuário';
    } else if (json['user'] is Map) {
      name = json['user']['nome']?.toString() ??
          json['user']['name']?.toString() ??
          'Usuário';
    }

    return Review(
      id: json['id']?.toString() ?? '',
      userName: json['usuario_nome']?.toString() ?? name,
      rating: double.tryParse(
            json['nota']?.toString() ??
                json['rating']?.toString() ??
                json['avaliacao']?.toString() ??
                '0',
          ) ??
          0,
      comment: json['comentario']?.toString() ??
          json['comment']?.toString() ??
          json['texto']?.toString() ??
          '',
    );
  }
}