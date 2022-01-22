import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fox_note_app/components/custom_button.dart';
import 'package:fox_note_app/components/custom_textfield.dart';
import 'package:fox_note_app/provider/auth_provider.dart';
import 'package:fox_note_app/screens/authentication/signin_screen.dart';
import 'package:fox_note_app/screens/note/note_list_screen.dart';
import 'package:fox_note_app/utils/constant.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future signUp() async {
    try {
      setState(() => isLoading = true);
      final user = await AuthProvider.signUp(
          nameController.text, passwordController.text);
      if (user.user != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (ctx) => const NoteListScreen()));
      }
      setState(() => isLoading = false);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(e);
    }
  }

  SnackBar snackBar = SnackBar(content: const Text('Something went wrong'));
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
                      Text('Create Account',
                          style: TextStyle(
                              color: formColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 32)),
                      Text(
                        'Create a new account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 40),
                      CustomTextField(
                        controller: nameController,
                        labelText: 'NAME',
                        icon: Icons.person_outline,
                      ),
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
                        validator: (value) =>
                            value!.isEmpty ? 'Enter password' : null,
                      ),
                      CustomButton(
                        text: 'CREATE ACCOUNT',
                        onPressed: () {
                          signUp();
                          if (isLoading)
                            showDialog(
                                context: context,
                                builder: (ctx) => Dialog(
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ));
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account?'),
                          GestureDetector(
                              onTap: () =>
                                  pushNavigation(context, const SignInScreen()),
                              child: Text('Login',
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
