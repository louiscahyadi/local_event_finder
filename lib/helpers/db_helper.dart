// import package path untuk mengelola path file database
import 'package:path/path.dart';
// import package sqflite untuk operasi database SQLite
import 'package:sqflite/sqflite.dart';
// import model event untuk konversi data event ke map dan sebaliknya
import '../models/event.dart';

// mendefinisikan class DBHelper untuk mengelola operasi database
class DBHelper {
  // mendeklarasikan variabel statis _db untuk menyimpan instance database
  static Database? _db;

  // membuat method statis untuk inisialisasi database
  static Future<Database> initDb() async {
    // jika _db sudah ada, langsung mengembalikan instance database
    if (_db != null) return _db!;
    // mendapatkan path direktori database dan menggabungkannya dengan nama file database
    String path = join(await getDatabasesPath(), 'event.db');
    // membuka database, jika belum ada maka membuat database baru
    _db = await openDatabase(
      path,
      version: 1,
      // membuat tabel events saat database pertama kali dibuat
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE events(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, date TEXT)',
        );
      },
    );
    // mengembalikan instance database yang sudah diinisialisasi
    return _db!;
  }

  // membuat method statis untuk menambahkan event ke database
  static Future<int> insertEvent(Event event) async {
    // memastikan database sudah diinisialisasi
    final db = await initDb();
    // memasukkan data event ke tabel events dan mengembalikan id baris baru
    return await db.insert('events', event.toMap());
  }

  // membuat method statis untuk mengambil semua event dari database
  static Future<List<Event>> getEvents() async {
    // memastikan database sudah diinisialisasi
    final db = await initDb();
    // mengambil semua data dari tabel events dalam bentuk list map
    final List<Map<String, dynamic>> maps = await db.query('events');
    // mengubah list map menjadi list objek Event
    return List.generate(maps.length, (i) => Event.fromMap(maps[i]));
  }

  // membuat method statis untuk memperbarui data event di database
  static Future<int> updateEvent(Event event) async {
    // memastikan database sudah diinisialisasi
    final db = await initDb();
    // memperbarui data event berdasarkan id dan mengembalikan jumlah baris yang diperbarui
    return await db.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  // membuat method statis untuk menghapus event dari database berdasarkan id
  static Future<int> deleteEvent(int id) async {
    // memastikan database sudah diinisialisasi
    final db = await initDb();
    // menghapus data event berdasarkan id dan mengembalikan jumlah baris yang dihapus
    return await db.delete('events', where: 'id = ?', whereArgs: [id]);
  }
}
