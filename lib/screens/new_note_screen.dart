import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:fox_note_app/components/note_form_field.dart';
import 'package:fox_note_app/model/note.dart';
import 'package:fox_note_app/provider/note_provider.dart';
import 'package:fox_note_app/utils/note_prefs.dart';
import 'package:fox_note_app/utils/random_colors.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class NewNoteScreen extends StatefulWidget {
  final Note note;
  const NewNoteScreen({Key key, this.note}) : super(key: key);
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  var titleController = new TextEditingController();
  var contentController = new TextEditingController();
  bool isImportant = false;
  FocusNode focusNode = FocusNode();
  Random random = new Random();
  int index = 0;

  void changeIndex() {
    setState(() => index = random.nextInt(colors.length));
  }

  @override
  void initState() {
    NotePreferences.loadNoteBgColor();
    init();
    super.initState();
  }

  void init() {
    if (widget.note != null) {
      contentController.text = widget.note.content;
      titleController.text = widget.note.title;
      isImportant = widget.note.isImportant;
    }
  }

  buildBackgroundColor(BuildContext context) => showDialog(
      context: context,
      builder: (ctx) => Dialog(
            child: Container(
              height: 220,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Background Color',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  Divider(),
                  Expanded(
                    child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        children: List.generate(
                            colors.length,
                            (i) => MaterialButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setState(() =>
                                        NotePreferences.selectedColor = i);
                                    NotePreferences.saveNoteBgColorToPref(
                                        NotePreferences.selectedColor);
                                    Navigator.of(context).pop();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(8),
                                      elevation: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: colors[i],
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                    ),
                                  ),
                                ))),
                  ),
                ],
              ),
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, provider, child) => SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            submit(provider);
            return true;
          },
          child: Scaffold(
              appBar: buildAppBar(provider),
              backgroundColor: colors[NotePreferences.selectedColor],
              body: NoteFormField(
                  selectedIndex: colors[NotePreferences.selectedColor],
                  titleController: titleController,
                  contentController: contentController,
                  note: widget.note)),
        ),
      ),
    );
  }

  String shareNote() {
    if (widget.note == null)
      return "${titleController.text}\n${contentController.text}";
    return "${widget.note.title}\n${widget.note.content}";
  }

  void submit(NoteProvider provider) {
    Navigator.of(context).pop();
    if (titleController.text.isEmpty && contentController.text.isEmpty)
      Fluttertoast.showToast(msg: 'Empty notes are discarded');
    final note = new Note(
        title: titleController.text,
        content: contentController.text,
        isImportant: isImportant,
        dateCreated: DateTime.now());
    if (widget.note != null) {
      note.id = widget.note.id;
      provider.updateNote(note);
    } else {
      provider.createNote(note);
    }
    provider.showAllNotes();
  }

  Widget buildAppBar(NoteProvider provider) {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.keyboard_backspace, color: Colors.black, size: 28),
          onPressed: () => submit(provider)),
      title: Text(widget.note == null ? 'Add note' : 'Modify note',
          style: Theme.of(context).textTheme.headline6),
      actions: [
        IconButton(
            icon: isImportant
                ? Icon(
                    Icons.star,
                    color: Color(0x0fffd6a02),
                  )
                : Icon(Icons.star_border),
            onPressed: () => setState(() => isImportant = !isImportant)),
        IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () {
              buildBackgroundColor(context);
            }),
        buildShareButton()
      ],
    );
  }

  Widget buildShareButton() {
    return IconButton(
        icon: Icon(
          Icons.share,
          color: Colors.black,
        ),
        onPressed: () async {
          await Share.share("${shareNote()}");
        });
  }
}
