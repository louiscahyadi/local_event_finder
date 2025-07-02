import 'package:flutter/material.dart';
// mengimpor package flutter material untuk kebutuhan UI

import '../models/event.dart';
// mengimpor model Event

import 'map_screen.dart';
// mengimpor screen MapScreen

class EventDetailScreen extends StatelessWidget {
  // mendefinisikan class EventDetailScreen sebagai StatelessWidget

  final Event event;
  // mendeklarasikan properti event bertipe Event

  EventDetailScreen({required this.event});
  // membuat konstruktor dengan parameter wajib event

  @override
  Widget build(BuildContext context) {
    // mengoverride method build untuk membangun UI
    return Scaffold(
      // membuat widget Scaffold sebagai kerangka halaman
      body: SingleChildScrollView(
        // menggunakan SingleChildScrollView agar konten bisa discroll
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mengatur alignment kolom ke kiri
          children: [
            Stack(
              // menggunakan Stack untuk menumpuk widget
              children: [
                Image.network(
                  // menampilkan gambar event dari url
                  'https://plus.unsplash.com/premium_photo-1682871360779-e8f1f77123ad?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  width: double.infinity,
                  // mengatur lebar gambar memenuhi layar
                  height: 220,
                  // mengatur tinggi gambar
                  fit: BoxFit.cover,
                  // mengatur gambar agar menutupi container
                ),
                Positioned(
                  // menempatkan widget secara absolut di Stack
                  top: 40,
                  // mengatur posisi dari atas
                  left: 12,
                  // mengatur posisi dari kiri
                  child: CircleAvatar(
                    // membuat avatar bulat untuk tombol kembali
                    backgroundColor: Colors.white,
                    // mengatur warna background avatar
                    child: BackButton(color: Colors.black),
                    // menampilkan tombol kembali dengan warna hitam
                  ),
                ),
                Positioned(
                  // menempatkan widget pada posisi tertentu di Stack
                  bottom: 16,
                  // mengatur posisi dari bawah
                  left: 16,
                  // mengatur posisi dari kiri
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mengatur alignment kolom ke kiri
                    children: [
                      Container(
                        // membuat container untuk kategori event
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade200,
                          // mengatur warna background kategori
                          borderRadius: BorderRadius.circular(20),
                          // mengatur sudut border menjadi bulat
                        ),
                        child: Text(
                          'Musik',
                          // menampilkan teks kategori event (sementara hardcode)
                          style: TextStyle(color: Colors.white),
                          // mengatur warna teks menjadi putih
                        ),
                      ),
                      SizedBox(height: 8),
                      // memberi jarak vertikal
                      Text(
                        event.title,
                        // menampilkan judul event
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        // mengatur style judul event
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              // memberi padding pada seluruh konten detail
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mengatur alignment kolom ke kiri
                children: [
                  Card(
                    // membuat card untuk info tanggal dan lokasi
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      // mengatur sudut card menjadi bulat
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      // memberi padding di dalam card
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // membuat baris untuk info tanggal
                            children: [
                              Icon(Icons.calendar_today, color: Colors.red),
                              // menampilkan icon kalender
                              SizedBox(width: 8),
                              // memberi jarak horizontal
                              Expanded(
                                child: Text(
                                  event.date + ', 10:00 - 22:00',
                                  // menampilkan tanggal event dan waktu (sementara hardcode)
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          // memberi jarak vertikal
                          Row(
                            // membuat baris untuk info lokasi
                            children: [
                              Icon(Icons.location_on, color: Colors.teal),
                              // menampilkan icon lokasi
                              SizedBox(width: 8),
                              // memberi jarak horizontal
                              Expanded(
                                child: Text(
                                  'Lokasi Event',
                                  // menampilkan teks lokasi event (sementara hardcode)
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // memberi jarak vertikal
                  Text(
                    'Deskripsi Event',
                    // menampilkan judul section deskripsi
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  // memberi jarak vertikal
                  Text(event.description, style: TextStyle(fontSize: 16)),
                  // menampilkan deskripsi event
                  SizedBox(height: 16),
                  // memberi jarak vertikal
                  Text(
                    'Lokasi Event',
                    // menampilkan judul section lokasi
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  // memberi jarak vertikal
                  Container(
                    height: 150,
                    // mengatur tinggi container map preview
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      // mengatur sudut container menjadi bulat
                    ),
                    child: Center(child: Text('Map Preview')),
                    // menampilkan teks Map Preview (sementara)
                  ),
                  SizedBox(height: 8),
                  // memberi jarak vertikal
                  Align(
                    alignment: Alignment.centerRight,
                    // mengatur posisi tombol ke kanan
                    child: ElevatedButton(
                      onPressed: () {
                        // menjalankan aksi saat tombol ditekan
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MapScreen(event: event),
                            // membuka halaman MapScreen dengan parameter event
                          ),
                        );
                      },
                      child: Text('Lihat Peta'),
                      // menampilkan teks pada tombol
                    ),
                  ),
                  SizedBox(height: 16),
                  // memberi jarak vertikal
                  Text(
                    'Penyelenggara',
                    // menampilkan judul section penyelenggara
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  // memberi jarak vertikal
                  Card(
                    // membuat card untuk info penyelenggara
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      // mengatur sudut card menjadi bulat
                    ),
                    child: ListTile(
                      leading: Icon(Icons.business),
                      // menampilkan icon bisnis
                      title: Text('Asosiasi Kuliner Indonesia'),
                      // menampilkan nama penyelenggara (sementara hardcode)
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          // memberi jarak vertikal
                          Row(
                            children: [
                              Icon(Icons.phone, size: 16),
                              // menampilkan icon telepon
                              SizedBox(width: 4),
                              // memberi jarak horizontal
                              Text('+62 812 3456 7890'),
                              // menampilkan nomor telepon (sementara hardcode)
                            ],
                          ),
                          SizedBox(height: 4),
                          // memberi jarak vertikal
                          Row(
                            children: [
                              Icon(Icons.email, size: 16),
                              // menampilkan icon email
                              SizedBox(width: 4),
                              // memberi jarak horizontal
                              Text('info@festivalkulinernusantara.id'),
                              // menampilkan email penyelenggara (sementara hardcode)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  // memberi jarak vertikal agar tidak tertutup bottom bar
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        // membuat bottom navigation bar
        padding: EdgeInsets.all(16),
        // memberi padding pada bottom bar
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                // tombol untuk menandai tertarik (belum ada aksi)
                icon: Icon(Icons.favorite_border),
                label: Text('Tandai Tertarik'),
              ),
            ),
            SizedBox(width: 10),
            // memberi jarak horizontal
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                // tombol untuk membagikan event (belum ada aksi)
                icon: Icon(Icons.share),
                label: Text('Bagikan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  // mengatur warna tombol
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
