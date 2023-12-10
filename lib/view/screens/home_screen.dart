import 'package:flutter/material.dart';
import 'package:text_app/controller/note_controller.dart';
import 'package:text_app/module/entity/note.dart';
import 'package:text_app/view/screens/details_note_screen.dart';
import 'package:text_app/view/components/note_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, dynamic>>> notes;
  final NoteController _noteController = NoteController();

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future<void> refreshNotes() async {
    setState(() {
      notes = _noteController.readNotes();
    });
  }

  void deleteNote(int id) async {
    await _noteController.deleteNote(id);
    refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailsNoteScreen()),
          ).then((_) {
            // This code runs when the DetailsNoteScreen is popped and returns to this screen
            refreshNotes();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: notes,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      //physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> noteData = snapshot.data![index];
                        return NoteItem(
                          note: Note(
                            title: noteData['title'],
                            desc: noteData['desc'],
                          ),
                          onDelete: () {
                            deleteNote(noteData['id']);
                          },
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
