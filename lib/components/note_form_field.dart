import 'package:flutter/material.dart';
import 'package:fox_note_app/model/note.dart';

class NoteFormField extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final Color selectedIndex;
  final Note note;

  const NoteFormField(
      {Key key,
      this.titleController,
      this.contentController,
      this.note,
      this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = selectedIndex != Colors.white ? Colors.white : Colors.black;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              autofocus: note == null ? true : false,
              cursorWidth: 1,
              controller: titleController,
              textCapitalization: TextCapitalization.sentences,
              cursorColor: color,
              style: TextStyle(
                  fontSize: 18, color: color, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                  border: InputBorder.none,
                  hintText: 'Title'),
            ),
            Divider(color: Colors.grey),
            TextField(
              cursorWidth: 1,
              textCapitalization: TextCapitalization.sentences,
              cursorHeight: 26,
              cursorColor: color,
              style: TextStyle(fontSize: 19, color: color),
              controller: contentController,
              maxLines: null,
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                  border: InputBorder.none,
                  hintText: 'Type your note here'),
            ),
          ],
        ),
      ),
    );
  }
}
