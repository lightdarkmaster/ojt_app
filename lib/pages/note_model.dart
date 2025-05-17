class Note {
  final int? id;
  final String title;
  final String body;
  final String mood;

  Note({
    this.id,
    required this.title,
    required this.body,
    required this.mood,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'mood': mood,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      mood: map['mood'],
    );
  }
}
