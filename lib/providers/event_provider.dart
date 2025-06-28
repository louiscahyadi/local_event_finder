import 'package:flutter/foundation.dart';
import '../models/event.dart';

class EventProvider with ChangeNotifier {
  final List<Event> _events = [];

  List<Event> get events => _events;

  void loadEvents() {
    // Dummy data jika dibutuhkan
    _events.addAll([
      Event(
        id: '1',
        title: 'Festival Musik',
        description: 'Nikmati konser live dari band lokal!',
        date: '2025-07-01',
        latitude: -8.1123,
        longitude: 115.0912,
      ),
    ]);
    notifyListeners();
  }

  void addEvent(Event event) {
    // Simulasikan generate ID otomatis
    final newEvent = Event(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: event.title,
      description: event.description,
      date: event.date,
      latitude: event.latitude,
      longitude: event.longitude,
    );
    _events.add(newEvent);
    notifyListeners();
  }

  void updateEvent(String id, Event updatedEvent) {
    final index = _events.indexWhere((event) => event.id == id);
    if (index != -1) {
      _events[index] = updatedEvent;
      notifyListeners();
    }
  }

  void deleteEvent(String id) {
    _events.removeWhere((event) => event.id == id);
    notifyListeners();
  }
}
