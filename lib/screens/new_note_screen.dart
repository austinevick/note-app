import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:fox_note_app/components/note_form_field.dart';
import 'package:fox_note_app/model/note.dart';
import 'package:fox_note_app/provider/note_provider.dart';
import 'package:fox_note_app/utils/random_colors.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class NewNoteScreen extends StatefulWidget {
  final Note? note;
  const NewNoteScreen({Key? key, this.note}) : super(key: key);
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final controller = ScrollController();

  String selectedCategory = 'Personal';
  var titleController = new TextEditingController();
  var contentController = new TextEditingController();
  bool isImportant = false;
  FocusNode focusNode = FocusNode();
  Random random = new Random();
  int index = 0;
  bool isExpanded = false;
  void changeIndex() {
    setState(() => index = random.nextInt(colors.length));
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    if (widget.note != null) {
      contentController.text = widget.note!.content!;
      titleController.text = widget.note!.title!;
      isImportant = widget.note!.isImportant!;
    }
  }

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
            body: Column(
              children: [
                buildAppBar(provider),
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: !isExpanded
                        ? const SizedBox.shrink()
                        : Container(
                            height: 45,
                            width: double.infinity,
                            child: ListView(
                              controller: controller,
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                category.length,
                                (i) => GestureDetector(
                                  onTap: () {
                                    setState(
                                        () => selectedCategory = category[i]);
                                    print(selectedCategory);
                                  },
                                  child: AnimatedContainer(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: selectedCategory == category[i]
                                            ? Colors.blue.shade200
                                                .withOpacity(0.2)
                                            : Colors.white,
                                        border: Border.all(
                                            color:
                                                selectedCategory == category[i]
                                                    ? const Color(0xff0795ff)
                                                    : Colors.grey),
                                      ),
                                      height: 45,
                                      width: 85,
                                      child: Text(
                                        category[i],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color:
                                                selectedCategory == category[i]
                                                    ? const Color(0xff0795ff)
                                                    : Colors.grey),
                                      ),
                                      duration:
                                          const Duration(milliseconds: 400)),
                                ),
                              ),
                            ),
                          )),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: NoteFormField(
                        titleController: titleController,
                        contentController: contentController,
                        note: widget.note),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String shareNote() {
    if (widget.note == null)
      return "${titleController.text}\n${contentController.text}";
    return "${widget.note!.title}\n${widget.note!.content}";
  }

  void submit(NoteProvider provider) {
    Navigator.of(context).pop();
    if (titleController.text.isEmpty && contentController.text.isEmpty)
      Fluttertoast.showToast(msg: 'Empty notes are discarded');
    final note = new Note(
        title: titleController.text,
        content: contentController.text,
        category: selectedCategory,
        isImportant: isImportant,
        dateCreated: DateTime.now());
    if (widget.note != null) {
      note.id = widget.note!.id;
      provider.updateNote(note);
    } else {
      provider.createNote(note);
    }
    provider.showAllNotes();
  }

  Widget buildAppBar(NoteProvider provider) {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.keyboard_backspace, color: Colors.white, size: 28),
          onPressed: () => submit(provider)),
      title: Text(widget.note == null ? 'Add note' : 'Modify note',
          style: TextStyle(color: Colors.white)),
      actions: [
        IconButton(
            icon: isImportant
                ? Icon(
                    Icons.star,
                    color: Color(0x0fffd6a02),
                  )
                : Icon(Icons.star_border),
            onPressed: () => setState(() => isImportant = !isImportant)),
        buildShareButton(),
        IconButton(
            icon:
                Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 28),
            onPressed: () => setState(() => isExpanded = !isExpanded)),
      ],
    );
  }

  Widget buildShareButton() {
    return IconButton(
        icon: Icon(
          Icons.share,
        ),
        onPressed: () async {
          await Share.share("${shareNote()}");
        });
  }
}
