import 'package:flutter/material.dart';
import 'package:fox_note_app/components/category_cards.dart';
import 'package:fox_note_app/components/empty_note_body.dart';
import 'package:fox_note_app/components/note_list.dart';
import 'package:fox_note_app/model/note.dart';
import 'package:fox_note_app/provider/note_provider.dart';
import 'package:fox_note_app/screens/note/custom_note_search_delegate.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    Provider.of<NoteProvider>(context, listen: false).showAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, provider, child) => SafeArea(
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
                      ],
                      title: Text(
                        provider.setTitle(),
                        style: TextStyle(color: Colors.white, fontSize: 28),
                      ),
                    ),
                  ],
              body: Column(
                children: [
                  CategoryCards(
                    onPageChanged: (value) =>
                        setState(() => selectedIndex = value),
                    selectedIndex: selectedIndex,
                    controller: controller,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffeeeeee),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: provider.noteList.isEmpty
                            ? EmptyNoteBody()
                            : Center(
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: provider.noteList
                                            .where((element) =>
                                                element.category ==
                                                category[selectedIndex])
                                            .length,
                                        itemBuilder: (ctx, i) {
                                          final note = provider.noteList[i];
                                          return NoteList(
                                              note: note, provider: provider);
                                        })),
                              )),
                  ),
                ],
              )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xff0f044c),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => NewNoteScreen()));
              },
              child: Icon(Icons.add, size: 29)),
        ),
      ),
    );
  }
}
