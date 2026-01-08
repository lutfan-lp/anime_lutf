class User {
  final String id;
  final String userName;
  final String email;
  final String password;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['user_name'],
      email: json['email'],
      password: json['password'],
    );
  }
}
