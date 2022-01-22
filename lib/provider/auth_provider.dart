import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<User?> get authCurrentState => _auth.authStateChanges();
  static User? get user => _auth.currentUser;
  static Future<UserCredential> signIn(String email, String password) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<UserCredential> signUp(String email, String password) async {
    return _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  static Future signInAnonymously() async {
    await _auth.signInAnonymously();
  }

  static Future<void> logOut() async {
    await _auth.signOut();
  }
}
