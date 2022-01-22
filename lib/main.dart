import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fox_note_app/provider/note_provider.dart';
import 'package:fox_note_app/provider/theme_provider.dart';
import 'package:fox_note_app/screens/auth_state_screen.dart';
import 'package:provider/provider.dart';

import 'screens/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => NoteProvider(),
        child: MaterialApp(
          color: Color(0x0ff2c2b4b),
          debugShowCheckedModeBanner: false,
          title: 'Note App',
          theme: lightDark,
          home: AuthStateScreen(),
        ));
  }
}

class PasscodeScreen extends StatefulWidget {
  const PasscodeScreen({Key? key}) : super(key: key);

  @override
  _PasscodeScreenState createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
