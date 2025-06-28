import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationPickerScreen extends StatefulWidget {
  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pilih Lokasi Event')),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(-8.65, 115.22), // Contoh: Denpasar
          zoom: 13,
          onTap: (tapPosition, point) {
            setState(() {
              selectedLocation = point;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.local_event_finder',
          ),
          if (selectedLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: selectedLocation!,
                  width: 80,
                  height: 80,
                  child: Icon(Icons.location_on, color: Colors.red, size: 40),
                ),
              ],
            ),
        ],
      ),
      floatingActionButton:
          selectedLocation == null
              ? null
              : FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pop(context, selectedLocation);
                },
                label: Text('Pilih Lokasi'),
                icon: Icon(Icons.check),
              ),
    );
  }
}
