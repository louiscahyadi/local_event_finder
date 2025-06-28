import 'package:flutter/material.dart';
import '../helpers/shared_pref_helper.dart';

class UserProvider with ChangeNotifier {
  String? _username;

  String? get username => _username;

  Future<void> login(String username, String password) async {
    if (username == 'admin' && password == '1234') {
      // contoh hardcoded user
      _username = username;
      await SharedPrefHelper.saveUser(username);
      notifyListeners();
    } else {
      throw ('Username/Password salah');
    }
  }

  Future<void> register(String username, String password) async {
    // simulasi register (tidak simpan ke DB)
    _username = username;
    await SharedPrefHelper.saveUser(username);
    notifyListeners();
  }

  Future<void> logout() async {
    _username = null;
    await SharedPrefHelper.logout();
    notifyListeners();
  }

  Future<void> loadUser() async {
    _username = await SharedPrefHelper.getUser();
    notifyListeners();
  }
}
