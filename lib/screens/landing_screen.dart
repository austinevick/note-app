import 'package:flutter/material.dart';
import 'package:fox_note_app/components/custom_button.dart';
import 'package:fox_note_app/screens/authentication/signin_screen.dart';
import 'package:fox_note_app/screens/authentication/signup_screen.dart';
import 'package:fox_note_app/screens/note/note_list_screen.dart';
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
              onPressed: () => showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Container(
                        height: 350,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                color: formColor,
                                height: 50,
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Select action to continue',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              CustomButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  pushNavigation(context, const SignInScreen());
                                },
                                text: 'Sign in',
                              ),
                              CustomButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  pushNavigation(context, const SignUpScreen());
                                },
                                text: 'Create Account',
                              ),
                              CustomButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  pushNavigation(
                                      context, const NoteListScreen());
                                },
                                text: 'Maybe Later',
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
        ],
      ),
    ));
  }
}
