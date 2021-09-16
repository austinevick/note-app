import 'package:flutter/material.dart';
import 'package:fox_note_app/model/note.dart';
import 'package:fox_note_app/provider/note_provider.dart';
import 'package:share/share.dart';

class SelectedNoteBottomSheet extends StatelessWidget {
  final NoteProvider provider;
  final Note note;

  SelectedNoteBottomSheet({Key key, this.provider, this.note})
      : super(key: key);
  final style = TextStyle(color: Colors.black, fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () async {
              await Share.share("${note.title}\n${note.content}");
            },
            leading: Icon(Icons.share),
            title: Text('Share Note', style: style),
          ),
          ListTile(
              onTap: () {
                Navigator.of(context).pop();
                provider.deleteNote(note.id);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(
                      textColor: Colors.white,
                      label: 'UNDO',
                      onPressed: () {
                        provider.restoreNote(note);
                      }),
                  content: Text('Task successfully deleted',
                      style: TextStyle(color: Colors.white)),
                ));
              },
              leading: Icon(
                Icons.delete_outline,
                size: 28,
              ),
              title: Text(
                'Delete Note',
                style: style,
              )),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Color(0x0ff2c2b4b),
                    borderRadius: BorderRadius.circular(8)),
                width: double.infinity,
                child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 18)))),
          ),
        ],
      ),
    );
  }
}
