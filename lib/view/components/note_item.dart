import 'package:flutter/material.dart';
import 'package:text_app/module/entity/note.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;

  const NoteItem({
    Key? key,
    required this.note,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          note.title,
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Text(
          note.desc,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
