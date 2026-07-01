class Category {
  final String id;
  final String name;
  final String? icon;

  Category({
    required this.id,
    required this.name,
    this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id']?.toString() ?? '',
      name: json['nome']?.toString() ?? '',
      icon: json['icone']?.toString(),
    );
  }
}