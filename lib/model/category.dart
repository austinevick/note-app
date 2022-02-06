import 'package:fox_note_app/model/note.dart';

class Category {
  final Note? note;
  final String? name;
  Category({
    this.note,
    this.name,
  });

  Category copyWith({
    Note? note,
    String? name,
  }) {
    return Category(
      note: note ?? this.note,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'note': note?.toSnapshot(),
      'name': name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      note: map['note'] != null ? Note.fromMap(map['note']) : null,
      name: map['name'],
    );
  }
}
