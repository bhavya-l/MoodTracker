import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:moodtracker/models/reading.dart';

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // If no db yet, open it
    _database = await _initDB('moodtracker_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE reading (
        id INTEGER PRIMARY KEY,
        timestamp TEXT,
        mood_score INTEGER,
        context_light INTEGER,
        context_noise INTEGER,
        context_activity INTEGER
      )
    ''');
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(
      dbPath,
      'moodtracker_database.db',
    ); // replace with your db filename
    await deleteDatabase(path);
  }

  Future<int> insertReading(Reading reading) async {
    Database db = await instance.database;
    return await db.insert('reading', reading.toMap());
  }

  Future<List<Map<String, dynamic>>> getReading() async {
    Database db = await instance.database;
    return await db.query('reading');
  }

  Future<int> updateReading(Reading reading) async {
    Database db = await instance.database;
    return await db.update(
      'reading',
      reading.toMap(),
      where: 'id = ?',
      whereArgs: [reading.id],
    );
  }

  Future<int> deleteReading(int id) async {
    Database db = await instance.database;
    return await db.delete('reading', where: 'id = ?', whereArgs: [id]);
  }
}
