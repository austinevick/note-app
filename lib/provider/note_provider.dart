import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fox_note_app/database/note_db.dart';
import 'package:fox_note_app/model/note.dart';
import 'package:fox_note_app/utils/note_prefs.dart';

class NoteProvider with ChangeNotifier {
  List<Note> noteList = [];
  NoteDatabaseHelper databaseHelper = new NoteDatabaseHelper();
  static int selectedIndex = 0;

  bool shouldShowTitle = true;
  onNoteTitleChange(bool shouldShowTitle) {
    this.shouldShowTitle = shouldShowTitle;
    notifyListeners();
  }

  void setIndexToZero() {
    selectedIndex = 0;
    NotePreferences.saveNoteListViewToPref(selectedIndex);
    notifyListeners();
  }

  setTitle() => selectedIndex == 0 ? 'All Notes' : 'Favourite';
  void setIndexToOne() {
    selectedIndex = 1;
    NotePreferences.saveNoteListViewToPref(selectedIndex);
    notifyListeners();
  }

  List<Note> get favouriteNoteList =>
      noteList.where((note) => note.isImportant == true).toList();

  void createNote(Note note) async {
    if (note.title.isEmpty && note.content.isEmpty) return;
    await databaseHelper.saveNote(note);
    Fluttertoast.showToast(msg: 'Note added');
    notifyListeners();
  }

  Future<List<Note>> showAllNotes() async {
    Future<List<Note>> note = databaseHelper.getNotes();
    await note.then((note) {
      noteList = note;
      notifyListeners();
    });
    return note;
  }

  void restoreNote(Note note) {
    createNote(note);
    showAllNotes();
    notifyListeners();
  }

  void updateNote(Note note) {
    databaseHelper.updateNote(note);
    showAllNotes();
    notifyListeners();
  }

  void deleteNote(int id) {
    databaseHelper.deleteNote(id);
    showAllNotes();
    notifyListeners();
  }
}
