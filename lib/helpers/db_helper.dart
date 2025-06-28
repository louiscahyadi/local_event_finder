import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/event.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> initDb() async {
    if (_db != null) return _db!;
    String path = join(await getDatabasesPath(), 'event.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE events(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, date TEXT)',
        );
      },
    );
    return _db!;
  }

  static Future<int> insertEvent(Event event) async {
    final db = await initDb();
    return await db.insert('events', event.toMap());
  }

  static Future<List<Event>> getEvents() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.query('events');
    return List.generate(maps.length, (i) => Event.fromMap(maps[i]));
  }

  static Future<int> updateEvent(Event event) async {
    final db = await initDb();
    return await db.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  static Future<int> deleteEvent(int id) async {
    final db = await initDb();
    return await db.delete('events', where: 'id = ?', whereArgs: [id]);
  }
}
