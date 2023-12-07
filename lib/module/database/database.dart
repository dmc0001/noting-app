import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase {
  
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "Note");
    Future<Database> noteDB = openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: onUpgrade);
    return noteDB;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        '''
  CREATE TABLE "Note"(
    'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'title' TEXT,
    'desc' TEXT
  )
  ''');
    print("_onCreate ============================");
  }

  onUpgrade(Database db, int oldVersion, int newVersion) {
     print("_onUpgrade ============================");
  }

  //SELECT
  readData(String sqlQuery) async {
    Database? noteDB = await db;
    List<Map> response = await noteDB!.rawQuery(sqlQuery);
    return response;
  }

  //INSERT
  writeData(String sqlQuery) async {
    Database? noteDB = await db;
    int response = await noteDB!.rawInsert(sqlQuery);
    return response;
  }

  //DELETE
  writeDelete(String sqlQuery) async {
    Database? noteDB = await db;
    int response = await noteDB!.rawDelete(sqlQuery);
    return response;
  }

  //UPDATE
  writeUpdate(String sqlQuery) async {
    Database? noteDB = await db;
    int response = await noteDB!.rawDelete(sqlQuery);
    return response;
  }
}
