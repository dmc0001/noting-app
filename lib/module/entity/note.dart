class Note {
  String title;
  String desc;

  Note({this.title = "", this.desc = ""});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'] ?? "",
      desc: map['desc'] ?? "",
    );
  }
}
