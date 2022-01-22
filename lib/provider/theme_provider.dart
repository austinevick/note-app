import 'package:flutter/material.dart';
import 'package:fox_note_app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

final darkMode = ThemeData.dark();
final lightDark = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(backgroundColor: defaultColor),
    scaffoldBackgroundColor: defaultColor,
    primaryColor: defaultColor);

class ThemeProvider extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences? _preferences;
  bool? _darkMode = false;

  bool get darkMode => _darkMode!;

  ThemeProvider() {
    _loadFromPreferences();
  }

  _initialPreferences() async {
    if (_preferences == null)
      _preferences = await SharedPreferences.getInstance();
  }

  _savePreferences() async {
    await _initialPreferences();
    _preferences!.setBool(key, _darkMode!);
  }

  _loadFromPreferences() async {
    await _initialPreferences();
    _darkMode = _preferences!.getBool(key) ?? false;
    notifyListeners();
  }

  toggleChangeTheme() {
    _darkMode = !_darkMode!;
    _savePreferences();
    notifyListeners();
  }
}
