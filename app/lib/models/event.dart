class Event {
  final String id;
  final String title;
  final String description;
  final String location;
  final String date;
  final String time;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.time,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    String locationText = '';

    if (json['local'] is Map) {
      final local = json['local'] as Map<String, dynamic>;

      final localName = local['nome']?.toString() ?? '';
      final address = local['endereco']?.toString() ?? '';

      if (localName.isNotEmpty && address.isNotEmpty) {
        locationText = '$localName - $address';
      } else {
        locationText = localName.isNotEmpty ? localName : address;
      }
    } else {
      locationText = json['local']?.toString() ??
          json['endereco']?.toString() ??
          '';
    }

    return Event(
      id: json['id']?.toString() ?? '',
      title: json['titulo']?.toString() ??
          json['nome']?.toString() ??
          'Evento sem título',
      description: json['descricao']?.toString() ?? '',
      location: locationText,
      date: json['dataEvento']?.toString() ??
          json['data_evento']?.toString() ??
          json['dataInicio']?.toString() ??
          json['data_inicio']?.toString() ??
          json['data']?.toString() ??
          '',
      time: json['horario']?.toString() ?? '',
    );
  }
}