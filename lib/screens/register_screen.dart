import 'package:flutter/material.dart';
// mengimpor package flutter material untuk kebutuhan UI

import 'package:provider/provider.dart';
// mengimpor provider untuk state management

import '../providers/user_provider.dart';
// mengimpor user_provider untuk mengakses data user

class RegisterScreen extends StatefulWidget {
  // mendefinisikan class RegisterScreen sebagai StatefulWidget

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
  // mengoverride method createState untuk mengembalikan state
}

class _RegisterScreenState extends State<RegisterScreen> {
  // mendefinisikan state untuk RegisterScreen

  final _formKey = GlobalKey<FormState>();
  // mendeklarasikan GlobalKey untuk form validasi

  final _nameController = TextEditingController();
  // mendeklarasikan controller untuk input nama lengkap

  final _emailController = TextEditingController();
  // mendeklarasikan controller untuk input email

  final _passwordController = TextEditingController();
  // mendeklarasikan controller untuk input password

  final _confirmPasswordController = TextEditingController();
  // mendeklarasikan controller untuk input konfirmasi password

  bool _obscurePassword = true;
  // mendeklarasikan variabel untuk menyembunyikan password

  bool _obscureConfirm = true;
  // mendeklarasikan variabel untuk menyembunyikan konfirmasi password

  @override
  Widget build(BuildContext context) {
    // mengoverride method build untuk membangun UI
    final userProvider = Provider.of<UserProvider>(context);
    // mendapatkan instance UserProvider dari context

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // mengatur warna background appbar menjadi putih
        elevation: 0,
        // menghilangkan bayangan appbar
        leading: BackButton(color: Colors.black),
        // menampilkan tombol kembali dengan warna hitam
        title: Text(
          'Daftar Akun Baru',
          // menampilkan judul appbar
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        // membuat konten bisa discroll jika layar kecil
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          // memberi padding pada konten
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mengatur alignment kolom ke kiri
            children: [
              Container(
                padding: EdgeInsets.all(20),
                // memberi padding pada container form
                decoration: BoxDecoration(
                  color: Colors.white,
                  // mengatur warna background container
                  borderRadius: BorderRadius.circular(12),
                  // mengatur sudut container menjadi bulat
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      // mengatur warna bayangan
                      spreadRadius: 2,
                      // mengatur sebaran bayangan
                      blurRadius: 8,
                      // mengatur blur bayangan
                      offset: Offset(0, 2),
                      // mengatur posisi bayangan
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  // menghubungkan form dengan _formKey untuk validasi
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mengatur alignment kolom ke kiri
                    children: [
                      _buildLabel("Nama Lengkap"),
                      // menampilkan label Nama Lengkap
                      _buildTextField(
                        _nameController,
                        'Masukkan nama lengkap',
                        Icons.person,
                      ),
                      SizedBox(height: 10),
                      // memberi jarak vertikal
                      _buildLabel("Email"),
                      // menampilkan label Email
                      _buildTextField(
                        _emailController,
                        'Masukkan email',
                        Icons.email,
                      ),
                      SizedBox(height: 10),
                      // memberi jarak vertikal
                      _buildLabel("Password"),
                      // menampilkan label Password
                      _buildPasswordField(
                        _passwordController,
                        'Buat password (min. 8 karakter)',
                        _obscurePassword,
                        () {
                          setState(() => _obscurePassword = !_obscurePassword);
                          // mengubah status sembunyikan password
                        },
                      ),
                      SizedBox(height: 10),
                      // memberi jarak vertikal
                      _buildLabel("Konfirmasi Password"),
                      // menampilkan label Konfirmasi Password
                      _buildPasswordField(
                        _confirmPasswordController,
                        'Konfirmasi password',
                        _obscureConfirm,
                        () {
                          setState(() => _obscureConfirm = !_obscureConfirm);
                          // mengubah status sembunyikan konfirmasi password
                        },
                      ),
                      SizedBox(height: 20),
                      // memberi jarak vertikal
                      SizedBox(
                        width: double.infinity,
                        // mengatur lebar tombol penuh
                        child: ElevatedButton(
                          onPressed: () async {
                            // menjalankan aksi saat tombol ditekan
                            if (_formKey.currentState!.validate()) {
                              // memvalidasi form
                              if (_passwordController.text !=
                                  _confirmPasswordController.text) {
                                // memeriksa jika password dan konfirmasi tidak sama
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Password tidak sama"),
                                    // menampilkan pesan error jika password tidak sama
                                  ),
                                );
                                return;
                              }
                              await userProvider.register(
                                _emailController.text,
                                _passwordController.text,
                              );
                              // menjalankan proses register user
                              Navigator.pop(context);
                              // kembali ke halaman sebelumnya setelah register
                            }
                          },
                          child: Text('Daftar'),
                          // menampilkan teks pada tombol
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            // mengatur warna tombol
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              // mengatur sudut tombol
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14),
                            // mengatur padding tombol
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              // memberi jarak vertikal
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mengatur posisi row di tengah
                  children: [
                    Text("Sudah punya akun? "),
                    // menampilkan teks pertanyaan
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      // menjalankan aksi kembali ke halaman login
                      child: Text(
                        "Masuk",
                        // menampilkan teks link masuk
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    // membuat widget untuk menampilkan label dengan tanda *
    return Row(
      children: [
        Text('*', style: TextStyle(color: Colors.red)),
        // menampilkan tanda * berwarna merah
        SizedBox(width: 4),
        // memberi jarak horizontal
        Text(text, style: TextStyle(fontWeight: FontWeight.w500)),
        // menampilkan teks label
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon,
  ) {
    // membuat widget untuk input text dengan icon
    return TextFormField(
      controller: controller,
      validator: (val) => val == null || val.isEmpty ? 'Wajib diisi' : null,
      // validasi agar field tidak kosong
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        // menampilkan icon di input
        hintText: hint,
        // menampilkan hint pada input
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        // mengatur border input
      ),
    );
  }

  Widget _buildPasswordField(
    TextEditingController controller,
    String hint,
    bool obscure,
    VoidCallback toggle,
  ) {
    // membuat widget untuk input password dengan icon dan toggle visibility
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      // mengatur apakah password disembunyikan
      validator:
          (val) => val == null || val.length < 8 ? 'Minimal 8 karakter' : null,
      // validasi agar password minimal 8 karakter
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        // menampilkan icon kunci di input
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          // menampilkan icon visibility sesuai status
          onPressed: toggle,
          // menjalankan fungsi toggle saat icon ditekan
        ),
        hintText: hint,
        // menampilkan hint pada input
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        // mengatur border input
      ),
    );
  }
}
