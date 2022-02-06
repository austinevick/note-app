import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fox_note_app/model/category.dart';
import 'package:fox_note_app/model/note.dart';
import 'package:fox_note_app/provider/category_provider.dart';
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
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: StreamBuilder<QuerySnapshot>(
              stream: CategoryProvider.getCategoryStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return buildNoteCategory(snapshot);
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              final category = Category(
                  name: 'Sport', note: Note(title: 'Hello', category: 'Sport'));
              CategoryProvider.addCategory(category);
            },
            child: Icon(Icons.add),
          )),
    );
  }

  Widget buildNoteCategory(AsyncSnapshot<QuerySnapshot>? snapshot) {
    return ListView.builder(
      itemCount: snapshot!.data!.docs.length,
      itemBuilder: (context, i) {
        var noteInfo = snapshot.data!.docs[i].data() as Map<String, dynamic>;
        final c = Category.fromMap(noteInfo);
        return Card(
          child: ListTile(
            title: Text(c.name!),
            onTap: () => showModalBottomSheet(
                context: context,
                builder: (ctx) => Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                            5,
                            (i) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(c.note!.title!),
                                )),
                      ),
                    )),
          ),
        );
      },
    );
  }
}
