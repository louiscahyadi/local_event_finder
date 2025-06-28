import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/event.dart';

class MapScreen extends StatelessWidget {
  final Event event;

  MapScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lokasi Event")),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(event.latitude, event.longitude),
          zoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png",
            subdomains: ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.local_event_finder',
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80,
                height: 80,
                point: LatLng(event.latitude, event.longitude),
                child: Icon(
                  Icons.location_on,
                  color: Colors.redAccent,
                  size: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
