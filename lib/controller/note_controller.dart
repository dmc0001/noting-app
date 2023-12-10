import 'package:text_app/module/database/database.dart';
import 'package:text_app/module/entity/note.dart';

class NoteController {
  final NoteDatabase _noteDatabase = NoteDatabase();
  

  Future<List<Map<String, dynamic>>> readNotes() async {
    List<Map<String, dynamic>> data =
        await _noteDatabase.readData('SELECT * FROM Note');
    return data;
  }

  Future<void> addNote(Note note) async {
    // Add your logic to add a new note here
    // For example:
     await _noteDatabase.writeData('INSERT INTO Note (title, desc) VALUES ("${note.title}", "${note.desc}")');
  }

  Future<void> deleteNote(int id) async {
    await _noteDatabase.writeDelete('DELETE FROM Note WHERE id = $id');
  }
}