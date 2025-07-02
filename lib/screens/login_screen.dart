import 'package:flutter/material.dart';
// mengimpor package flutter material untuk kebutuhan UI

import 'package:provider/provider.dart';
// mengimpor provider untuk state management

import '../providers/user_provider.dart';
// mengimpor user_provider untuk mengakses data user

class LoginScreen extends StatefulWidget {
  // mendefinisikan class LoginScreen sebagai StatefulWidget

  @override
  _LoginScreenState createState() => _LoginScreenState();
  // mengoverride method createState untuk mengembalikan state
}

class _LoginScreenState extends State<LoginScreen> {
  // mendefinisikan state untuk LoginScreen

  final _usernameController = TextEditingController();
  // mendeklarasikan controller untuk input username/email

  final _passwordController = TextEditingController();
  // mendeklarasikan controller untuk input password

  String error = '';
  // mendeklarasikan variabel error untuk menampilkan pesan error

  @override
  Widget build(BuildContext context) {
    // mengoverride method build untuk membangun UI
    final userProvider = Provider.of<UserProvider>(context);
    // mendapatkan instance UserProvider dari context

    return Scaffold(
      // membuat widget Scaffold sebagai kerangka halaman
      body: Center(
        // menempatkan konten di tengah layar
        child: SingleChildScrollView(
          // membuat konten bisa discroll jika layar kecil
          padding: const EdgeInsets.symmetric(horizontal: 24),
          // memberi padding horizontal pada konten
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mengatur posisi konten di tengah secara vertikal
            children: [
              CircleAvatar(
                radius: 40,
                // mengatur ukuran avatar
                backgroundColor: Colors.redAccent,
                // mengatur warna background avatar
                child: Icon(Icons.location_on, color: Colors.white, size: 30),
                // menampilkan icon lokasi di dalam avatar
              ),
              SizedBox(height: 16),
              // memberi jarak vertikal
              Text(
                "EventFinder",
                // menampilkan judul aplikasi
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              // memberi jarak vertikal
              Text(
                "Temukan event menarik di sekitar Anda",
                // menampilkan deskripsi aplikasi
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(height: 32),
              // memberi jarak vertikal
              Container(
                padding: const EdgeInsets.all(16),
                // memberi padding pada container form
                decoration: BoxDecoration(
                  color: Colors.white,
                  // mengatur warna background container
                  borderRadius: BorderRadius.circular(12),
                  // mengatur sudut container menjadi bulat
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                  // menambahkan bayangan pada container
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mengatur alignment konten ke kiri
                  children: [
                    Text(
                      "Masuk",
                      // menampilkan judul form login
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    // memberi jarak vertikal
                    TextField(
                      controller: _usernameController,
                      // menghubungkan controller ke input username/email
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        // menampilkan icon email di input
                        hintText: 'Masukkan email Anda',
                        // menampilkan hint pada input
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          // mengatur sudut border input
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    // memberi jarak vertikal
                    TextField(
                      controller: _passwordController,
                      // menghubungkan controller ke input password
                      obscureText: true,
                      // menyembunyikan teks password
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        // menampilkan icon kunci di input
                        hintText: 'Masukkan password Anda',
                        // menampilkan hint pada input
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          // mengatur sudut border input
                        ),
                        suffixIcon: Icon(Icons.visibility_off),
                        // menampilkan icon visibility pada input
                      ),
                    ),
                    SizedBox(height: 8),
                    // memberi jarak vertikal
                    Align(
                      alignment: Alignment.centerRight,
                      // mengatur posisi teks ke kanan
                      child: Text(
                        "Lupa Password?",
                        // menampilkan teks lupa password
                        style: TextStyle(color: Colors.teal, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 16),
                    // memberi jarak vertikal
                    SizedBox(
                      width: double.infinity,
                      // mengatur lebar tombol penuh
                      child: ElevatedButton(
                        onPressed: () async {
                          // menjalankan aksi saat tombol ditekan
                          try {
                            await userProvider.login(
                              _usernameController.text,
                              _passwordController.text,
                            );
                            // menjalankan proses login dengan data input
                          } catch (e) {
                            setState(() => error = e.toString());
                            // menampilkan pesan error jika login gagal
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          // mengatur padding tombol
                          backgroundColor: Colors.redAccent,
                          // mengatur warna tombol
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            // mengatur sudut tombol
                          ),
                        ),
                        child: Text(
                          "Masuk",
                          // menampilkan teks pada tombol
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    if (error.isNotEmpty)
                      // jika ada error, tampilkan pesan error
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(error, style: TextStyle(color: Colors.red)),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // memberi jarak vertikal
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                // menjalankan aksi untuk pindah ke halaman register
                child: Text.rich(
                  TextSpan(
                    text: "Belum punya akun? ",
                    // menampilkan teks pertanyaan
                    children: [
                      TextSpan(
                        text: "Daftar Sekarang",
                        // menampilkan teks link daftar
                        style: TextStyle(color: Colors.teal),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
