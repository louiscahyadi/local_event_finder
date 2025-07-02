import 'dart:io';
// mengimpor library dart:io untuk operasi file (misal gambar)

import 'package:flutter/material.dart';
// mengimpor package flutter material untuk kebutuhan UI

import 'package:intl/intl.dart';
// mengimpor package intl untuk format tanggal

import 'package:provider/provider.dart';
// mengimpor provider untuk state management

import 'package:latlong2/latlong.dart';
// mengimpor latlong2 untuk tipe data LatLng

import 'package:image_picker/image_picker.dart';
// mengimpor image_picker untuk memilih gambar dari galeri

import '../models/event.dart';
// mengimpor model Event

import '../providers/event_provider.dart';
// mengimpor provider EventProvider

import 'location_picker_screen.dart';
// mengimpor screen LocationPickerScreen

const List<String> _kategoriList = [
  'Musik',
  // menambahkan kategori Musik ke list
  'Kuliner',
  // menambahkan kategori Kuliner ke list
  'Olahraga',
  // menambahkan kategori Olahraga ke list
  'Seni',
  // menambahkan kategori Seni ke list
  'Pendidikan',
  // menambahkan kategori Pendidikan ke list
  'Lainnya',
  // menambahkan kategori Lainnya ke list
];

class AddEditEventScreen extends StatefulWidget {
  // mendefinisikan class AddEditEventScreen sebagai StatefulWidget

  final Event? event;
  // mendeklarasikan properti event bertipe Event nullable

  AddEditEventScreen({this.event});
  // membuat konstruktor dengan parameter opsional event

  @override
  _AddEditEventScreenState createState() => _AddEditEventScreenState();
  // mengoverride method createState untuk mengembalikan state
}

class _AddEditEventScreenState extends State<AddEditEventScreen> {
  // mendefinisikan state untuk AddEditEventScreen

  final _formKey = GlobalKey<FormState>();
  // mendeklarasikan GlobalKey untuk form

  final _titleController = TextEditingController();
  // mendeklarasikan controller untuk input judul

  final _descriptionController = TextEditingController();
  // mendeklarasikan controller untuk input deskripsi

  final _dateController = TextEditingController();
  // mendeklarasikan controller untuk input tanggal

  final _timeController = TextEditingController();
  // mendeklarasikan controller untuk input waktu

  final _locationController = TextEditingController();
  // mendeklarasikan controller untuk input lokasi

  final _organizerController = TextEditingController();
  // mendeklarasikan controller untuk input nama penyelenggara

  final _contactController = TextEditingController();
  // mendeklarasikan controller untuk input nomor kontak

  final _emailController = TextEditingController();
  // mendeklarasikan controller untuk input email

  double? latitude;
  // mendeklarasikan variabel latitude bertipe double nullable

  double? longitude;
  // mendeklarasikan variabel longitude bertipe double nullable

  String? _selectedKategori;
  // mendeklarasikan variabel untuk menyimpan kategori yang dipilih

  File? _imageFile;
  // mendeklarasikan variabel untuk menyimpan file gambar

  @override
  void initState() {
    // mengoverride method initState untuk inisialisasi awal
    super.initState();
    if (widget.event != null) {
      // memeriksa jika event tidak null (edit mode)
      _titleController.text = widget.event!.title;
      // mengisi controller judul dengan data event
      _descriptionController.text = widget.event!.description;
      // mengisi controller deskripsi dengan data event
      _dateController.text = widget.event!.date;
      // mengisi controller tanggal dengan data event
      latitude = widget.event!.latitude;
      // mengisi latitude dengan data event
      longitude = widget.event!.longitude;
      // mengisi longitude dengan data event
      _locationController.text = 'Lat: ${latitude}, Lng: ${longitude}';
      // mengisi controller lokasi dengan koordinat event
      // Jika ada field kategori di event, set juga _selectedKategori
      // _selectedKategori = widget.event!.kategori;
    }
  }

  Future<void> _pickDate() async {
    // membuat method untuk memilih tanggal menggunakan date picker
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      // jika user memilih tanggal
      setState(() {
        _dateController.text = DateFormat('dd MMM yyyy').format(pickedDate);
        // mengisi controller tanggal dengan format yang diinginkan
      });
    }
  }

  Future<void> _pickTime() async {
    // membuat method untuk memilih waktu menggunakan time picker
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      // jika user memilih waktu
      setState(() {
        _timeController.text = pickedTime.format(context);
        // mengisi controller waktu dengan format yang diinginkan
      });
    }
  }

  Future<void> _pickLocation() async {
    // membuat method untuk memilih lokasi menggunakan LocationPickerScreen
    final selectedLocation = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(builder: (context) => LocationPickerScreen()),
    );

    if (selectedLocation != null) {
      // jika user memilih lokasi
      setState(() {
        latitude = selectedLocation.latitude;
        // mengisi latitude dengan hasil picker
        longitude = selectedLocation.longitude;
        // mengisi longitude dengan hasil picker
        _locationController.text = 'Lat: ${latitude}, Lng: ${longitude}';
        // mengisi controller lokasi dengan koordinat yang dipilih
      });
    }
  }

  Future<void> _pickImage() async {
    // membuat method untuk memilih gambar dari galeri
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      // jika user memilih gambar
      setState(() {
        _imageFile = File(picked.path);
        // menyimpan file gambar ke variabel _imageFile
      });
    }
  }

  void _saveEvent() {
    // membuat method untuk menyimpan event baru atau update event
    if (_formKey.currentState!.validate()) {
      // memvalidasi form
      final newEvent = Event(
        id: widget.event?.id,
        // menggunakan id event jika edit, null jika tambah baru
        title: _titleController.text,
        // mengambil judul dari controller
        description: _descriptionController.text,
        // mengambil deskripsi dari controller
        date: _dateController.text,
        // mengambil tanggal dari controller
        latitude: latitude ?? 0.0,
        // mengambil latitude, default 0.0 jika null
        longitude: longitude ?? 0.0,
        // mengambil longitude, default 0.0 jika null
        imagePath: _imageFile?.path ?? widget.event?.imagePath,
        // mengambil path gambar baru atau gambar lama
        kategori: _selectedKategori, // aktifkan baris ini
        // mengambil kategori yang dipilih
      );

      final eventProvider = Provider.of<EventProvider>(context, listen: false);
      // mendapatkan instance EventProvider dari context

      if (widget.event == null) {
        // jika tambah event baru
        eventProvider.addEvent(newEvent);
        // menambah event ke provider
      } else {
        eventProvider.updateEvent(widget.event!.id!.toString(), newEvent);
        // mengupdate event di provider
      }

      Navigator.pop(context);
      // menutup halaman setelah simpan
    }
  }

  InputDecoration _inputDecoration(String label, {IconData? icon}) {
    // membuat method untuk menghasilkan dekorasi input field
    return InputDecoration(
      labelText: '* $label',
      // menampilkan label dengan tanda *
      prefixIcon: icon != null ? Icon(icon) : null,
      // menampilkan icon jika ada
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      // membuat border dengan sudut melengkung
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      // mengatur padding konten input
    );
  }

  @override
  Widget build(BuildContext context) {
    // mengoverride method build untuk membangun UI
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event == null ? 'Tambah Event Baru' : 'Edit Event'),
        // menampilkan judul sesuai mode tambah/edit
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            // mengatur padding tombol simpan
            child: ElevatedButton(
              onPressed: _saveEvent,
              // menjalankan method _saveEvent saat ditekan
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                // mengatur warna tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  // mengatur sudut tombol
                ),
              ),
              child: Text('Simpan'),
              // menampilkan teks Simpan pada tombol
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        // menggunakan form dengan key _formKey
        child: ListView(
          padding: const EdgeInsets.all(16),
          // mengatur padding list
          children: [
            GestureDetector(
              onTap: _pickImage,
              // menjalankan _pickImage saat gambar ditekan
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: _pickImage,
                  borderRadius: BorderRadius.circular(12),
                  child: Center(
                    child:
                        _imageFile == null
                            ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt, color: Colors.grey),
                                SizedBox(height: 8),
                                Text('Tambahkan Foto Event'),
                              ],
                            )
                            : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _imageFile!,
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // memberi jarak antar widget
            TextFormField(
              controller: _titleController,
              decoration: _inputDecoration('Judul Event', icon: Icons.event),
              validator:
                  (value) => value!.isEmpty ? 'Judul tidak boleh kosong' : null,
              // validasi agar judul tidak kosong
            ),
            SizedBox(height: 12),

            // Ganti TextFormField kategori dengan DropdownButtonFormField
            DropdownButtonFormField<String>(
              value: _selectedKategori,
              decoration: _inputDecoration('Kategori', icon: Icons.category),
              items:
                  _kategoriList
                      .map(
                        (kategori) => DropdownMenuItem(
                          value: kategori,
                          child: Text(kategori),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedKategori = value;
                  // mengubah kategori yang dipilih
                });
              },
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Kategori tidak boleh kosong'
                          : null,
              // validasi agar kategori tidak kosong
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
                        // validasi agar tanggal tidak kosong
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: _pickTime,
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _timeController,
                        decoration: _inputDecoration(
                          'Waktu',
                        ).copyWith(suffixIcon: Icon(Icons.access_time)),
                        validator:
                            (value) =>
                                value!.isEmpty ? 'Waktu wajib diisi' : null,
                        // validasi agar waktu tidak kosong
                      ),
                    ),
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
                    // validasi agar lokasi tidak kosong
                  ),
                ),
                TextButton(onPressed: _pickLocation, child: Text('Pilih')),
                // tombol untuk memilih lokasi
              ],
            ),
            SizedBox(height: 12),

            TextFormField(
              controller: _descriptionController,
              decoration: _inputDecoration('Deskripsi'),
              maxLines: 3,
              validator:
                  (value) => value!.isEmpty ? 'Deskripsi wajib diisi' : null,
              // validasi agar deskripsi tidak kosong
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
              // validasi agar nama penyelenggara tidak kosong
            ),
            SizedBox(height: 12),

            TextFormField(
              controller: _contactController,
              decoration: _inputDecoration('Nomor Kontak', icon: Icons.phone),
              // input nomor kontak penyelenggara
            ),
            SizedBox(height: 12),

            TextFormField(
              controller: _emailController,
              decoration: _inputDecoration('Email', icon: Icons.email),
              // input email penyelenggara
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildEventImage(Event event) {
  // membuat widget untuk menampilkan gambar event
  return Container(
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      image: DecorationImage(
        image:
            event.imagePath != null
                ? FileImage(File(event.imagePath!))
                // jika ada path gambar, tampilkan gambar dari file
                : AssetImage('assets/default_event.jpg') as ImageProvider,
        // jika tidak ada, tampilkan gambar default
        fit: BoxFit.cover,
        // mengatur gambar agar menutupi seluruh container
      ),
    ),
  );
}
