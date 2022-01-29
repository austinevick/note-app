import 'package:flutter/material.dart';
import 'package:fox_note_app/provider/note_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NoteFilterBottomSheet {
  static buildNoteFilterBottomSheet(
      {BuildContext? context, NoteProvider? provider}) {
    return showBarModalBottomSheet(
        shape: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: context!,
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
                              bottom: BorderSide(color: Colors.grey[300]!),
                              top: BorderSide(color: Colors.grey[300]!))),
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'All',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[300]!),
                              top: BorderSide(color: Colors.grey[300]!))),
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Favourites',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ));
  }
}
