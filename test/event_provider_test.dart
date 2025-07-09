import 'package:flutter_test/flutter_test.dart';
import 'package:local_event_finder/providers/event_provider.dart';
import 'package:local_event_finder/models/event.dart';

void main() {
  group('EventProvider', () {
    test('addEvent menambah event ke list', () {
      final provider = EventProvider();
      final event = Event(
        id: 123,
        title: 'Test Event',
        description: 'Deskripsi',
        date: '2025-07-08',
        latitude: -8.1,
        longitude: 115.0,
      );

      expect(provider.events.length, 0);

      provider.addEvent(event);

      expect(provider.events.length, 1);
      expect(provider.events.first.title, 'Test Event');
      expect(provider.events.first.description, 'Deskripsi');
      expect(provider.events.first.date, '2025-07-08');
      expect(provider.events.first.latitude, -8.1);
      expect(provider.events.first.longitude, 115.0);
      expect(provider.events.first.id, isNot(123));
    });
  });
}
