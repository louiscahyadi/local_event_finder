import 'package:flutter/material.dart';
// mengimpor package flutter material untuk kebutuhan UI

import 'package:provider/provider.dart';
// mengimpor provider untuk state management

import '../providers/event_provider.dart';
// mengimpor event_provider untuk mengakses data event

import 'add_edit_event_screen.dart';
// mengimpor screen untuk tambah/edit event

import 'event_detail_screen.dart';
// mengimpor screen untuk detail event

import 'profile_screen.dart';
// mengimpor screen profil user

import 'dart:io';
// mengimpor dart:io untuk operasi file gambar

class HomeScreen extends StatefulWidget {
  // mendefinisikan class HomeScreen sebagai StatefulWidget

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  // mengoverride method createState untuk mengembalikan state
}

class _HomeScreenState extends State<HomeScreen> {
  // mendefinisikan state untuk HomeScreen

  int _selectedIndex = 0;
  // mendeklarasikan variabel untuk menyimpan index tab yang dipilih

  final List<Widget> _screens = [HomeScreenContent(), ProfileScreen()];
  // mendeklarasikan list widget untuk menampung halaman beranda dan profil

  void _onItemTapped(int index) {
    // membuat method untuk mengubah tab yang dipilih
    setState(() {
      _selectedIndex = index;
      // mengubah nilai _selectedIndex sesuai tab yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    // mengoverride method build untuk membangun UI
    return Scaffold(
      body: _screens[_selectedIndex],
      // menampilkan halaman sesuai tab yang dipilih
      bottomNavigationBar: BottomNavigationBar(
        // menampilkan bottom navigation bar
        type: BottomNavigationBarType.fixed,
        // mengatur tipe navigation bar menjadi fixed
        currentIndex: _selectedIndex,
        // mengatur index tab yang aktif
        onTap: _onItemTapped,
        // menjalankan method _onItemTapped saat tab ditekan
        selectedFontSize: 14,
        // mengatur ukuran font tab aktif
        unselectedFontSize: 13,
        // mengatur ukuran font tab tidak aktif
        iconSize: 28,
        // mengatur ukuran icon tab
        selectedItemColor: Colors.blue[800],
        // mengatur warna tab aktif
        unselectedItemColor: Colors.grey[500],
        // mengatur warna tab tidak aktif
        elevation: 8,
        // mengatur elevasi navigation bar
        items: [
          BottomNavigationBarItem(
            // membuat item tab beranda
            icon: Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Icon(Icons.home),
              // menampilkan icon home
            ),
            label: 'Beranda',
            // memberi label Beranda
          ),
          BottomNavigationBarItem(
            // membuat item tab profil
            icon: Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Icon(Icons.person),
              // menampilkan icon profil
            ),
            label: 'Profil',
            // memberi label Profil
          ),
        ],
      ),
      floatingActionButton:
          _selectedIndex == 0
              // menampilkan tombol tambah hanya di tab beranda
              ? FloatingActionButton(
                backgroundColor: Colors.redAccent,
                // mengatur warna tombol tambah
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddEditEventScreen()),
                    // membuka halaman tambah event
                  );
                },
                child: Icon(Icons.add),
                // menampilkan icon tambah
              )
              : null,
      // tidak menampilkan tombol tambah di tab profil
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  // mendefinisikan widget stateless untuk isi halaman beranda

  @override
  Widget build(BuildContext context) {
    // mengoverride method build untuk membangun UI
    final eventProvider = Provider.of<EventProvider>(context);
    // mendapatkan instance EventProvider dari context

    return Scaffold(
      backgroundColor: Colors.white,
      // mengatur warna background menjadi putih
      appBar: AppBar(
        elevation: 0,
        // menghilangkan bayangan appbar
        backgroundColor: Colors.white,
        // mengatur warna appbar menjadi putih
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Icon(Icons.location_on, color: Colors.teal),
          // menampilkan icon lokasi di kiri appbar
        ),
        title: Text(
          'EventFinder',
          // menampilkan judul aplikasi
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black54),
            // menampilkan icon profil di kanan appbar
            onPressed: () {},
            // belum ada aksi saat ditekan
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        // memberi padding horizontal pada body
        child: ListView(
          children: [
            SizedBox(height: 8),
            // memberi jarak vertikal
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  // menampilkan icon search
                  SizedBox(width: 8),
                  // memberi jarak horizontal
                  Text('Cari event...', style: TextStyle(color: Colors.grey)),
                  // menampilkan placeholder pencarian
                ],
              ),
            ),
            SizedBox(height: 20),
            // memberi jarak vertikal
            SizedBox(
              height: 48,
              // mengatur tinggi list kategori
              child: ListView(
                scrollDirection: Axis.horizontal,
                // membuat list kategori secara horizontal
                children: [
                  _buildCategoryIcon(Icons.grid_view, 'Semua', true),
                  // menampilkan kategori Semua (aktif)
                  _buildCategoryIcon(Icons.music_note, 'Musik', false),
                  // menampilkan kategori Musik
                  _buildCategoryIcon(Icons.restaurant, 'Kuliner', false),
                  // menampilkan kategori Kuliner
                  _buildCategoryIcon(Icons.sports, 'Olahraga', false),
                  // menampilkan kategori Olahraga
                  _buildCategoryIcon(Icons.palette, 'Seni', false),
                  // menampilkan kategori Seni
                  _buildCategoryIcon(Icons.school, 'Pendidikan', false),
                  // menampilkan kategori Pendidikan
                ],
              ),
            ),
            SizedBox(height: 20),
            // memberi jarak vertikal
            Text(
              'Event Terpopuler',
              // menampilkan judul section event terpopuler
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // memberi jarak vertikal
            if (eventProvider.events.isNotEmpty)
              _buildMainEventCard(context, eventProvider.events.first),
            // menampilkan event utama jika ada event
            SizedBox(height: 20),
            // memberi jarak vertikal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mengatur posisi teks dan tombol lihat semua
              children: [
                Text(
                  'Event Mendatang',
                  // menampilkan judul section event mendatang
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                TextButton(onPressed: () {}, child: Text('Lihat Semua')),
                // menampilkan tombol lihat semua (belum ada aksi)
              ],
            ),
            ...eventProvider.events
                .skip(1)
                .map((e) => _buildMiniCard(e))
                .toList(),
            // menampilkan daftar event mendatang selain event utama
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(IconData icon, String label, bool active) {
    // membuat widget untuk menampilkan icon kategori event
    return Container(
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: active ? Colors.redAccent.withOpacity(0.2) : Colors.grey[100],
        // mengatur warna background kategori aktif/tidak aktif
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: active ? Colors.redAccent : Colors.grey),
          // menampilkan icon kategori
          SizedBox(width: 6),
          // memberi jarak horizontal
          Text(
            label,
            // menampilkan label kategori
            style: TextStyle(color: active ? Colors.redAccent : Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildMainEventCard(BuildContext context, event) {
    // membuat widget untuk menampilkan event utama
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
              // menampilkan gambar event utama (sementara hardcode)
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
                        // menampilkan kategori event (sementara hardcode)
                        style: TextStyle(color: Colors.teal[800]),
                      ),
                    ),
                    SizedBox(width: 8),
                    // memberi jarak horizontal
                    Text(event.date, style: TextStyle(color: Colors.grey)),
                    // menampilkan tanggal event
                  ],
                ),
                SizedBox(height: 8),
                // memberi jarak vertikal
                Text(
                  event.title,
                  // menampilkan judul event
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                // memberi jarak vertikal
                Text(event.location, style: TextStyle(color: Colors.grey[700])),
                // menampilkan lokasi event
                SizedBox(height: 8),
                // memberi jarak vertikal
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventDetailScreen(event: event),
                        // membuka halaman detail event
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
                  // menampilkan teks pada tombol
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniCard(event) {
    // membuat widget untuk menampilkan event dalam bentuk mini card
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child:
              (event.imagePath != null && event.imagePath!.isNotEmpty)
                  // jika ada gambar event, tampilkan gambar dari file
                  ? Image.file(
                    File(event.imagePath!),
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  )
                  // jika tidak ada gambar, tampilkan gambar default
                  : Image.asset(
                    'assets/default_event.jpg',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
        ),
        title: Text(event.title),
        // menampilkan judul event
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            // memberi jarak vertikal
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                // menampilkan icon kalender
                SizedBox(width: 4),
                // memberi jarak horizontal
                Text(event.date, style: TextStyle(fontSize: 12)),
                // menampilkan tanggal event
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 14, color: Colors.grey),
                // menampilkan icon lokasi
                SizedBox(width: 4),
                // memberi jarak horizontal
                Text(event.location, style: TextStyle(fontSize: 12)),
                // menampilkan lokasi event
              ],
            ),
          ],
        ),
        onTap: () {},
        // belum ada aksi saat ditekan
      ),
    );
  }
}
