import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fox_note_app/provider/auth_provider.dart';
import 'package:fox_note_app/screens/bottom_navigation_screen.dart';
import 'package:fox_note_app/screens/landing_screen.dart';
import 'package:fox_note_app/screens/note/note_list_screen.dart';

class AuthStateScreen extends StatelessWidget {
  const AuthStateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder<User?>(
      stream: AuthProvider.authCurrentState,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LandingScreen();
        } else if (snapshot.hasData) {
          return BottomNavigationScreen();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    )));
  }
}
