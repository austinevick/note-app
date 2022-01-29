import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fox_note_app/model/note.dart';
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
    return MaterialApp(
      color: Color(0x0ff2c2b4b),
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      theme: lightDark,
      home: AuthStateScreen(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
