import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String? fullname;
  final String? email;
  final String? password;
  Users({
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

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      fullname: map['fullname'],
      email: map['email'],
      password: map['password'],
    );
  }
  static CollectionReference ref =
      FirebaseFirestore.instance.collection('users');

  static Future<void> addUsers(Users user) async {
    await ref.add(user.toMap());
  }
}
