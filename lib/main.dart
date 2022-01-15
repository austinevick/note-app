import 'package:flutter/material.dart';
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
        theme: ThemeData.light().copyWith(
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                toolbarTextStyle:
                    TextTheme(headline6: TextStyle(color: Colors.black))
                        .bodyText2,
                titleTextStyle:
                    TextTheme(headline6: TextStyle(color: Colors.black))
                        .headline6)),
        home: NoteListScreen(),
      ),
    );
  }
}
