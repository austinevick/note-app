import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fox_note_app/components/custom_button.dart';
import 'package:fox_note_app/provider/auth_provider.dart';
import 'package:fox_note_app/screens/authentication/signin_screen.dart';
import 'package:fox_note_app/screens/authentication/signup_screen.dart';
import 'package:fox_note_app/screens/bottom_navigation_screen.dart';
import 'package:fox_note_app/screens/note/note_list_screen.dart';
import 'package:fox_note_app/utils/constant.dart';

import '../main.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool isLoading = false;
  SnackBar snackBar = SnackBar(content: const Text('Something went wrong'));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            'Let\'s organize your notes in one place',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: formColor, fontSize: 26, fontWeight: FontWeight.w800),
          ),
          const Spacer(),
          CustomButton(
            onPressed: () {
              pushNavigation(context, const SignInScreen());
            },
            text: 'Sign in',
          ),
          CustomButton(
            onPressed: () {
              pushNavigation(context, const SignUpScreen());
            },
            text: 'Create Account',
          ),
          CustomButton(
            onPressed: () async {
              try {
                setState(() => isLoading = true);

                final result = await AuthProvider.signInAnonymously();
                if (result != null)
                  pushNavigation(context, const BottomNavigationScreen());
                setState(() => isLoading = false);
              } on FirebaseAuthException {
                setState(() => isLoading = false);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            text: 'Continue Anonymously',
          )
        ],
      ),
    ));
  }
}
