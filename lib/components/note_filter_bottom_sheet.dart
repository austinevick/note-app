import 'package:flutter/material.dart';
import 'package:fox_note_app/provider/note_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NoteFilterBottomSheet {
  static buildNoteFilterBottomSheet(
      {BuildContext context, NoteProvider provider}) {
    return showBarModalBottomSheet(
        shape: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: context,
        builder: (ctx) => Container(
              height: 145,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Filter',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[300]),
                              top: BorderSide(color: Colors.grey[300]))),
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            provider.setIndexToZero();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'All',
                            style: TextStyle(
                                color: NoteProvider.selectedIndex == 0
                                    ? Colors.green
                                    : Colors.grey,
                                fontSize: 18,
                                fontWeight: NoteProvider.selectedIndex == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[300]),
                              top: BorderSide(color: Colors.grey[300]))),
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            provider.setIndexToOne();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Favourites',
                            style: TextStyle(
                                color: NoteProvider.selectedIndex == 1
                                    ? Colors.green
                                    : Colors.grey,
                                fontSize: 18,
                                fontWeight: NoteProvider.selectedIndex == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          )),
                    ),
                  ),
                ],
              ),
            ));
  }
}
