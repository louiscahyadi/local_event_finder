import 'package:flutter/material.dart';
// mengimpor package flutter material untuk kebutuhan UI

import 'package:provider/provider.dart';
// mengimpor provider untuk state management

import '../providers/user_provider.dart';
// mengimpor user_provider untuk mengakses data user

class ProfileScreen extends StatelessWidget {
  // mendefinisikan class ProfileScreen sebagai StatelessWidget

  @override
  Widget build(BuildContext context) {
    // mengoverride method build untuk membangun UI
    return Scaffold(
      // membuat widget Scaffold sebagai kerangka halaman
      appBar: AppBar(
        title: Text('Profil', style: TextStyle(color: Colors.black)),
        // menampilkan judul appbar dengan warna hitam
        backgroundColor: Colors.white,
        // mengatur warna background appbar menjadi putih
        elevation: 0,
        // menghilangkan bayangan appbar
        iconTheme: IconThemeData(color: Colors.black),
        // mengatur warna icon pada appbar menjadi hitam
      ),
      backgroundColor: Colors.white,
      // mengatur warna background halaman menjadi putih
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        // memberi padding pada seluruh isi halaman
        child: Column(
          children: [
            CircleAvatar(
              radius: 48,
              // mengatur ukuran avatar
              backgroundImage: NetworkImage(
                'https://ui-avatars.com/api/?name=User+Profile&background=0D8ABC&color=fff',
                // menampilkan gambar profil dari url avatar
              ),
            ),
            SizedBox(height: 16),
            // memberi jarak vertikal
            Text(
              'Nama Pengguna',
              // menampilkan nama pengguna (sementara hardcode)
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 4),
            // memberi jarak vertikal
            Text('user@email.com', style: TextStyle(color: Colors.grey[600])),
            // menampilkan email pengguna (sementara hardcode)
            SizedBox(height: 24),
            // memberi jarak vertikal
            ListTile(
              leading: Icon(Icons.edit, color: Colors.teal),
              // menampilkan icon edit dengan warna teal
              title: Text('Edit Profil'),
              // menampilkan teks Edit Profil
              onTap: () {},
              // belum ada aksi saat ditekan
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.teal),
              // menampilkan icon settings dengan warna teal
              title: Text('Pengaturan'),
              // menampilkan teks Pengaturan
              onTap: () {},
              // belum ada aksi saat ditekan
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.redAccent),
              // menampilkan icon logout dengan warna merah
              title: Text('Keluar'),
              // menampilkan teks Keluar
              onTap: () async {
                // menjalankan aksi saat tombol keluar ditekan
                final userProvider = Provider.of<UserProvider>(
                  context,
                  listen: false,
                );
                // mendapatkan instance UserProvider dari context
                await userProvider.logout();
                // menjalankan proses logout user
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/login', (route) => false);
                // mengarahkan user ke halaman login dan menghapus semua halaman sebelumnya
              },
            ),
          ],
        ),
      ),
    );
  }
}
