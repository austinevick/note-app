class User {
  final String? fullname;
  final String? email;
  final String? password;
  User({
    this.fullname,
    this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullname: map['fullname'],
      email: map['email'],
      password: map['password'],
    );
  }
}
