import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';
import '../models/event.dart';
import '../providers/event_provider.dart';
import 'location_picker_screen.dart';

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
  final _timeController = TextEditingController();
  final _locationController = TextEditingController();
  final _organizerController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _titleController.text = widget.event!.title;
      _descriptionController.text = widget.event!.description;
      _dateController.text = widget.event!.date;
      latitude = widget.event!.latitude;
      longitude = widget.event!.longitude;
      _locationController.text = 'Lat: ${latitude}, Lng: ${longitude}';
    }
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd MMM yyyy').format(pickedDate);
      });
    }
  }

  Future<void> _pickLocation() async {
    final selectedLocation = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(builder: (context) => LocationPickerScreen()),
    );

    if (selectedLocation != null) {
      setState(() {
        latitude = selectedLocation.latitude;
        longitude = selectedLocation.longitude;
        _locationController.text = 'Lat: ${latitude}, Lng: ${longitude}';
      });
    }
  }

  void _saveEvent() {
    if (_formKey.currentState!.validate()) {
      final newEvent = Event(
        id: widget.event?.id,
        title: _titleController.text,
        description: _descriptionController.text,
        date: _dateController.text,
        latitude: latitude ?? 0.0,
        longitude: longitude ?? 0.0,
      );

      final eventProvider = Provider.of<EventProvider>(context, listen: false);

      if (widget.event == null) {
        eventProvider.addEvent(newEvent);
      } else {
        eventProvider.updateEvent(widget.event!.id!, newEvent);
      }

      Navigator.pop(context);
    }
  }

  InputDecoration _inputDecoration(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: '* $label',
      prefixIcon: icon != null ? Icon(icon) : null,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event == null ? 'Tambah Event Baru' : 'Edit Event'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ElevatedButton(
              onPressed: _saveEvent,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Simpan'),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('Tambahkan Foto Event'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            TextFormField(
              controller: _titleController,
              decoration: _inputDecoration('Judul Event', icon: Icons.event),
              validator:
                  (value) => value!.isEmpty ? 'Judul tidak boleh kosong' : null,
            ),
            SizedBox(height: 12),

            TextFormField(
              decoration: _inputDecoration('Kategori', icon: Icons.category),
              validator:
                  (value) =>
                      value!.isEmpty ? 'Kategori tidak boleh kosong' : null,
            ),
            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _pickDate,
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _dateController,
                        decoration: _inputDecoration(
                          'Tanggal',
                        ).copyWith(suffixIcon: Icon(Icons.calendar_today)),
                        validator:
                            (value) =>
                                value!.isEmpty ? 'Tanggal wajib diisi' : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _timeController,
                    decoration: _inputDecoration('Waktu'),
                    validator:
                        (value) => value!.isEmpty ? 'Waktu wajib diisi' : null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _locationController,
                    decoration: _inputDecoration(
                      'Lokasi',
                      icon: Icons.location_on,
                    ),
                    validator:
                        (value) => value!.isEmpty ? 'Lokasi wajib diisi' : null,
                  ),
                ),
                TextButton(onPressed: _pickLocation, child: Text('Pilih')),
              ],
            ),
            SizedBox(height: 12),

            TextFormField(
              controller: _descriptionController,
              decoration: _inputDecoration('Deskripsi'),
              maxLines: 3,
              validator:
                  (value) => value!.isEmpty ? 'Deskripsi wajib diisi' : null,
            ),

            SizedBox(height: 24),
            Text(
              'Informasi Penyelenggara',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            TextFormField(
              controller: _organizerController,
              decoration: _inputDecoration(
                'Nama Penyelenggara',
                icon: Icons.person,
              ),
              validator: (value) => value!.isEmpty ? 'Nama wajib diisi' : null,
            ),
            SizedBox(height: 12),

            TextFormField(
              controller: _contactController,
              decoration: _inputDecoration('Nomor Kontak', icon: Icons.phone),
            ),
            SizedBox(height: 12),

            TextFormField(
              controller: _emailController,
              decoration: _inputDecoration('Email', icon: Icons.email),
            ),
          ],
        ),
      ),
    );
  }
}
