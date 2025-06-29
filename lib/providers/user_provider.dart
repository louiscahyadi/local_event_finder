import 'package:flutter/material.dart';
import '../helpers/shared_pref_helper.dart';

class UserProvider with ChangeNotifier {
  String? _username;
  String? _userEmail;

  String? get username => _username;
  String? get userEmail => _userEmail;

  Future<void> login(String email, String password) async {
    if (email == 'admin' && password == '1234') {
      // contoh hardcoded user
      _username = email;
      _userEmail = email;
      await SharedPrefHelper.saveUser(email);
      notifyListeners();
    } else {
      throw ('Username/Password salah');
    }
  }

  Future<void> register(String email, String password) async {
    // simulasi register (tidak simpan ke DB)
    _username = email;
    _userEmail = email;
    await SharedPrefHelper.saveUser(email);
    notifyListeners();
  }

  Future<void> logout() async {
    _username = null;
    _userEmail = null;
    await SharedPrefHelper.logout();
    notifyListeners();
  }

  Future<void> loadUser() async {
    _username = await SharedPrefHelper.getUser();
    notifyListeners();
  }
}
