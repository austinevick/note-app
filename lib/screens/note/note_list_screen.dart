import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fox_note_app/components/category_cards.dart';
import 'package:fox_note_app/components/empty_note_body.dart';
import 'package:fox_note_app/model/note.dart';
import 'package:fox_note_app/provider/auth_provider.dart';
import 'package:fox_note_app/provider/note_provider.dart';
import 'package:fox_note_app/screens/authentication/signin_screen.dart';
import 'package:fox_note_app/screens/note/custom_note_search_delegate.dart';
import 'package:fox_note_app/screens/note/note_list_from_snapshot.dart';
import 'package:fox_note_app/screens/settings_screen.dart';
import 'package:fox_note_app/utils/constant.dart';

import 'new_note_screen.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final controller = PageController(viewportFraction: 0.8);

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    floating: true,
                    centerTitle: true,
                    actions: [
                      IconButton(
                          icon: Icon(
                            Icons.search,
                            size: 29,
                          ),
                          onPressed: () => showSearch(
                              context: context,
                              delegate: CustomNoteSearchDelegate())),
                      IconButton(
                          icon: Icon(
                            Icons.more_vert,
                            size: 29,
                          ),
                          onPressed: () => showModalBottomSheet(
                              shape: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20))),
                              context: context,
                              builder: (ctx) => SettingsScreen())),
                    ],
                    title: Text(
                      'Note',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                ],
            body: Column(
              children: [
                // CategoryCards(
                //   onPageChanged: (value) =>
                //       setState(() => selectedIndex = value),
                //   selectedIndex: selectedIndex,
                //   controller: controller,
                // ),
                Expanded(
                  flex: 4,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffeeeeee),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: NoteProvider.getNoteStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return snapshot.data!.docs.isEmpty
                              ? EmptyNoteBody()
                              : NoteListFromSnapshot(snapshot: snapshot);
                        },
                      )),
                ),
              ],
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xff0f044c),
            onPressed: () => pushNavigation(context, const NewNoteScreen()),
            child: Icon(Icons.add, size: 29)),
      ),
    );
  }
}
