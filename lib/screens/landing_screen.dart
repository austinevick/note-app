import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fox_note_app/components/custom_button.dart';
import 'package:fox_note_app/provider/theme_provider.dart';
import 'package:fox_note_app/screens/authentication/signin_screen.dart';
import 'package:fox_note_app/utils/constant.dart';

import '../main.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
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
            text: 'Get Started',
            onPressed: () => pushNavigation(context, const SignInScreen()),
          )
        ],
      ),
    ));
  }
}
