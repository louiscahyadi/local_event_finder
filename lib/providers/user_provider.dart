import 'package:flutter/material.dart';
// mengimpor package material dari flutter untuk kebutuhan UI dan ChangeNotifier

import '../helpers/shared_pref_helper.dart';
// mengimpor helper shared_pref_helper untuk operasi shared preferences

class UserProvider with ChangeNotifier {
  // mendefinisikan class UserProvider yang menggunakan ChangeNotifier untuk state management

  String? _username;
  // mendeklarasikan variabel privat _username bertipe string nullable untuk menyimpan username

  String? _userEmail;
  // mendeklarasikan variabel privat _userEmail bertipe string nullable untuk menyimpan email user

  String? get username => _username;
  // membuat getter username untuk mengakses nilai _username dari luar class

  String? get userEmail => _userEmail;
  // membuat getter userEmail untuk mengakses nilai _userEmail dari luar class

  Future<void> login(String email, String password) async {
    // membuat method async untuk proses login user
    if (email == 'admin' && password == '1234') {
      // memeriksa jika email dan password sesuai dengan data hardcoded
      _username = email;
      // mengisi _username dengan nilai email
      _userEmail = email;
      // mengisi _userEmail dengan nilai email
      await SharedPrefHelper.saveUser(email);
      // menyimpan username ke shared preferences
      notifyListeners();
      // memberitahu listener bahwa data telah berubah
    } else {
      throw ('Username/Password salah');
      // melempar error jika email atau password salah
    }
  }

  Future<void> register(String email, String password) async {
    // membuat method async untuk proses register user (simulasi, tidak simpan ke DB)
    _username = email;
    // mengisi _username dengan nilai email
    _userEmail = email;
    // mengisi _userEmail dengan nilai email
    await SharedPrefHelper.saveUser(email);
    // menyimpan username ke shared preferences
    notifyListeners();
    // memberitahu listener bahwa data telah berubah
  }

  Future<void> logout() async {
    // membuat method async untuk proses logout user
    _username = null;
    // mengosongkan nilai _username
    _userEmail = null;
    // mengosongkan nilai _userEmail
    await SharedPrefHelper.logout();
    // menghapus username dari shared preferences
    notifyListeners();
    // memberitahu listener bahwa data telah berubah
  }

  Future<void> loadUser() async {
    // membuat method async untuk memuat user dari shared preferences
    _username = await SharedPrefHelper.getUser();
    // mengambil username dari shared preferences dan mengisinya ke _username
    notifyListeners();
    // memberitahu listener bahwa data telah berubah
  }
}
