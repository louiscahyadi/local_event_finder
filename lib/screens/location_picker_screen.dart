import 'package:flutter/material.dart';
// mengimpor package flutter material untuk kebutuhan UI

import 'package:flutter_map/flutter_map.dart';
// mengimpor package flutter_map untuk menampilkan peta

import 'package:latlong2/latlong.dart';
// mengimpor package latlong2 untuk tipe data LatLng

class LocationPickerScreen extends StatefulWidget {
  // mendefinisikan class LocationPickerScreen sebagai StatefulWidget

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
  // mengoverride method createState untuk mengembalikan state
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  // mendefinisikan state untuk LocationPickerScreen

  LatLng? selectedLocation;
  // mendeklarasikan variabel selectedLocation bertipe LatLng nullable untuk menyimpan lokasi yang dipilih

  @override
  Widget build(BuildContext context) {
    // mengoverride method build untuk membangun UI
    return Scaffold(
      // membuat widget Scaffold sebagai kerangka halaman
      appBar: AppBar(title: Text('Pilih Lokasi Event')),
      // menampilkan AppBar dengan judul
      body: FlutterMap(
        // menampilkan widget peta menggunakan FlutterMap
        options: MapOptions(
          // mengatur opsi peta
          center: LatLng(-8.65, 115.22), // Contoh: Denpasar
          // mengatur posisi awal peta di Denpasar
          zoom: 13,
          // mengatur level zoom awal peta
          onTap: (tapPosition, point) {
            // menjalankan fungsi saat peta ditekan
            setState(() {
              selectedLocation = point;
              // mengubah selectedLocation sesuai titik yang dipilih user
            });
          },
        ),
        children: [
          TileLayer(
            // menampilkan layer tile peta dari OpenStreetMap
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            // mengatur template url tile peta
            userAgentPackageName: 'com.example.local_event_finder',
            // mengatur user agent package name
          ),
          if (selectedLocation != null)
            // jika user sudah memilih lokasi
            MarkerLayer(
              // menampilkan marker pada lokasi yang dipilih
              markers: [
                Marker(
                  point: selectedLocation!,
                  // mengatur posisi marker pada lokasi yang dipilih
                  width: 80,
                  // mengatur lebar marker
                  height: 80,
                  // mengatur tinggi marker
                  child: Icon(Icons.location_on, color: Colors.red, size: 40),
                  // menampilkan icon marker berwarna merah
                ),
              ],
            ),
        ],
      ),
      floatingActionButton:
          selectedLocation == null
              // jika belum ada lokasi yang dipilih, tidak menampilkan tombol
              ? null
              : FloatingActionButton.extended(
                // jika sudah memilih lokasi, menampilkan tombol pilih lokasi
                onPressed: () {
                  Navigator.pop(context, selectedLocation);
                  // mengembalikan lokasi yang dipilih ke halaman sebelumnya
                },
                label: Text('Pilih Lokasi'),
                // menampilkan label pada tombol
                icon: Icon(Icons.check),
                // menampilkan icon ceklis pada tombol
              ),
    );
  }
}
