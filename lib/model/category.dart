import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fox_note_app/model/note.dart';

class Category {
  final List<Note>? note;
  final String? name;
  Category({
    this.note,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'note': note?.map((x) => x.toSnapshot()).toList(),
      'name': name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      note: map['note'] != null
          ? List<Note>.from(map['note']?.map((x) => Note.fromMap(x)))
          : null,
      name: map['name'],
    );
  }
}

List<String> category = [
  'Personal',
  'Work',
  'Business',
  'Travel',
  'Sermon',
  'Sport'
];
