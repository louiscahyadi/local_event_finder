import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundImage: NetworkImage(
                'https://ui-avatars.com/api/?name=User+Profile&background=0D8ABC&color=fff',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Nama Pengguna',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 4),
            Text('user@email.com', style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 24),
            ListTile(
              leading: Icon(Icons.edit, color: Colors.teal),
              title: Text('Edit Profil'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.teal),
              title: Text('Pengaturan'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.redAccent),
              title: Text('Keluar'),
              onTap: () async {
                final userProvider = Provider.of<UserProvider>(
                  context,
                  listen: false,
                );
                await userProvider.logout();
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/login', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
