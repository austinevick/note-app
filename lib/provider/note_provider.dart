import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fox_note_app/model/category.dart';
import 'package:fox_note_app/provider/auth_provider.dart';
import 'package:fox_note_app/utils/constant.dart';

class NoteProvider {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _mainCollection =
      _firestore.collection(note).doc(AuthProvider.user!.uid).collection(notes);

  static Stream<QuerySnapshot> getNoteStream() {
    return _mainCollection.snapshots();
  }

  static Future<void> addNote(Category category) async {
    if (category.note!.title!.isEmpty && category.note!.content!.isEmpty)
      return;
    await _mainCollection.doc().set(category.toMap());
  }

  static Future<void> deleteNote(String id) async {
    await _mainCollection.doc(id).delete();
  }

  static Future<void> updateNote(Category category, String id) async {
    await _mainCollection.doc(id).update(category.toMap());
  }
}
