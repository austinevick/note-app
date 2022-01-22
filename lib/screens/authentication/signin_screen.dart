import 'package:flutter/material.dart';
import 'package:fox_note_app/components/custom_button.dart';
import 'package:fox_note_app/components/custom_textfield.dart';
import 'package:fox_note_app/screens/authentication/signup_screen.dart';
import 'package:fox_note_app/utils/constant.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(Icons.keyboard_backspace,
                              size: 30, color: formColor)),
                    ),
                    const SizedBox(height: 30),
                    Image.asset('images/ic_launcher_foreground.png',
                        height: 150),
                    Text('Welcome Back',
                        style: TextStyle(
                            color: formColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 32)),
                    Text(
                      'Sign in to continue',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 40),
                    CustomTextField(
                      labelText: 'EMAIL',
                      icon: Icons.email_outlined,
                    ),
                    CustomTextField(
                      labelText: 'PASSWORD',
                      icon: Icons.lock_outline,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: Text('Forgot Password?')),
                    ),
                    CustomButton(
                      text: 'LOGIN',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?'),
                        GestureDetector(
                            onTap: () =>
                                pushNavigation(context, const SignUpScreen()),
                            child: Text('Create a new account',
                                style: TextStyle(
                                  color: formColor,
                                )))
                      ],
                    )
                  ]),
            ))));
  }
}
