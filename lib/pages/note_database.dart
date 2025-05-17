import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'note_model.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();

  static Database? _database;

  NoteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        body TEXT,
        mood TEXT
      )
    ''');
  }

  Future<List<Note>> getNotes() async {
    final db = await instance.database;

    final result = await db.query('notes');

    return result.map((json) => Note.fromMap(json)).toList();
  }

  Future<int> insertNote(Note note) async {
    final db = await instance.database;
    return await db.insert('notes', note.toMap());
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> deleteNote(Note note) async {
    final db = await instance.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [note.id]);
  }

  Future<int> updateNote(Note updatedNote) async {
    final db = await instance.database;
    return await db.update('notes', updatedNote.toMap(),
        where: 'id = ?', whereArgs: [updatedNote.id]);
  }

  Future<int> deleteAllNotes() async {
    final db = await instance.database;
    return await db.delete('notes');
  }
}
