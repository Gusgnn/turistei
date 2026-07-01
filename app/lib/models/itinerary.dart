class Itinerary {
  final String id;
  final String name;
  final String description;
  final String createdAt;

  Itinerary({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    return Itinerary(
      id: json['id']?.toString() ??
          json['roteiro_id']?.toString() ??
          json['roteiroId']?.toString() ??
          '',
      name: json['nome']?.toString() ??
          json['titulo']?.toString() ??
          json['name']?.toString() ??
          'Roteiro',
      description: json['descricao']?.toString() ??
          json['description']?.toString() ??
          '',
      createdAt: json['criadoEm']?.toString() ??
          json['criado_em']?.toString() ??
          json['createdAt']?.toString() ??
          json['created_at']?.toString() ??
          '',
    );
  }
}