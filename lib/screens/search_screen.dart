import 'package:flutter/material.dart';
import 'package:fox_note_app/components/search_widget.dart';
import 'package:fox_note_app/database/note_db.dart';
import 'package:fox_note_app/model/note.dart';
import 'package:fox_note_app/provider/note_provider.dart';
import 'package:provider/provider.dart';

import 'new_note_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Note> noteList = [];
  String query = '';
  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    Future<List<Note>> note = NoteDatabaseHelper().getNotes();
    note.then((note) {
      setState(() => noteList = note);
    });
    return note;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            child: Material(
                elevation: 6,
                child: SearchWidget(
                  hintText: 'Search',
                  text: query,
                  onChanged: (value) {
                    final notes = noteList.where((note) {
                      final title = note.title.toLowerCase();
                      final content = note.content.toLowerCase();
                      final searchTerms = value.toLowerCase();
                      return title.contains(searchTerms) ||
                          content.contains(searchTerms);
                    }).toList();
                    setState(() {
                      this.query = value;
                      this.noteList = notes;
                    });
                  },
                )),
            preferredSize: Size(60, 60)),
        body: query.isEmpty
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: noteList.length,
                  itemBuilder: (context, index) {
                    final note = noteList[index];
                    return Column(
                      children: [
                        ListTile(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NewNoteScreen(
                              note: note,
                            ),
                          )),
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                  color: note.isImportant
                                      ? Color(0x0fffd6a02)
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                          title: Text(note.title,
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold)),
                          subtitle: Text(note.content,
                              style: TextStyle(fontSize: 18)),
                        ),
                        Divider()
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }
}
