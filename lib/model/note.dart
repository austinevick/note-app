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
}
