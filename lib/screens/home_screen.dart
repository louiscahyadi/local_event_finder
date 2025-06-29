import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import 'add_edit_event_screen.dart';
import 'event_detail_screen.dart';
import 'profile_screen.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [HomeScreenContent(), ProfileScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 14,
        unselectedFontSize: 13,
        iconSize: 28,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey[500],
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Icon(Icons.home),
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Icon(Icons.person),
            ),
            label: 'Profil',
          ),
        ],
      ),
      floatingActionButton:
          _selectedIndex == 0
              ? FloatingActionButton(
                backgroundColor: Colors.redAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddEditEventScreen()),
                  );
                },
                child: Icon(Icons.add),
              )
              : null,
    );
  }
}

// Pindahkan seluruh isi build HomeScreen ke widget baru:
class HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Icon(Icons.location_on, color: Colors.teal),
        ),
        title: Text(
          'EventFinder',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Text('Cari event...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryIcon(Icons.grid_view, 'Semua', true),
                  _buildCategoryIcon(Icons.music_note, 'Musik', false),
                  _buildCategoryIcon(Icons.restaurant, 'Kuliner', false),
                  _buildCategoryIcon(Icons.sports, 'Olahraga', false),
                  _buildCategoryIcon(Icons.palette, 'Seni', false),
                  _buildCategoryIcon(Icons.school, 'Pendidikan', false),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Event Terpopuler',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (eventProvider.events.isNotEmpty)
              _buildMainEventCard(context, eventProvider.events.first),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Event Mendatang',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                TextButton(onPressed: () {}, child: Text('Lihat Semua')),
              ],
            ),
            ...eventProvider.events
                .skip(1)
                .map((e) => _buildMiniCard(e))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(IconData icon, String label, bool active) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: active ? Colors.redAccent.withOpacity(0.2) : Colors.grey[100],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: active ? Colors.redAccent : Colors.grey),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: active ? Colors.redAccent : Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildMainEventCard(BuildContext context, event) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              'https://plus.unsplash.com/premium_photo-1682871360779-e8f1f77123ad?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.teal[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Musik',
                        style: TextStyle(color: Colors.teal[800]),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(event.date, style: TextStyle(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  event.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(event.location, style: TextStyle(color: Colors.grey[700])),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventDetailScreen(event: event),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Lihat Detail'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniCard(event) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child:
              (event.imagePath != null && event.imagePath!.isNotEmpty)
                  ? Image.file(
                    File(event.imagePath!),
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  )
                  : Image.asset(
                    'assets/default_event.jpg',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
        ),
        title: Text(event.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Text(event.date, style: TextStyle(fontSize: 12)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Text(event.location, style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
