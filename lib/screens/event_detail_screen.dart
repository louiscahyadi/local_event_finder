import 'package:flutter/material.dart';
import '../models/event.dart';
import 'add_edit_event_screen.dart';
import 'map_screen.dart'; // Import MapScreen

class EventDetailScreen extends StatelessWidget {
  final Event event;

  EventDetailScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Event'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditEventScreen(event: event),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Tanggal: ${event.date}'),
            SizedBox(height: 10),
            Text(event.description),
            SizedBox(height: 20),
            Text('Latitude: ${event.latitude}'),
            Text('Longitude: ${event.longitude}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MapScreen(event: event)),
                );
              },
              child: Text('Lihat Lokasi di Map'),
            ),
          ],
        ),
      ),
    );
  }
}
