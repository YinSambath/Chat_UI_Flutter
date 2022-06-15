import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future createState(String key, String value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(key, value);
  }

  Future readState(String key) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var state = _prefs.getString(key);
    return state;
  }

  Future removeState(String key) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove(key);
  }
}
