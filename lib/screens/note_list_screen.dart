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
          backgroundColor: Color(0xff2c2b4b),
          body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      floating: true,
                      forceElevated: innerBoxIsScrolled,
                      centerTitle: true,
                      actions: [
                        IconButton(
                            icon: Icon(Icons.search, size: 27),
                            onPressed: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SearchScreen(),
                                ))),
                        IconButton(
                            icon: Icon(Icons.more_vert, size: 27),
                            onPressed: () => NoteFilterBottomSheet
                                .buildNoteFilterBottomSheet(
                                    context: context, provider: provider)),
                      ],
                      title: Text(
                        provider.setTitle(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
              body: provider.noteList.isEmpty
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
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18)),
                        ],
                      ),
                    )
                  : Center(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              controller: widget.scrollController,
                              physics: BouncingScrollPhysics(),
                              itemCount: NoteProvider.selectedIndex == 0
                                  ? provider.noteList.length
                                  : provider.favouriteNoteList.length,
                              itemBuilder: (ctx, i) {
                                final note = provider.noteList[i];

                                return NoteList(note: note, provider: provider);
                              })),
                    )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0x0fffd6a02),
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
