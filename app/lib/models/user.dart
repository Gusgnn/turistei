class AppUser {
  final String id;
  final String name;
  final String email;
  final List<String> interests;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.interests = const [],
  });
}