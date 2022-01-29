import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fox_note_app/components/note_list.dart';
import 'package:fox_note_app/model/note.dart';

class NoteListFromSnapshot extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot>? snapshot;
  const NoteListFromSnapshot({Key? key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot!.data!.docs.length,
              itemBuilder: (ctx, i) {
                var noteInfo =
                    snapshot!.data!.docs[i].data() as Map<String, dynamic>;
                final note = Note.fromMap(noteInfo);
                String id = snapshot!.data!.docs[i].id;
                return NoteList(note: note, documentID: id);
              })),
    );
  }
}
