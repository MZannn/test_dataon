class RegisterModel {
  final int? id;
  final String email;
  final String password;

  RegisterModel({
    this.id,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      id: map['id'],
      email: map['email'],
      password: map['password'],
    );
  }
}
