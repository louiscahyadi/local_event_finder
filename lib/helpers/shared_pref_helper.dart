import 'package:shared_preferences/shared_preferences.dart';
// mengimpor package shared_preferences untuk menyimpan data sederhana secara lokal

class SharedPrefHelper {
  // mendefinisikan class SharedPrefHelper untuk membantu operasi shared preferences

  static Future<void> saveUser(String username) async {
    // membuat method statis untuk menyimpan username ke shared preferences
    final prefs = await SharedPreferences.getInstance();
    // mendapatkan instance SharedPreferences
    await prefs.setString('username', username);
    // menyimpan nilai username ke dalam shared preferences dengan key 'username'
  }

  static Future<String?> getUser() async {
    // membuat method statis untuk mengambil username dari shared preferences
    final prefs = await SharedPreferences.getInstance();
    // mendapatkan instance SharedPreferences
    return prefs.getString('username');
    // mengambil nilai username dari shared preferences dan mengembalikannya
  }

  static Future<void> logout() async {
    // membuat method statis untuk menghapus username dari shared preferences
    final prefs = await SharedPreferences.getInstance();
    // mendapatkan instance SharedPreferences
    await prefs.remove('username');
    // menghapus nilai username dari shared preferences
  }
}
