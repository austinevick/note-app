import 'package:flutter/material.dart';
import 'package:fox_note_app/screens/bottom_navigation_screen.dart';
import 'package:fox_note_app/screens/note_list_screen.dart';
import 'package:provider/provider.dart';

import 'provider/note_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: MaterialApp(
        color: Color(0x0ff2c2b4b),
        debugShowCheckedModeBanner: false,
        title: 'Note App',
        theme: ThemeData(
            appBarTheme: AppBarTheme(backgroundColor: const Color(0xff0f044c)),
            scaffoldBackgroundColor: const Color(0xff0f044c),
            primaryColor: const Color(0xff0f044c)),
        home: BottomNavigationScreen(),
      ),
    );
  }
}
