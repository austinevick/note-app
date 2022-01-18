import 'package:flutter/material.dart';

class EmptyNoteBody extends StatelessWidget {
  const EmptyNoteBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/empty_note_icon.png',
            height: 150,
            color: Colors.grey,
          ),
          Text('No note added',
              style: TextStyle(color: Colors.grey, fontSize: 18)),
        ],
      ),
    );
  }
}
