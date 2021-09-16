import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fox_note_app/screens/note_list_screen.dart';
import 'package:fox_note_app/utils/random_colors.dart';
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
                textTheme:
                    TextTheme(headline6: TextStyle(color: Colors.black)))),
        home: NoteListScreen(),
      ),
    );
  }
}

class H extends StatefulWidget {
  const H({Key key}) : super(key: key);

  @override
  _HState createState() => _HState();
}

class _HState extends State<H> {
  int selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[selectedValue],
      body: Column(
        children: [
          SizedBox(height: 100),
          Expanded(
              child: TextField(
                  style: TextStyle(
                      color: selectedValue != 0 ? Colors.white : Colors.black),
                  decoration: InputDecoration(hintText: 'Text'))),
          Expanded(
            child: ListView(
                children: List.generate(
                    colors.length,
                    (i) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () {
                              setState(() => selectedValue = i);
                            },
                            leading: Container(
                              height: 100,
                              width: 100,
                              color: colors[i],
                            ),
                          ),
                        ))),
          ),
        ],
      ),
    );
  }
}
