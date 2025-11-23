class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String token;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
  });
}
