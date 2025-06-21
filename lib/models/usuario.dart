class Usuario {
  final String name;
  final String email;
  final String password;

  Usuario({
    required this.name,
    required this.email,
    required this.password,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
} 