import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fox_note_app/components/note_filter_bottom_sheet.dart';
import 'package:fox_note_app/components/note_list.dart';
import 'package:fox_note_app/provider/note_provider.dart';
import 'package:fox_note_app/screens/search_screen.dart';
import 'package:fox_note_app/utils/note_prefs.dart';
import 'package:provider/provider.dart';

import 'new_note_screen.dart';

class NoteListScreen extends StatefulWidget {
  final ScrollController? scrollController;

  const NoteListScreen({Key? key, this.scrollController}) : super(key: key);

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      NotePreferences.loadNoteListView();
    });

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
                      forceElevated: innerBoxIsScrolled,
                      centerTitle: true,
                      actions: [
                        IconButton(
                            icon: Icon(
                              Icons.search,
                              size: 29,
                            ),
                            onPressed: () => showSearch(
                                context: context,
                                delegate: CustomSearchDelegate())),
                        IconButton(
                            icon: Icon(Icons.more_vert, size: 29),
                            onPressed: () => NoteFilterBottomSheet
                                .buildNoteFilterBottomSheet(
                                    context: context, provider: provider)),
                      ],
                      title: Text(
                        provider.setTitle(),
                        style: TextStyle(color: Colors.white, fontSize: 28),
                      ),
                    ),
                  ],
              body: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffeeeeee),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: provider.noteList.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/empty_note_icon.png',
                                height: 150,
                                color: Colors.grey,
                              ),
                              Text('No note added',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18)),
                            ],
                          ),
                        )
                      : Center(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                  controller: widget.scrollController,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: provider.noteList
                                      .where((element) =>
                                          element.dateCreated == DateTime.now())
                                      .length,
                                  itemBuilder: (ctx, i) {
                                    final note = provider.noteList[i];

                                    return NoteList(
                                        note: note, provider: provider);
                                  })),
                        ))),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
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
