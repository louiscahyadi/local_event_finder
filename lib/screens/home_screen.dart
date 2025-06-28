import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import 'add_edit_event_screen.dart';
import 'event_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Daftar Event')),
      body:
          eventProvider.events.isEmpty
              ? Center(child: Text('Belum ada event. Tambahkan yuk!'))
              : ListView.builder(
                itemCount: eventProvider.events.length,
                itemBuilder: (context, index) {
                  final event = eventProvider.events[index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        event.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(event.date),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EventDetailScreen(event: event),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditEventScreen()),
          );
        },
        label: Text('Tambah Event'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
