import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "MoodTracker.db";
  static const _databaseVersion = 1;

  static const table = 'mood_entries';
  static const columnId = '_id';
  static const columnDate = 'date'; // ISO string, e.g., "2025-03-31"
  static const columnMood = 'mood'; // Integer 0–4 (sad to happy)
  static const columnJournal = 'journal'; // Optional text

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnDate TEXT NOT NULL UNIQUE,
        $columnMood INTEGER NOT NULL,
        $columnJournal TEXT
      )
    ''');
  }

  Future<int> insertEntry(String date, int mood, String journal) async {
    final db = await database;
    return await db.insert(
      table,
      {
        columnDate: date,
        columnMood: mood,
        columnJournal: journal,
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // overwrite same-day entry
    );
  }

  Future<Map<String, dynamic>?> getEntryByDate(String date) async {
    final db = await database;
    final result = await db.query(
      table,
      where: '$columnDate = ?',
      whereArgs: [date],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getAllEntries() async {
    final db = await database;
    return await db.query(table);
  }

  Future<int> deleteEntry(String date) async {
    final db = await database;
    return await db.delete(
      table,
      where: '$columnDate = ?',
      whereArgs: [date],
    );
  }
}
