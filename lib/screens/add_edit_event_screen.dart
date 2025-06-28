import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../providers/event_provider.dart';
import 'location_picker_screen.dart';
import 'package:latlong2/latlong.dart';

class AddEditEventScreen extends StatefulWidget {
  final Event? event;

  AddEditEventScreen({this.event});

  @override
  _AddEditEventScreenState createState() => _AddEditEventScreenState();
}

class _AddEditEventScreenState extends State<AddEditEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _titleController.text = widget.event!.title;
      _descriptionController.text = widget.event!.description;
      _dateController.text = widget.event!.date;
      _latitudeController.text = widget.event!.latitude.toString();
      _longitudeController.text = widget.event!.longitude.toString();
    }
  }

  void _saveEvent() {
    if (_formKey.currentState!.validate()) {
      final newEvent = Event(
        id:
            widget
                .event
                ?.id, // gunakan ID lama saat edit, atau null saat tambah
        title: _titleController.text,
        description: _descriptionController.text,
        date: _dateController.text,
        latitude: double.tryParse(_latitudeController.text) ?? 0.0,
        longitude: double.tryParse(_longitudeController.text) ?? 0.0,
      );

      final eventProvider = Provider.of<EventProvider>(context, listen: false);

      if (widget.event == null) {
        eventProvider.addEvent(newEvent); // Tambah event baru
      } else {
        eventProvider.updateEvent(
          widget.event!.id!,
          newEvent,
        ); // Edit event yang ada
      }

      Navigator.pop(context); // Kembali ke halaman sebelumnya
    } else {
      print("Form tidak valid");
    }
  }

  Future<void> _pickLocation() async {
    final selectedLocation = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(builder: (context) => LocationPickerScreen()),
    );

    if (selectedLocation != null) {
      setState(() {
        _latitudeController.text = selectedLocation.latitude.toString();
        _longitudeController.text = selectedLocation.longitude.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event == null ? 'Tambah Event' : 'Edit Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Judul Event'),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Deskripsi tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Tanggal'),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Tanggal tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _latitudeController,
                decoration: InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value!.isEmpty ? 'Latitude tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _longitudeController,
                decoration: InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value!.isEmpty ? 'Longitude tidak boleh kosong' : null,
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _pickLocation,
                child: Text('Pilih Lokasi di Map'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveEvent,
                child: Text(widget.event == null ? 'Tambah' : 'Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
