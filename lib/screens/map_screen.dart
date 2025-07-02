import 'package:flutter/material.dart';
// mengimpor package flutter material untuk kebutuhan UI

import 'package:flutter_map/flutter_map.dart';
// mengimpor package flutter_map untuk menampilkan peta

import 'package:latlong2/latlong.dart';
// mengimpor package latlong2 untuk tipe data LatLng

import '../models/event.dart';
// mengimpor model Event

class MapScreen extends StatelessWidget {
  // mendefinisikan class MapScreen sebagai StatelessWidget

  final Event event;
  // mendeklarasikan properti event bertipe Event

  MapScreen({required this.event});
  // membuat konstruktor dengan parameter wajib event

  @override
  Widget build(BuildContext context) {
    // mengoverride method build untuk membangun UI
    final mapCenter = LatLng(event.latitude, event.longitude);
    // membuat variabel mapCenter dari latitude dan longitude event

    return Scaffold(
      // membuat widget Scaffold sebagai kerangka halaman
      appBar: AppBar(
        backgroundColor: Colors.white,
        // mengatur warna background appbar menjadi putih
        elevation: 0,
        // menghilangkan bayangan appbar
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
          // menampilkan icon kembali dengan warna hitam
          onPressed: () => Navigator.pop(context),
          // menjalankan aksi kembali ke halaman sebelumnya
        ),
        title: Text(
          "Lokasi Event",
          // menampilkan judul appbar
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // mengatur judul appbar di tengah
      ),
      body: Column(
        // membuat kolom untuk isi halaman
        children: [
          Expanded(
            // membuat widget agar peta memenuhi ruang yang tersedia
            child: FlutterMap(
              options: MapOptions(center: mapCenter, zoom: 15.0),
              // mengatur posisi tengah dan zoom peta
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  // mengatur template url tile peta dari OpenStreetMap
                  subdomains: ['a', 'b', 'c'],
                  // mengatur subdomain tile
                  userAgentPackageName: 'com.example.local_event_finder',
                  // mengatur user agent package name
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 50,
                      // mengatur lebar marker
                      height: 50,
                      // mengatur tinggi marker
                      point: mapCenter,
                      // mengatur posisi marker pada lokasi event
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                        // menampilkan icon marker berwarna merah
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            // memberi padding pada container info lokasi
            decoration: BoxDecoration(
              color: Colors.white,
              // mengatur warna background container
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
              // memberi border atas pada container
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, -2),
                  // menambahkan bayangan pada container
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.place, color: Colors.redAccent),
                // menampilkan icon lokasi
                SizedBox(width: 8),
                // memberi jarak horizontal
                Expanded(
                  child: Text(
                    'Lokasi: (${event.latitude}, ${event.longitude})',
                    // menampilkan koordinat lokasi event
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
