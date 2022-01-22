List<String> category = [
  'Personal',
  'Work',
  'Business',
  'Travel',
  'Sermon',
  'Sport'
];

class Note {
  int? id;
  final String? title;
  final String? content;
  final DateTime? dateCreated;
  final String? category;
  final bool? isImportant;

  Note(
      {this.content,
      this.category,
      this.isImportant,
      this.dateCreated,
      this.id,
      this.title});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      isImportant: map['isImportant'] == 0,
      category: map['category'],
      content: map['content'],
      dateCreated: DateTime.parse(map['dateCreated'] as String),
    );
  }
  factory Note.fromSnapshot(Map<String, dynamic> map) {
    return Note(
        id: map['id'],
        title: map['title'],
        isImportant: map['isImportant'],
        category: map['category'],
        content: map['content'],
        dateCreated: map['dateCreated']);
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'id': this.id,
      'title': this.title,
      'content': this.content,
      'category': this.category,
      'isImportant': this.isImportant,
      'dateCreated': this.dateCreated
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'content': this.content,
      'category': this.category,
      'isImportant': this.isImportant! ? 0 : 1,
      'dateCreated': this.dateCreated?.toIso8601String(),
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
