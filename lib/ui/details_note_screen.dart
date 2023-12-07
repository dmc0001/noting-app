import 'package:flutter/material.dart';
import 'package:text_app/module/entity/note.dart';
import 'package:text_app/module/database/database.dart';

// ignore: must_be_immutable
class DetailsNoteScreen extends StatefulWidget {
  DetailsNoteScreen({super.key});

  @override
  State<DetailsNoteScreen> createState() => _DetailsNoteScreenState();
}

class _DetailsNoteScreenState extends State<DetailsNoteScreen> {
  NoteDatabase noteDatabase = NoteDatabase();

  Note note = Note();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (note.title.isNotEmpty || note.desc.isNotEmpty) {
              await noteDatabase.writeData(
                'INSERT INTO Note (title, desc) VALUES ("${note.title}", "${note.desc}")',
              );
            }
          },
          child: const Icon(Icons.save)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          const SizedBox(
            height: 16,
          ),
          TextField(
            onChanged: (value) {
              note.title = value;
            },
            decoration: const InputDecoration(
                hintText: 'Enter note title...',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                )),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            onChanged: (value) {
              note.desc = value;
            },
            decoration: const InputDecoration(
                hintText: 'Enter note details...',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: InputBorder.none),
          )
        ]),
      ),
    );
  }
}
