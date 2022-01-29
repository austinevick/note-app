import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fox_note_app/model/note.dart';
import 'package:fox_note_app/provider/auth_provider.dart';
import 'package:fox_note_app/utils/constant.dart';

class NoteProvider {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _mainCollection =
      _firestore.collection(note).doc(AuthProvider.user!.uid).collection(notes);

  static Stream<QuerySnapshot> getStream() {
    return _mainCollection.snapshots();
  }

  static Future<void> addNote(Note note) async {
    if (note.title!.isEmpty && note.content!.isEmpty) return;
    await _mainCollection.doc().set(note.toSnapshot());
  }

  static Future<void> deleteNote(String id) async {
    await _mainCollection.doc(id).delete();
  }

  static Future<void> updateNote(Note note, String id) async {
    await _mainCollection.doc(id).update(note.toSnapshot());
  }
}
