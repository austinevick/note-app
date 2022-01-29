import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fox_note_app/components/custom_button.dart';
import 'package:fox_note_app/components/custom_textfield.dart';
import 'package:fox_note_app/provider/auth_provider.dart';
import 'package:fox_note_app/screens/authentication/signup_screen.dart';
import 'package:fox_note_app/screens/bottom_navigation_screen.dart';
import 'package:fox_note_app/screens/note/note_list_screen.dart';
import 'package:fox_note_app/utils/constant.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool obscuredText = true;

  Future signIn() async {
    try {
      setState(() => isLoading = true);
      final user = await AuthProvider.signIn(
          emailController.text, passwordController.text);

      if (user.user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => const BottomNavigationScreen()),
            (r) => false);
      }
      setState(() => isLoading = false);
      print(user.user!.email);
      return user;
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(e);
    }
  }

  SnackBar snackBar = SnackBar(content: const Text('Something went wrong'));
  Widget get getIsLoadingState => isLoading
      ? Center(child: CircularProgressIndicator(color: Colors.white))
      : Text(
          'LOGIN',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
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
                        controller: emailController,
                        validator: (value) => !value!.contains('@')
                            ? 'Enter a valid email'
                            : null,
                        labelText: 'EMAIL',
                        icon: Icons.email_outlined,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        labelText: 'PASSWORD',
                        icon: Icons.lock_outline,
                        obscureText: obscuredText,
                        validator: (value) =>
                            value!.isEmpty ? 'Enter password' : null,
                        suffixIcon: IconButton(
                            onPressed: () =>
                                setState(() => obscuredText = !obscuredText),
                            icon: !obscuredText
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {}, child: Text('Forgot Password?')),
                      ),
                      CustomButton(
                        child: getIsLoadingState,
                        onPressed: () {
                          if (formKey.currentState!.validate()) signIn();
                        },
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
              ),
            ))));
  }
}
