import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String? id;
  final String? title;
  final String? content;
  final Timestamp? dateCreated;
  final String? category;
  final String? userId;
  final bool? isImportant;

  Note(
      {this.userId,
      this.content,
      this.category,
      this.isImportant,
      this.dateCreated,
      this.id,
      this.title});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        id: map['id'],
        title: map['title'],
        isImportant: map['isImportant'],
        userId: map['userId'],
        category: map['category'],
        content: map['content'],
        dateCreated: map['dateCreated']);
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'id': this.id,
      'title': this.title,
      'content': this.content,
      'userId': this.userId,
      'category': this.category,
      'isImportant': this.isImportant,
      'dateCreated': this.dateCreated
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Note &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.dateCreated == dateCreated &&
        other.category == category &&
        other.isImportant == isImportant;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        dateCreated.hashCode ^
        category.hashCode ^
        isImportant.hashCode;
  }
}
