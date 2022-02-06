import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fox_note_app/model/category.dart';
import 'package:fox_note_app/model/note.dart';
import 'package:fox_note_app/provider/note_provider.dart';
import 'package:fox_note_app/screens/note/new_note_screen.dart';
import 'package:fox_note_app/utils/constant.dart';
import 'package:intl/intl.dart';

import 'confirmation_widget.dart';

class NoteList extends StatelessWidget {
  final Category? note;
  final String? documentID;

  NoteList({Key? key, this.note, this.documentID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(documentID);
    return Entry.scale(
      delay: Duration(milliseconds: 100),
      duration: Duration(milliseconds: 200),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: () => pushNavigation(
            context,
            NewNoteScreen(note: note!.note!, id: documentID),
          ),
          child: Card(
            shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                note!.note!.title!.isEmpty
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                      color: note!.note!.isImportant!
                                          ? Color(0x0fffd6a02)
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(note!.note!.title!,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ]),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      note!.note!.title!.isNotEmpty
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(
                                    color: note!.note!.isImportant!
                                        ? Color(0x0fffd6a02)
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: note!.note!.title!.isNotEmpty
                              ? const EdgeInsets.only(left: 22)
                              : const EdgeInsets.only(left: 0),
                          child: Text(note!.note!.content!,
                              maxLines: note!.note!.title!.isEmpty ? 4 : 2,
                              style: TextStyle(fontSize: 17.5)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 37),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.yMMMd()
                            .format(note!.note!.dateCreated!.toDate()),
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            size: 26,
                          ),
                          onPressed: () {
                            ConfirmationBottomSheet.buildBottomSheet(context,
                                () {
                              Navigator.of(context).pop();
                              NoteProvider.deleteNote(documentID!);
                              Fluttertoast.showToast(msg: 'Note deleted');
                            }, 'Delete Note', 'This note will be deleted');
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
