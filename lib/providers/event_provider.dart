import 'package:flutter/foundation.dart';
// mengimpor package foundation dari flutter untuk menggunakan ChangeNotifier

import '../models/event.dart';
// mengimpor file event.dart untuk menggunakan class Event

import 'package:sqflite/sqflite.dart';
// mengimpor package sqflite untuk operasi database SQLite

class EventProvider with ChangeNotifier {
  // mendefinisikan class EventProvider yang menggunakan ChangeNotifier untuk state management

  final List<Event> _events = [];
  // mendeklarasikan list privat _events untuk menyimpan daftar event

  List<Event> get events => _events;
  // membuat getter events untuk mengakses daftar event dari luar class

  void loadEvents() {
    // membuat method untuk memuat data event (dummy data)
    _events.addAll([
      // menambahkan beberapa event ke dalam list _events
      Event(
        id: 1,
        // mengisi id event dengan nilai 1
        title: 'Festival Musik',
        // mengisi title event dengan 'Festival Musik'
        description: 'Nikmati konser live dari band lokal!',
        // mengisi description event dengan deskripsi konser
        date: '2025-07-01',
        // mengisi date event dengan tanggal tertentu
        latitude: -8.1123,
        // mengisi latitude event
        longitude: 115.0912,
        // mengisi longitude event
      ),
    ]);
    notifyListeners();
    // memberitahu listener bahwa data telah berubah
  }

  void addEvent(Event event) {
    // membuat method untuk menambah event baru ke list
    final newEvent = Event(
      id: DateTime.now().millisecondsSinceEpoch,
      // membuat id unik berdasarkan waktu saat ini
      title: event.title,
      // menyalin title dari event yang diberikan
      description: event.description,
      // menyalin description dari event yang diberikan
      date: event.date,
      // menyalin date dari event yang diberikan
      latitude: event.latitude,
      // menyalin latitude dari event yang diberikan
      longitude: event.longitude,
      // menyalin longitude dari event yang diberikan
    );
    _events.add(newEvent);
    // menambahkan event baru ke list _events
    notifyListeners();
    // memberitahu listener bahwa data telah berubah
  }

  void updateEvent(String id, Event updatedEvent) {
    // membuat method untuk memperbarui event berdasarkan id
    final index = _events.indexWhere((event) => event.id == id);
    // mencari index event yang memiliki id sesuai parameter
    if (index != -1) {
      // jika event ditemukan
      _events[index] = updatedEvent;
      // mengganti event lama dengan event yang baru
      notifyListeners();
      // memberitahu listener bahwa data telah berubah
    }
  }

  void deleteEvent(String id) {
    // membuat method untuk menghapus event berdasarkan id
    _events.removeWhere((event) => event.id == id);
    // menghapus event yang memiliki id sesuai parameter
    notifyListeners();
    // memberitahu listener bahwa data telah berubah
  }

  Future<void> saveEventToDatabase(Event event, Database db) async {
    // membuat method async untuk menyimpan perubahan event ke database
    await db.update(
      'events',
      // menentukan nama tabel
      event.toMap(),
      // mengubah event menjadi map dan menyimpannya
      where: 'id = ?',
      // menentukan kondisi update berdasarkan id
      whereArgs: [event.id],
      // mengisi argumen id untuk kondisi where
    );
  }
}
