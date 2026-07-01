class User {
  final String id;
  final String name;
  final String email;
  final String type;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      name: json['nome']?.toString() ??
          json['name']?.toString() ??
          '',
      email: json['email']?.toString() ?? '',
      type: json['tipo']?.toString() ??
          json['type']?.toString() ??
          'usuario',
    );
  }
}