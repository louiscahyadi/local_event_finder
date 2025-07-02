import 'package:flutter/material.dart';
// mengimpor package flutter material untuk kebutuhan UI

import 'package:provider/provider.dart';
// mengimpor provider untuk state management

import 'providers/user_provider.dart';
// mengimpor user_provider untuk mengakses data user

import 'providers/event_provider.dart';
// mengimpor event_provider untuk mengakses data event

import 'screens/login_screen.dart';
// mengimpor screen login

import 'screens/home_screen.dart';
// mengimpor screen home

import 'screens/register_screen.dart';
// mengimpor screen register

void main() {
  // mendefinisikan fungsi utama aplikasi
  runApp(
    // menjalankan aplikasi flutter
    MultiProvider(
      // menggunakan MultiProvider untuk state management global
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUser()),
        // membuat provider untuk UserProvider dan langsung memanggil loadUser
        ChangeNotifierProvider(create: (_) => EventProvider()..loadEvents()),
        // membuat provider untuk EventProvider dan langsung memanggil loadEvents
      ],
      child: MyApp(),
      // menjadikan MyApp sebagai child dari MultiProvider
    ),
  );
}

class MyApp extends StatelessWidget {
  // mendefinisikan class MyApp sebagai StatelessWidget

  @override
  Widget build(BuildContext context) {
    // mengoverride method build untuk membangun UI
    return MaterialApp(
      // membuat widget MaterialApp sebagai root aplikasi
      title: 'Local Event Finder',
      // mengatur judul aplikasi
      debugShowCheckedModeBanner: false,
      // menyembunyikan banner debug
      theme: ThemeData(
        useMaterial3: true,
        // mengaktifkan Material 3
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        // mengatur color scheme aplikasi dengan seed warna biru
      ),
      home: Consumer<UserProvider>(
        // menggunakan Consumer untuk mendapatkan UserProvider
        builder: (context, userProvider, child) {
          // membangun widget berdasarkan perubahan userProvider
          return userProvider.username == null ? LoginScreen() : HomeScreen();
          // jika username null, tampilkan LoginScreen, jika tidak tampilkan HomeScreen
        },
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        // mendefinisikan route untuk halaman login
        '/register': (context) => RegisterScreen(),
        // mendefinisikan route untuk halaman register
      },
    );
  }
}
