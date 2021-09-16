import 'package:fox_note_app/provider/note_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotePreferences {
  static final _keyNoteList = 'showAllNote';
  static final _keyBgColor = 'bgColor';
  static int selectedColor = 0;

  static Future saveNoteListViewToPref(int currentIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(_keyNoteList, currentIndex);
  }

  static Future loadNoteListView() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return NoteProvider.selectedIndex = prefs.getInt(_keyNoteList) ?? 0;
  }

  static Future saveNoteBgColorToPref(int currentIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(_keyBgColor, currentIndex);
  }

  static Future loadNoteBgColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return NotePreferences.selectedColor = prefs.getInt(_keyBgColor) ?? 0;
  }
}
